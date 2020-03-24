#!/usr/bin/env bash

backup() {
  target=$1
  if [ -e "$target" ]; then           # Does the config file already exist?
    if [ ! -L "$target" ]; then       # as a pure file?
      mv "$target" "$target.backup"   # Then backup it
      echo "☠☠☠ Moved your old $target config file to $target.backup"
    fi
  fi
}

symlink() {
  source=$1
  target=$2
  if [ ! -e "$target" ]; then                   # Does the config file already exist?
    echo "☠☠☠ Symlinking your new $target"
    ln -s "$source" "$target"                   # Then symlink it
  fi
}

for name in *; do
  if [ ! -d "$name" ]; then
    target="$HOME/.$name"
    if [[ ! "$name" =~ '\.sh$' ]] && [ "$name" != 'README.md' ] && [[ ! "$name" =~ '\.sublime-settings$' ]]; then
      backup $target
      symlink "$PWD/$name" "$target"
    fi
  else
    if [[ "$name" == 'scripts' ]]; then
      target="$HOME/bin/$name"
      if [ ! -d "$HOME/bin" ]; then
        echo "☠☠☠ Creating $HOME/bin"
        mkdir -p "$HOME/bin"
      fi
      backup $target
      symlink "$PWD/$name" "$target"
    fi
  fi
done

REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"

# zsh ~/.zshrc

echo "👌  Carry on with git setup!"
