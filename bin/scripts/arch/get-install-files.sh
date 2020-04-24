#!/usr/bin/env bash

curl https://raw.githubusercontent.com/abstracts33d/dotfiles/master/bin/scripts/arch/arch-install.sh > arch-install.sh
curl https://raw.githubusercontent.com/abstracts33d/dotfiles/master/bin/scripts/arch/inside-chroot.sh > inside-chroot.sh
curl https://raw.githubusercontent.com/abstracts33d/dotfiles/master/bin/scripts/arch/after-reboot.sh > after-reboot.sh

chmod +x arch-install.sh
chmod +x inside-chroot.sh
chmod +x after-reboot.sh

curl https://raw.githubusercontent.com/abstracts33d/dotfiles/master/bin/scripts/arch/arch-install.config > arch-install.config
curl https://raw.githubusercontent.com/abstracts33d/dotfiles/master/bin/scripts/arch/packages.config > packages.config