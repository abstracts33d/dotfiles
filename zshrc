# Load oh-my-zsh
export ZSH="~/.oh-my-zsh"
export ZSH_CUSTOM="~/oh-my-zsh/custom"
ZSH_THEME="agnoster"
export LD_LIBRARY_PATH="/opt/intel/mediasdk/lib"

plugins=(
	ruby
	rbenv
	rails
	bundler
	nvm
	dotenv
	git
	gitfast
	common-aliases
	zsh-syntax-highlighting
	history-substring-search
	shrink-path
	docker
	yarn
	archlinux
)

source $ZSH/oh-my-zsh.sh


# if nvm not installed 
if ! type "nvm" > /dev/null || ! type "nvm_find_nvmrc" > /dev/null; then
  echo "Skiping automatic nvm switching nvm or nvm_find_nvmrc not installed"
else
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

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Export env variables
export JAVA_HOME=/usr/lib/jvm/default
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim'
export GPG_TTY=$(tty)
export TERM=xterm-256color

# Add ~/bin to path
export PATH="$PATH:~/bin"

# CUSTOMIZE POWERLEVEL9K
# Only use if not in a login shell
if ! [[ -o login ]]; then
  # Only use icons if inside gnome-terminal
  if [ -n "${VTE_VERSION}" ]; then
    POWERLEVEL9K_MODE='awesome-fontconfig'
  fi
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs nvm rbenv virtualenv)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status ssh root_indicator background_jobs history os_icon)
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  POWERLEVEL9K_SHORTEN_STRATEGY=truncate_folders
  POWERLEVEL9K_SHORTEN_DELIMITER=""
  source $ZSH_CUSTOM/themes/powerlevel10k/powerlevel10k.zsh-theme
fi

