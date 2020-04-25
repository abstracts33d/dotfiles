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
    echo "${YAY_PACKAGE_LIST[@]}"
    yay -S "${YAY_PACKAGE_LIST[@]}"
}

function packages_configuration() {
    # SDDM
    echo "Enabling SDDM services"
    sudo systemctl enable sddm.service
    # REPTYR
    echo "Enabling REPTYR usage"
    sudo bash -c 'echo "kernel.yama.ptrace_scope=0" > /etc/sysctl.d/10-ptrace.conf'
    # DOCKER
    echo "Adding ${USER_NAME} to docker group"
    sudo usermod -aG docker $USER_NAME
    # TODO COMPLETE THIS SECTION WITH DATABASES ETC...
    echo "You will need to initialize databases systems etc..."
}

function MAIN() {
    source ~/arch-install/arch-install.config
    source ~/arch-install/packages.config
    install_packages
    install_yay
    install_yay_packages
    packages_configuration
    echo "Configuration done. You can now exit chroot and reboot."
    echo "You will now have a fully working bootable Arch Linux system installed."
    echo "Have fun :)"
}

MAIN
