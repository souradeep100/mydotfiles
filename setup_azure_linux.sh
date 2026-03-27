#!/usr/bin/env bash
set -Eeuo pipefail

# Azure Linux 3 bootstrap with auto-resolving package names
# Email: souradch@gmail.com

MYHOME="${HOME}"
BASE="${PWD}"

log() { echo -e "\n[setup] $*\n"; }
warn() { echo -e "\n[setup][WARN] $*\n" >&2; }

have() { command -v "$1" >/dev/null 2>&1; }

# -------------------------
# Package manager abstraction
# -------------------------
PM=""
if have tdnf; then PM="tdnf"; fi
if [[ -z "${PM}" ]] && have dnf; then PM="dnf"; fi

pm_update_upgrade() {
  if [[ "${PM}" == "tdnf" ]]; then
    sudo tdnf -y makecache
    sudo tdnf -y update
  else
    sudo dnf -y makecache
    sudo dnf -y upgrade
  fi
}

pm_install() {
  # args are packages
  if [[ "${PM}" == "tdnf" ]]; then
    sudo tdnf -y install "$@"
  else
    sudo dnf -y install "$@"
  fi
}

pm_info() {
  # returns 0 if package exists in repos (best-effort)
  if [[ "${PM}" == "tdnf" ]]; then
    tdnf info "$1" >/dev/null 2>&1
  else
    dnf info "$1" >/dev/null 2>&1
  fi
}

pm_search() {
  # keyword search
  if [[ "${PM}" == "tdnf" ]]; then
    tdnf search "$1" 2>/dev/null || true
  else
    dnf search "$1" 2>/dev/null || true
  fi
}

pm_provides() {
  # file/capability provides lookup
  if [[ "${PM}" == "tdnf" ]]; then
    # tdnf supports "provides" as well in RPM-based distros [2](https://vmware.github.io/photon/docs-v4/administration-guide/managing-packages-with-tdnf/standard-syntax-for-tndf/commands/)
    tdnf provides "$1" 2>/dev/null || true
  else
    dnf provides "$1" 2>/dev/null || true  # documented command [3](https://dnf.readthedocs.io/en/latest/command_ref.html)
  fi
}

# Extract package name from provides output (tdnf and dnf differ slightly)
first_pkg_from_provides() {
  # best-effort parsing:
  # - dnf provides prints "name-ver-rel.arch : ..." lines
  # - tdnf provides prints similar lines (often "name.arch : ...")
  awk '
    /^[[:alnum:]_.+-]+-[0-9]/ {print $1; exit}   # dnf style name-ver...
    /^[[:alnum:]_.+-]+\.[[:alnum:]_+-]+[[:space:]]*:/ {gsub(/:.*/,"",$1); print $1; exit} # tdnf style name.arch:
  ' | sed -E 's/\.[^.]+$//'  # drop .arch if present
}

# Extract package candidates from search output
pkgs_from_search() {
  # tdnf search output is usually "name.arch  ..."; dnf includes sections.
  awk '
    /^[[:alnum:]_.+-]+\.[[:alnum:]_+-]+/ {print $1}
    /^[[:alnum:]_.+-]+[[:space:]]*:/ {gsub(/:.*/,"",$1); print $1}
  ' | sed -E 's/\.[^.]+$//' | awk 'NF' | head -n 30
}

# Score candidates; prefer exact match, then prefix/substring matches
best_match_from_list() {
  local want="$1"; shift
  awk -v want="$want" '
    BEGIN{best="";bestscore=-1}
    {
      cand=$0
      score=0
      if (cand==want) score=100
      else if (index(cand,want)==1) score=80
      else if (index(cand,want)>0) score=60
      else score=10
      if (score>bestscore){bestscore=score;best=cand}
    }
    END{ if (best!="") print best; }
  ' <<<"$(printf "%s\n" "$@")"
}

# -------------------------
# Auto-resolving installer
# -------------------------
install_resolving() {
  # install_resolving <original_name> [<alias1> <alias2> ...]
  local orig="$1"; shift
  local aliases=("$@")

  log "Installing: ${orig}"

  # 1) Try direct install
  if pm_install "${orig}" >/dev/null 2>&1; then
    log "Installed (direct): ${orig}"
    return 0
  fi

  # 2) Try aliases (explicit equivalents)
  for a in "${aliases[@]}"; do
    if [[ -n "$a" ]] && pm_install "$a" >/dev/null 2>&1; then
      log "Installed (alias): ${orig} -> ${a}"
      return 0
    fi
  done

  # 3) Heuristics: Debian/Ubuntu patterns to RPM patterns
  # -dev -> -devel
  if [[ "${orig}" =~ -dev$ ]]; then
    local devel="${orig%-dev}-devel"
    if pm_install "${devel}" >/dev/null 2>&1; then
      log "Installed (heuristic): ${orig} -> ${devel}"
      return 0
    fi
    # libfoo-dev -> foo-devel
    if [[ "${orig}" =~ ^lib.+-dev$ ]]; then
      local base="${orig#lib}"
      base="${base%-dev}"
      if pm_install "${base}-devel" >/dev/null 2>&1; then
        log "Installed (heuristic): ${orig} -> ${base}-devel"
        return 0
      fi
      if pm_install "lib${base}-devel" >/dev/null 2>&1; then
        log "Installed (heuristic): ${orig} -> lib${base}-devel"
        return 0
      fi
    fi
  fi

  # 4) Repo search by keyword: try multiple derived keywords
  # Use stripped tokens to improve search results
  local kw1="${orig}"
  local kw2="${orig#lib}"; kw2="${kw2%-dev}"; kw2="${kw2%-devel}"
  local kw3="${orig%-dev}"; kw3="${kw3%-devel}"

  for kw in "$kw1" "$kw2" "$kw3"; do
    [[ -z "$kw" ]] && continue
    local hits
    hits="$(pm_search "$kw")"
    local cands
    cands="$(pkgs_from_search <<<"$hits")"
    if [[ -n "$cands" ]]; then
      # choose best match among candidates
      local best
      best="$(best_match_from_list "$kw" $(printf "%s\n" $cands))"
      if [[ -n "$best" ]] && pm_install "$best" >/dev/null 2>&1; then
        log "Installed (search): ${orig} -> ${best} (keyword: ${kw})"
        return 0
      fi
    fi
  done

  # 5) File provides lookup (most reliable) - only if we can guess a file
  # For command-like packages, try /usr/bin/<name> after stripping prefixes
  # Example: "cscope" -> /usr/bin/cscope
  local bin_guess="${orig}"
  bin_guess="${bin_guess#python3-}"
  bin_guess="${bin_guess#lib}"
  bin_guess="${bin_guess%-dev}"
  bin_guess="${bin_guess%-devel}"

  local prov
  prov="$(pm_provides "/usr/bin/${bin_guess}")"
  if [[ -n "$prov" ]]; then
    local pkg
    pkg="$(first_pkg_from_provides <<<"$prov")"
    if [[ -n "$pkg" ]] && pm_install "$pkg" >/dev/null 2>&1; then
      log "Installed (provides): ${orig} -> ${pkg} (from /usr/bin/${bin_guess})"
      return 0
    fi
  fi

  warn "FAILED to resolve/install: ${orig}"
  return 1
}

# -------------------------
# Main flow
# -------------------------
if [[ -z "${PM}" ]]; then
  echo "Neither tdnf nor dnf found. This doesn't look like Azure Linux / RPM-based image."
  exit 1
fi

log "Using package manager: ${PM}"
log "Updating OS packages..."
pm_update_upgrade

# Optional: if you want to use dnf for richer queries, install it when on tdnf-based systems.
# (Some environments do this for debugging.) [4](https://github.com/microsoft/Docker-Provider/blob/ci_prod/MARINER.md)
if [[ "${PM}" == "tdnf" ]] && ! have dnf; then
  log "Installing dnf (optional helper)..."
  pm_install dnf >/dev/null 2>&1 || true
fi

log "Installing core tools (auto-resolving names)..."

# Map Ubuntu/Debian names to Azure Linux equivalents via aliases
install_resolving build-essential "make" "gcc" "gcc-c++"
install_resolving python3 "python3"
install_resolving python3-pip "python3-pip"
install_resolving python3-venv "python3-venv" "python3-virtualenv"
install_resolving ipython3 "python3-ipython" "ipython" "python3-IPython"
install_resolving vim "vim"
install_resolving universal-ctags "universal-ctags" "ctags"
install_resolving cscope "cscope"
install_resolving git "git"
install_resolving tmux "tmux"
install_resolving zsh "zsh"
install_resolving curl "curl"

# Kernel/build deps equivalents
install_resolving fakeroot "fakeroot"
install_resolving ncurses-dev "ncurses-devel" "ncurses"
install_resolving xz-utils "xz" "xz-devel"
install_resolving libssl-dev "openssl-devel" "openssl"
install_resolving bc "bc"
install_resolving flex "flex"
install_resolving libelf-dev "elfutils-libelf-devel" "elfutils-libelf"
install_resolving bison "bison"
install_resolving dwarves "dwarves"
install_resolving cmake "cmake"

# ssh-keygen comes from OpenSSH client packages on RPM distros
install_resolving openssh-client "openssh-clients" "openssh"

# ---- fzf ----
log "Installing fzf..."
cd "${MYHOME}"
if [[ ! -d "${MYHOME}/.fzf" ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "${MYHOME}/.fzf"
fi
"${MYHOME}/.fzf/install" --all || true

# ---- Rust + ripgrep + fd-find ----
log "Installing Rust toolchain..."
if [[ ! -d "${MYHOME}/.cargo" ]]; then
  curl -fsSL https://sh.rustup.rs | sh -s -- -y
fi
# shellcheck disable=SC1090
source "${MYHOME}/.cargo/env"

log "Installing ripgrep and fd-find via cargo..."
cargo install ripgrep || true
cargo install fd-find || true

# ---- Starship ----
log "Installing Starship..."
curl -fsSL https://starship.rs/install.sh | sh -s -- -y || true

# ---- vim-plug ----
log "Installing vim-plug..."
curl -fLo "${MYHOME}/.vim/autoload/plug.vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# ---- Copy dotfiles if missing ----
log "Copying dotfiles if missing..."
if [[ ! -e "${MYHOME}/.vimrc" ]] && [[ -e "${BASE}/.vimrc" ]]; then
  cp -f "${BASE}/.vimrc" "${MYHOME}/"
fi
if [[ ! -e "${MYHOME}/.tmux.conf" ]] && [[ -e "${BASE}/.tmux.conf" ]]; then
  cp -f "${BASE}/.tmux.conf" "${MYHOME}/"
fi

# ---- SSH key ----
log "Ensuring SSH key exists..."
if [[ ! -e "${MYHOME}/.ssh/id_rsa.pub" ]]; then
  mkdir -p "${MYHOME}/.ssh"
  ssh-keygen -t rsa -b 4096 -f "${MYHOME}/.ssh/id_rsa" -N ""
fi

log "Done."
cd "${BASE}"
