envs() {
    ENV_CURRENT_PATH=$PWD
    ENV_FOLDER_NAME=${PWD##*/}
    ENV_ACTION=
    ENV_TYPES=("" ".prod" ".docker" ".prod.docker")
    ENV_SELECTED_TYPES=()
    
    while getopts "n:gprs:h" opt; do
        case $opt in
            n)  ENV_ACTION=new
            ENV_TARGET=$OPTARG;;
            g)  ENV_ACTION=get;;
            p)  ENV_ACTION=push;;
            r)  ENV_ACTION=reload;;
            s)  ENV_ACTION=switch
            ENV_TARGET=$OPTARG;;
            h)  ENV_ACTION=help
        esac
    done
    
    case $ENV_ACTION in
        new)
            echo "ENVS: creating new envs"
            case $ENV_TARGET in
                e)    ENV_SELECTED_TYPES=("");;
                ep)  ENV_SELECTED_TYPES=("" ".prod");;
                epd) ENV_SELECTED_TYPES=("" ".prod" ".docker" ".prod.docker");;
            esac
            cd ~/dotenvs
            for TYPE in "${ENV_SELECTED_TYPES[@]}"; do
                cp "./template/.env$TYPE" "$ENV_FOLDER_NAME.env$TYPE" || true
                ln -s "$HOME/dotenvs/$ENV_FOLDER_NAME.env$TYPE" "$ENV_CURRENT_PATH/.env$TYPE" || true
            done
            cd $ENV_CURRENT_PATH
        ;;
        
        get)
            echo "ENVS: importing envs"
            for TYPE in "${ENV_TYPES[@]}"; do
                if [ -f "$HOME/dotenvs/$ENV_FOLDER_NAME.env$TYPE" ]; then
                    ln -s "$HOME/dotenvs/$ENV_FOLDER_NAME.env$TYPE" "$ENV_CURRENT_PATH/.env$TYPE" || true
                fi
            done
        ;;
        
        push)
            echo "ENVS: pushing envs"
            cd "$HOME/dotenvs"
            git add .
            git commit -m "update envs"
            git push origin master
        ;;
        
        reload)
            echo "ENVS: reloading envs"
            cd ..;
            cd $ENV_CURRENT_PATH
        ;;
        
        switch)
            echo "ENVS: switching to $ENV_TARGET ENV"
            case $ENV_TARGET in
                env)         export ZSH_DOTENV_FILE=.env;;
                docker)      export ZSH_DOTENV_FILE=.env.docker;;
                prod)        export ZSH_DOTENV_FILE=.env.prod;;
                prod.docker) export ZSH_DOTENV_FILE=.env.prod.docker;;
            esac
            cd ..
            cd $ENV_CURRENT_PATH
        ;;
        
        help)
            echo "Environment managment utility"
            echo "Usage:"
            echo "$ envs -n <e, ep, epd>"
            echo "  > create a new env in dotfiles"
            echo "$ envs -g"
            echo "  > get existing env from dotfiles"
            echo "$ envs -p"
            echo "  > push envs to dotfiles repo"
            echo "$ envs -r"
            echo "  > reload env"
            echo "$ envs -s <env, docker, prod, prod.docker>"
            echo "  > switch env"
        ;;
        
        *)
            echo "No action provided use envs -h to get help"
        ;;
    esac
}