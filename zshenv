# EXPORT ENVIRONMENT VARIABLES
export ZDOTDIR=$HOME/.zsh

export LD_LIBRARY_PATH="/opt/intel/mediasdk/lib"
export JAVA_HOME=/usr/lib/jvm/default
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'
export GPG_TTY=$(tty)

[[ $TMUX = "" ]] && export TERM="xterm-256color"

export GH_USER="ToBeSET"
export GH_PASS="ToBeSET"

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/bin/scripts"