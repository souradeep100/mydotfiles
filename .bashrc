# .bashrc


export TERM=xterm-256color
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

#[ -z "$PS1" ] && return

#PS1='\u@\h \W > '

function parse_git_branch {
	  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
  }
#echo -ne "\e]1;$HOST\a"
#export PS1='\[\033[0;31m\]\u \[\033[1;36m\]\w $(parse_git_branch)\n\[\033[1;32m\]> \[\033[00m\]'
eval "$(starship init bash)"
