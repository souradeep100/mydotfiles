# Path to your oh-my-bash installation.
#export OSH=/home/schakrabarti-ubuntu/.oh-my-bash
export PATH="${HOME}/.local/bin:$PATH" 
stty -ixon
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
#OSH_THEME="simple"
export USERPAT=yqkxlk35c5hj5ilvfttt4w24pugd3gmsszaaorjklwrpnmylplda
export AZURE_DEVOPS_EXT_PAT=$USERPAT
PROMPT_DIRTRIM=2
alias vim=nvim
alias vi=nvim
alias ls='ls --color=auto'
export PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$"
export USERPAT_MSAZURE=$USERPAT
export USERPAT_DEVDIV=ifgog24lknqo5q5qm3hxur2abjyktt425gsu7nrerkbo763j2btq
export USERPAT_CLOUDES=yod6dshlf3yausaytjupdw7egb457mlnkc5furarqummsooukw2q
export USERPAT_MSFT=5ksfx5jgnb737qe3bbxvbtae3al3xmuk67w3anwjqkvpp4d3tnwa
export USERPAT_AZURECSISE=fvypet2ruuicv5srdedoez6agvf3ly25ma2a7knlfr27zemm4azq
export USERPAT_RACKMANAGER=ytcw7bxz7bdfdjlttq63mvkxlaeahdmdfym7m3s5o2kxhmrligda
az devops configure -d project=LSG-linux
az devops configure -d organization=https://msazure.visualstudio.com
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
#completions=(
#  git
#  composer
#  ssh
#)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
#aliases=(
#  general
#)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(
#  git
#  bashmarks
#)

#source $OSH/oh-my-bash.sh
set -o vi
# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/datadrive/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/datadrive/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/datadrive/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/datadrive/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

