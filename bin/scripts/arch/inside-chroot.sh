#!/usr/bin/env bash

function set_date_time() {
    echo "Setting date time"
    ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
    hwclock --systohc
}

function generate_and_set_locales() {
    echo "Generating and setting locale"
    sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
    sed -i '/fr_FR.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
    locale-gen
    echo "LANG=en_US.UTF-8" >> /etc/locale.conf
}


function set_console() {
    echo "Setting console keymap"
    echo "KEYMAP=fr-latin9" > /etc/vconsole.conf
}

function rank_mirrors() {
    echo "Ranking pacman mirrors"
    mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.dist
    rankmirrors -n 6 /etc/pacman.d/mirrorlist.dist > /etc/pacman.d/mirrorlist
}

function set_hostname() {
    echo 'Setting Hostname'
    echo "${HOST_NAME}" >> /etc/hostname
    echo "127.0.1.1 ${HOST_NAME}.localdomain  ${HOST_NAME}" >> /etc/hosts
}

function add_lvm2_hook() {
    sed -i '/^HOOKS.*lvm2.*$/b; s/^\(HOOKS.*\) \(filesystems.*\)$/\1 lvm2 \2/' /etc/mkinitcpio.conf
}

function generate_intiramfs() {
    echo 'Generating initramfs'
    add_lvm2_hook
    mkinitcpio -P
}

function set_root_password() {
    echo 'Setting Root Password'
    echo root:$ROOT_PASSWORD | chpasswd
}

function install_bootloader() {
    echo 'Installing and configuring bootloader'
    if [[ $PARTITIONING_SCHEME = "UEFI-GPT" ]];then
        grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch
        grub-mkconfig -o /boot/grub/grub.cfg
    else
        grub-install --target=i386-pc /dev/sdb
        grub-mkconfig -o /boot/grub/grub.cfg
    fi
}

function create_new_user() {
    echo "Creating new user ${USER_NAME}"
    useradd -m -G wheel,power,input,storage,uucp,network -s /usr/bin/zsh $USER_NAME
    sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+ALL\)/\1/' /etc/sudoers
    echo $USER_NAME:$ROOT_PASSWORD | chpasswd
}


function customize_pacman() {
    echo "Enabling multilib repo"
    cat /etc/pacman.conf | sed -e '/^#\[multilib\]$/ {
    N; /\n#Include/ {
        s/^#//
        s/\n#/\n/
      }
    }' > /tmp/pacman.conf
    cat /tmp/pacman.conf > /etc/pacman.conf
    rm /tmp/pacman.conf
    
    echo "Enabling Color"
    sudo sed --in-place 's/^#\s*\(Color\)/\1/' /etc/pacman.conf
    pacman -Syu --noconfirm --needed
}

function MAIN() {
    source arch-install.config
    set_date_time
    generate_and_set_locales
    set_console
    rank_mirrors
    set_hostname
    generate_intiramfs
    set_root_password
    install_bootloader
    create_new_user
    customize_pacman
    echo "Configuration done. You can now exit chroot and reboot."
    echo "After rebooting run after-reboot.sh script by executing ./after-reboot.sh"
    echo "You will now have a fully working bootable Arch Linux system installed."
    echo "Have fun :)"
}

MAIN