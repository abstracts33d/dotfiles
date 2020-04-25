#!/usr/bin/env bash


REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"
RED="\\033[1;31m"
BLUE="\\033[1;34m"

function log() {
    echo -e $1$2$REGULAR
}

log $BLUE "Setting up dotfiles"

pushd $HOME/dotfiles/bin/scripts/dotfiles  >>/dev/null 2>&1

log $BLUE "Setting up languages versions managers"
source setup-langs-versions-managers.sh
log $BLUE "Symlinking dotfiles"
source symlink-dotfiles.sh
log $BLUE "Installing fzf"
$HOME/.fzf/install
ln -s $HOME/dotfiles/fzf.zsh $HOME/.fzf.zsh
log $BLUE "Setting up git"
source setup-git.sh

popd >>/dev/null 2>&1

log $GREEN "👌  dotfiles setup complete"
