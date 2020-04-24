#!/usr/bin/env bash

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

function post_package_install() {
    # Post Package install configurations
    
    # REPTYR
    echo "Enabling REPTYR usage"
    sudo bash -c 'echo "kernel.yama.ptrace_scope=0" > /etc/sysctl.d/10-ptrace.conf'
    
    # DATABASES
    # psql
    echo "Initializing PSQL database cluster"
    sudo -iu postgres
    initdb -D /var/lib/postgres/data
    createuser $USER_NAME --createdb --createrole --replication --superuser
    echo "User ${$USER_NAME} created without password"
    exit
    #mysql
    echo "Initializing MYSQL database cluster"
    sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    sudo systemctl start mariadb.service
    echo "You will need to create a regular user"
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
    post_package_install
    enable_services
    echo "Packages succesfully installed and configured"
}

MAIN

