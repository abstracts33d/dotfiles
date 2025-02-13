# General
alias ipv4="dig @resolver4.opendns.com myip.opendns.com +short -4"
alias ipv6="dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6"
alias lvim="nvim"
alias vim='nvim'
alias vi='nvim'
alias v="nvim"


# Chezmoi
alias cmcd="cd $(chezmoi source-path)"
alias cmed="chezmoi edit"
alias cmdiff="chezmoi diff"
alias cma="chezmoi apply"
alias cmadd="chezmoi add"

# Git
alias gb="git branch -v"
alias gbm="git checkout master"
alias gr="git remote -v"
alias gco="git checkout"
alias gs="git status"
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gcm="git commit -m"
alias gpr="git pull --rebase"
alias gprc="git pull --rebase --continue"

# Dev
alias ws="cd $WORKSPACE"
alias std="bundle exec standardrb --fix"

# Coloured output, aliases and good defaults.
alias ls='eza --icons'
alias du='du -csh'
alias df='df -h'
alias grep='grep --color=auto'
alias diff="colordiff -ru"
alias dmesg="dmesg --color"
alias ccat='pygmentize -g'
alias top="htop"
alias gr='grep -RIi --no-messages'
alias rg='rg -uuu'
alias g="git"
alias h="history"
alias q='exit'

# Tmux
alias ta='tmux attach -t'
alias tn='tmux new-session -s '
alias tk='tmux kill-session -t '
alias tl='tmux list-sessions'
alias td='tmux detach'
alias tc='clear; tmux clear-history; clear'

# File associations, i.e. suffix aliases
alias -s {md,markdown,rst,toml,json}=$EDITOR
alias -s git="git clone" # Paste a repository URL in terminal, and have it cloned.
