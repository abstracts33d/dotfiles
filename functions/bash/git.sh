
function ghUpdate() {
    if git remote | grep upstream > /dev/null; then
        echo "upstream is set"
        elif [ -z "$1" ]; then
        read "?Whats the URl of the original repo? " answer
        git remote add upstream $answer
    else
        git remote add upstream $1
    fi
    git fetch upstream
    git checkout master
    git rebase upstream/master
}

function ghPages(){
    if [ -z "$1" ]
    then
        read "Which folder do you want to deploy to GitHub Pages?" answer
        git subtree push --prefix $answer origin gh-pages
    else
        git subtree push --prefix $1 origin gh-pages
    fi
}