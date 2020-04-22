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

# create_dir_if_not_present(){
#     dir=$1
#     if [ ! -d "$dir" ]; then
#         echo "☠☠☠ Creating $dir"
#         mkdir -p "$dir"
#     fi
# }

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
for name in *; do
    target="$destination/.$name"
    if [ "$name" != 'README.md' ] && \
    [ "$name" != 'other-locations' ] &&
    [ "$name" != 'bin' ]; then
        backup $target
        symlink "$PWD/$name" "$target"

    elif [ "$name" == 'other-locations' ]; then
        pushd $name >>/dev/null 2>&1
        for subname in * .[^.]*; do
            if [ "$subname" != '*' ] ; then
                target="$destination/"
                cp -rs "$PWD/$subname" "$target"
            fi
        done
        popd >>/dev/null 2>&1

    elif [ "$name" == 'bin' ]; then
        target="$destination/$name"
        backup $target
        symlink "$PWD/$name" "$target"
    fi
done
popd >>/dev/null 2>&1