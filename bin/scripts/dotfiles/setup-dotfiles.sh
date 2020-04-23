#!/usr/bin/env bash

REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"
RED="\\033[1;31m"
BLUE="\\034[1;31m"


pushd $HOME/dotfiles/bin/scripts/dotfiles  >>/dev/null 2>&1
source setup-tmux.sh
source setup-langs-versions-managers.sh
source setup-fzf.sh
source setup-oh-my-zsh.sh
source symlink-dotfiles.sh
source setup-git.sh
popd >>/dev/null 2>&1

echo  "${GREEN}👌  dotfiles setup complete"
