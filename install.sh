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

create_dir_if_not_present(){
    dir=$1
    if [ ! -d "$dir" ]; then
        echo "☠☠☠ Creating $dir"
        mkdir -p "$dir"
    fi
}

echo "☠☠☠ SYMLINKING CONFIGS TO $HOME"
for name in *; do
    if [ ! -d "$name" ]; then
        target="$HOME/.$name"
        
        if [[ ! "${name: -3}" == ".sh" ]] && [ "$name" != 'README.md' ]; then
            backup $target
            symlink "$PWD/$name" "$target"
        fi
    else
        if [[ "$name" == 'scripts' ]]; then
            echo "☠☠☠ SYMLINKING SCRIPTS TO $HOME/bin/$name"
            create_dir_if_not_present "$HOME/bin"
            target="$HOME/bin/$name"
            backup $target
            symlink "$PWD/$name" "$target"
        fi
        if [[ "$name" == 'git-templates' ]]; then
            echo "☠☠☠ SYMLINKING GIT-TEMPLATES TO $HOME/.$name"
            target="$HOME/.$name"
            backup $target
            symlink "$PWD/$name" "$target"
        fi
        if [[ "$name" == 'other-locations' ]]; then
            echo "☠☠☠ SYMLINKING TO OTHER-LOCATIONS"
            cd $name
            for other_location_name in *; do
                if [[ "$other_location_name" == 'node-default-packages' ]]; then
                    if [ -z "$NVM_DIR" ]; then
                        create_dir_if_not_present "$HOME/.nvm"
                        target="$HOME/.nvm/default-packages"
                    else
                        target="$NVM_DIR/default-packages"
                    fi
                    backup $target
                    symlink "$PWD/$other_location_name" "$target"
                fi
                if [[ "$other_location_name" == 'python-default-packages' ]]; then
                    if [ -z "$(pyenv root)" ]; then
                        create_dir_if_not_present "$HOME/.pyenv"
                        target="$HOME/.pyenv/default-packages"
                    else
                        target="$(pyenv root)/default-packages"
                    fi
                    backup $target
                    symlink "$PWD/$other_location_name" "$target"
                fi
                if [[ "$other_location_name" == 'default-gems' ]]; then
                    if [ -z "$(rbenv root)" ]; then
                        create_dir_if_not_present "$HOME/.rbenv"
                        target="$HOME/.rbenv/$other_location_name"
                    else
                        target="$(rbenv root)/$other_location_name"
                    fi
                    backup $target
                    symlink "$PWD/$other_location_name" "$target"
                fi
                if [[ "$other_location_name" == 'settings.json' ]]; then
                    create_dir_if_not_present "$HOME/.config/Code - OSS/User" # need double quotes to escape spaces correctly
                    target="$HOME/.config/Code - OSS/User/$other_location_name"
                    backup "$target" # need double quotes to escape spaces correctly
                    symlink "$PWD/$other_location_name" "$target"
                fi
            done
            cd ..
        fi
    fi
done

REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"

# zsh ~/.zshrc

echo "👌  Carry on with git setup!"
