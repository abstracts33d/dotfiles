# ZSH CONFIGS FILE ORDER AND CONDITIONS
# .zshenv
# → [.zprofile if login]
# → [.zshrc if interactive]
# → [.zlogin if login]
# → [.zlogout sometimes]

# PROFZSH
if [[ "$ZPROF" = true ]]; then
    zmodload zsh/zprof
fi

# CHECK IF ON DESKTOP OR SERVER
MY_HOSTS=("KracH")
if [[ ${MY_HOSTS[(ie)$HOST]} -le ${#MY_HOSTS} ]]; then
    echo ' ☠ Welcome this is one of your PERSONAL machine'
    HOST_TYPE=personal
    ZSH_POWERLEVEL_VERSION=10
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
else
    echo ' ☠ Welcome this is one of your SERVER machine'
    HOST_TYPE=server
    ZSH_POWERLEVEL_VERSION=9
    echo ' ☠ Loading .zserver'
    source $ZDOTDIR/.zserver
fi


# LOAD KEY-BINDINGS
source $ZDOTDIR/.zbindings

# POWERLEVEL9K/POWERLEVEL10K
# 9k config must be sourced before initialization
if [[ $ZSH_POWERLEVEL_VERSION == 9 ]]; then
    [[ ! -f ~/.p9k.zsh ]] || source ~/.p9k.zsh
fi

# LOAD FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf-tab/fzf-tab.plugin.zsh ] && source ~/.fzf-tab/fzf-tab.plugin.zsh # here because need to be loaded before other plugins

# LOAD ANTIGEN
echo ' ☠ Loading Antigen'
export ANTIGEN_PATH=$ZDOTDIR/antigen
export ANTIGEN_COMPDUMPFILE=$ZDOTDIR/.zcompdump-KracH-5.8
source $ANTIGEN_PATH/antigen.zsh
typeset -a ANTIGEN_CHECK_FILES=($ZDOTDIR/.zshrc $ZDOTDIR/.antigenrc) # for bundle reloading
antigen init $ZDOTDIR/.antigenrc


# 10k config must be sourced before initialization
# To customize prompt, run `p10k configure`
if [[ $ZSH_POWERLEVEL_VERSION == 10 ]]; then
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

# ADD ZSH HOOK TO AUTOMATICALY SWITCH NODE VERSIONS WITH NVM
if [[ $HOST_TYPE == personal ]] ; then
    echo ' ☠ Loading automatic NVM switching'
    autoload -U add-zsh-hook
    load-nvmrc() {
        local node_version="$(nvm version)"
        local nvmrc_path="$(nvm_find_nvmrc)"
        
        if [ -n "$nvmrc_path" ]; then
            local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
            
            if [ "$nvmrc_node_version" = "N/A" ]; then
                nvm install
                elif [ "$nvmrc_node_version" != "$node_version" ]; then
                nvm use
            fi
            elif [ "$node_version" != "$(nvm version default)" ]; then
            echo "Reverting to nvm default version"
            nvm use default
        fi
    }
    add-zsh-hook chpwd load-nvmrc
    load-nvmrc
fi

# ADD PLUGIN FORGOTTEN VARS
export RBENV_ROOT=$(rbenv root)
export PYENV_ROOT=$(pyenv root)
export NVM_ROOT=$NVM_DIR

# SOURCE ALIASES
echo ' ☠ Loading Aliases'
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# SOURCE FUNCTIONS
echo ' ☠ Loading Functions'
[[ -d "$HOME/bin/functions" ]] && for f in $HOME/bin/functions/*; do source $f; done

# VI MODE
bindkey -v
export KEYTIMEOUT=1 # kill the lag

# PROFZSH
if [[ "$ZPROF" = true ]]; then
    zprof
fi