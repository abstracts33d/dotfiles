#!/usr/bin/env bash

REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"
RED="\\033[1;31m"
BLUE="\\034[1;31m"


pushd $HOME/dotfiles  >>/dev/null 2>&1
source tooling/setup-langs-versions-managers.sh
source tooling/setup-fzf.sh
source tooling/setup-oh-my-zsh.sh
source symlink-dotfiles.sh
source setup-git.sh
popd $HOME/dotfiles  >>/dev/null 2>&1

echo  "${GREEN}👌  dotfiles setup complete"
