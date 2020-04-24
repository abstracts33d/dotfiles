#!/usr/bin/env bash

REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"
RED="\\033[1;31m"
BLUE="\\034[1;31m"


pushd $HOME/dotfiles/bin/scripts/dotfiles  >>/dev/null 2>&1

# setup languages versions managers
source setup-langs-versions-managers.sh
# symlink dotfiles
source symlink-dotfiles.sh
# setup tmux tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# install fzf
$HOME/.fzf/install
# setup git
source setup-git.sh

popd >>/dev/null 2>&1

echo  "${GREEN}👌  dotfiles setup complete"
