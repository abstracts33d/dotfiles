#!/usr/bin/env bash

get_latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                              # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                      # Pluck JSON value
}

# NVM
NVM_VERSION=$(get_latest_release "nvm-sh/nvm")
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

export NVM_DIR="$HOME/.nvm"
\. "$NVM_DIR/nvm.sh"
nvm install node # install node (for load-nvmrc)

# PYENV
PYENV_ROOT="$HOME/.pyenv"
git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv
git clone https://github.com/jawshooah/pyenv-default-packages.git $PYENV_ROOT/plugins/pyenv-default-packages

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile

echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile

# RBENV
yay -S tklib zlib openssl libffi libxml2 libxslt readline

RBENV_ROOT="$HOME/.rbenv"

git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT
git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build
git clone https://github.com/rbenv/rbenv-default-gems.git $RBENV_ROOT/plugins/rbenv-default-gems

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"'