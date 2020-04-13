# Setup fzf
# ---------
if [[ ! "$PATH" == */home/seed/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/seed/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/seed/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/seed/.fzf/shell/key-bindings.zsh"
