alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

bind '"\e[A": history-search-backward' 2>/dev/null
bind '"\e[B": history-search-forward' 2>/dev/null

export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=
export HISTSIZE=
shopt -s histappend

if [ $(id -u) -eq 0 ];
then # you are root, make the prompt red
  PS1="[\e[01;34m\u @ \h\e[00m]----[\e[01;34m$(pwd)\e[00m]\n\e[01;31m#\e[00m "
else
  PS1="[\e[01;34m\u @ \h\e[00m]----[\e[01;34m$(pwd)\e[00m]\n$ "
fi
