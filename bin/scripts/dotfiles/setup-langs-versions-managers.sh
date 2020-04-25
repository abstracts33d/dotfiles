#!/usr/bin/env bash


REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"
RED="\\033[1;31m"
BLUE="\\033[1;34m"

function log() {
    echo -e $1$2$REGULAR
}

function get_latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                              # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                      # Pluck JSON value
}

# NVM
echo "${BLUE}Installing nvm"
NVM_VERSION=$(get_latest_release "nvm-sh/nvm")
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

echo "${BLUE}Loading nvm"
export NVM_DIR="$HOME/.nvm" && \. "$NVM_DIR/nvm.sh"
echo "${BLUE}Linking default-packages"
ln -s $HOME/dotfiles/other-locations/.nvm/default-packages $NVM_DIR/default-packages
echo "${BLUE}Installing latest node version"
nvm install node # install node (for load-nvmrc)

# PYENV
log $BLUE "Installing pyenv"
PYENV_ROOT="$HOME/.pyenv"
git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv
git clone https://github.com/jawshooah/pyenv-default-packages.git $PYENV_ROOT/plugins/pyenv-default-packages
git clone https://github.com/momo-lab/pyenv-install-latest.git $PYENV_ROOT/plugins/pyenv-install-latest
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile

log $BLUE "Loading pyenv"
export PYENV_ROOT="$HOME/.pyenv" && export PATH="$PYENV_ROOT/bin:$PATH" && eval "$(pyenv init -)"
log $BLUE "Linking default-packages"
ln -s $HOME/dotfiles/other-locations/.pyenv/default-packages $PYENV_ROOT/default-packages
log $BLUE "Installing latest 3 & 2.7 versions"
pyenv install-latest
pyenv install-latest 2.7
log $BLUE "Setting pyenv global version to latest 3 && 2.7 versions"
pyenv global $(pyenv versions |sed '/^*/d' | sort -rn | xargs)

# RBENV
log $BLUE "Installing ruby dependencies"
yay -S tklib zlib openssl libffi libxml2 libxslt readline
log $BLUE "Installing rbenv"
RBENV_ROOT="$HOME/.rbenv"
git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT
git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build
git clone https://github.com/rbenv/rbenv-default-gems.git $RBENV_ROOT/plugins/rbenv-default-gems
git clone https://github.com/momo-lab/rbenv-install-latest.git "$(rbenv root)"/plugins/rbenv-install-latest
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"'

log $BLUE "Loading rbenv"
export PATH="$HOME/.rbenv/bin:$PATH" && eval "$(rbenv init -)"
log $BLUE "Linking default-gems"
ln -s $HOME/dotfiles/other-locations/.rbenv/default-gems $RBENV_ROOT/default-gems
log $BLUE "Installing latest ruby version"
rbenv install-latest
log $BLUE "Setting global version to latest"
rbenv global $(rbenv versions)