#!/usr/bin/env bash
mkdir arch-install

curl https://raw.githubusercontent.com/abstracts33d/dotfiles/master/bin/scripts/arch/arch-install.sh > arch-install/arch-install.sh
curl https://raw.githubusercontent.com/abstracts33d/dotfiles/master/bin/scripts/arch/inside-chroot.sh > arch-install/inside-chroot.sh
curl https://raw.githubusercontent.com/abstracts33d/dotfiles/master/bin/scripts/arch/inside-chroot.sh > arch-install/post-reboot.sh

curl https://raw.githubusercontent.com/abstracts33d/dotfiles/master/bin/scripts/arch/arch-install.config > arch-install/arch-install.config
curl https://raw.githubusercontent.com/abstracts33d/dotfiles/master/bin/scripts/arch/packages.config > arch-install/packages.config

chmod +x arch-install/arch-install.sh
chmod +x arch-install/inside-chroot.sh
chmod +x arch-install/post-reboot.sh