function install_packages() {
    echo "Installing packages"
    echo "${PACKAGE_LIST[@]}"
    sudo pacman -Syu --noconfirm --needed "${PACKAGE_LIST[@]}"
}

function install_yay() {
    echo "Installing Yay"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
}

function install_yay_packages() {
    echo "Installing AUR packages with Yay"
    echo "${YAY_PACKAGES[@]}"
    yay -S "${YAY_PACKAGES[@]}"
}

function enable_services() {
    echo "Enabling services"
    sudo systemctl enable sddm.service
    sudo systemctl enable NetworkManager.service
}

function MAIN() {
    source arch-install.config
    source packages.config
    install_packages
    install_yay
    install_yay_packages
    enable_services
    echo "Configuration done. You can now exit chroot."
}

MAIN

