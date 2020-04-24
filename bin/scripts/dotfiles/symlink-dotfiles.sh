#!/usr/bin/env bash

backup() {
    target=$1
    if [ -e "$target" ]; then             # Does the config file already exist?
        if [ ! -L "$target" ]; then       # as a pure file?
            mv "$target" "$target.backup" # Then backup it
            echo "☠☠☠ Moved your old $target config file to $target.backup"
        fi
    fi
}

symlink() {
    source_file=$1
    target=$2
    if [ ! -e "$target" ]; then                 # Does the config file already exist?
        echo "☠☠☠ Symlinking your new $target"
        ln -s "$source_file" "$target"          # Then symlink it
    fi
}


destination="$HOME"

pushd $HOME/dotfiles >>/dev/null 2>&1

# Symlink antigenrc
if [ ! -f "zsh/.antigenrc" ]; then
    read -p "Is this machine a personal(0) or server(1) computer (default: 0) ?" HOST_TYPE
    HOST_TYPE=${HOST_TYPE:-0}
    if [[ $HOST_TYPE == "0" ]]; then
        symlink "$PWD/zsh/.antigenrc.personal" "$PWD/zsh/.antigenrc"
    else
        symlink "$PWD/zsh/.antigenrc.server" "$PWD/zsh/.antigenrc"
    fi
fi

for name in *; do
    target="$destination/.$name"
    if [ "$name" != 'README.md' ] && \
    [ "$name" != 'other-locations' ] &&
    [ "$name" != 'plasma' ] && \
    [ "$name" != 'bin' ]
    then
        backup $target
        symlink "$PWD/$name" "$target"
        
    elif [ "$name" == 'other-locations' ]
    then
        pushd $name >>/dev/null 2>&1
        for subname in * .[^.]*; do
            if [ "$subname" != '*' ]; then
                target="$destination/"
                cp -rs "$PWD/$subname" "$target"
            fi
        done
        popd >>/dev/null 2>&1
        
    elif [ "$name" == 'bin' ];
    then
        target="$destination/$name"
        backup $target
        symlink "$PWD/$name" "$target"
    fi
done
popd >>/dev/null 2>&1