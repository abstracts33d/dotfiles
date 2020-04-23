function profzsh() {
    shell=${1-$SHELL}
    ZPROF=true $shell
    exit
}