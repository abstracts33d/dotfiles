#!/usr/bin/env bash

# TMUX
yay -S tmux

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo 'once Dotfiles are setup'
echo 'do M-a + RT to reload tmux.conf'
echo 'do M-a + I  to install other plugins'