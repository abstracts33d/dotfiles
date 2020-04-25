#!/usr/bin/env bash

REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"
RED="\\033[1;31m"
BLUE="\\033[1;34m"

function log() {
    echo -e $1$2$REGULAR
}

function print_config() {
    echo "INSTALL_TARGET:      $INSTALL_TARGET"
    echo "PARTITIONING_SCHEME: $PARTITIONING_SCHEME"
    echo "BOOT_PART_TYPE:      $BOOT_PART_TYPE"
    echo "OTHERS_PART_TYPE:    $OTHERS_PART_TYPE"
    echo "VG_NAME:             $VG_NAME"
    echo "LV_ROOT_SIZE:        $LV_ROOT_SIZE"
    echo "LV_HOME_SIZE:        $LV_HOME_SIZE"
    
    echo "ROOT_PASSWORD:       $ROOT_PASSWORD"
    echo "USER_NAME:           $USER_NAME"
    echo "USER_PASSWORD:       $USER_PASSWORD"
}

function setup_network() {
    read -p 'Are you connected to internet? [y/N]: ' neton
    if ! [ $neton = 'y' ] && ! [ $neton = 'Y' ]
    then
        echo "Connect to internet to continue..."
        exit
    fi
}

function fs_warning() {
    echo "This script will format the $INSTALL_TARGET partition "
    
    read -p 'Continue? [y/N]: ' fsok
    if ! [ $fsok = 'y' ] && ! [ $fsok = 'Y' ]
    then
        echo "Edit the script to continue..."
        exit
    fi
}

function get_all_partitions() {
    lsblk -l -n -o NAME -x NAME "$INSTALL_TARGET" | grep "^$(basename $INSTALL_TARGET)" | grep -v "^$(basename $INSTALL_TARGET)$"
}

function flush() {
    sync
    sync
    sync
}

function probe_partition() {
    partprobe "$INSTALL_TARGET"
}

function wipe_all_partitions() {
    for i in $( get_all_partitions | sort -r ); do
        umount "$( dirname $INSTALL_TARGET)/$i"
        dd if=/dev/zero of="$( dirname $INSTALL_TARGET)/$i" bs=1M count=1
    done
    flush
}

function wipe_device() {
    log $BLUE "Wiping Device"
    wipe_all_partitions
    dd if=/dev/zero of="$INSTALL_TARGET" bs=1M count=1
    flush
    probe_partition
}

# to create the partitions programatically (rather than manually)
# https://superuser.com/a/984637
function create_partitions() {
    log $BLUE "Creating Partitions"
    eval "create_partitions_$PARTITIONING_SCHEME"
    probe_partition
}

function create_partitions_MBR() {
    sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${INSTALL_TARGET}
        o # create new MBR partition table
        n # new partition
        p # primary partition
        1 # partition number 1
            # default - start at beginning of disk
        +512M # 512 MB boot partition
        n # new partition
        p # primary partition
        2 # partion number 2
            # default, start immediately after preceding partition
            # default, extend partition to end of disk
        t # to change file system
        2 # partion number 2
        8e # for Linux LVM
        a # make a partition bootable
        1 # bootable partition is partition 1 -- /dev/sda1
        p # print the in-memory partition table
        w # write the partition table
        q # and we're done
EOF
}

function create_partitions_BIOS-GPT() {
    sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${INSTALL_TARGET}
        g # create new GPT partition table
        n # new partition
        1 # partition number 1
        # default - start at beginning of disk
        +1M # 1 MB boot partition
        t # to change the partition type
        4 # for BIOS file system
        n # new partition
        2 # partition number 2
        # default - start at beginning of disk
        +512M # 512 MB boot partition
        t # to change file system
        2 # partion number 2
        31 # for Linux Extended boot
        n # new partition
        3 # partion number 3
        # default, start immediately after preceding partition
        # default, extend partition to end of disk
        t # to change file system
        3 # partion number 3
        30 # for Linux LVM
        p # print the in-memory partition table
        w # write the partition table
        q # and we're done
EOF
}

function create_partitions_UEFI-GPT() {
    sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${INSTALL_TARGET}
        g # create new GPT partition table
        n # new partition
        1 # partition number 1
            # default - start at beginning of disk
        +512M # 512 MB boot partition
        t # to change file system
        1 # for EFI System
        n # new partition
        2 # partion number 2
            # default, start immediately after preceding partition
            # default, extend partition to end of disk
        t # to change file system
        2 # partion number 2
        30 # for Linux LVM
        p # print the in-memory partition table
        w # write the partition table
        q # and we're done
EOF
}

function get_boot_partition_number() {
    case "$PARTITIONING_SCHEME" in
        MBR | UEFI-GPT)
            BOOT_PART_NUMBER=1
        ;;
        BIOS-GPT)
            BOOT_PART_NUMBER=2
        ;;
    esac
}

function get_lvm_partition_number() {
    get_boot_partition_number
    LVM_PART_NUMBER=$(($BOOT_PART_NUMBER + 1))
}

function create_lvm() {
    log $BLUE "Creating LVM PG VG LV"
    get_lvm_partition_number
    pvcreate "${INSTALL_TARGET}${LVM_PART_NUMBER}"
    vgcreate $VG_NAME "${INSTALL_TARGET}${LVM_PART_NUMBER}"
    lvcreate -L $LV_SWAP_SIZE -n swap $VG_NAME
    lvcreate -L $LV_ROOT_SIZE -n root $VG_NAME
    lvcreate -L $LV_HOME_SIZE -n home $VG_NAME
}

# Format the BOOT partition
function format_boot_partition() {
    get_boot_partition_number
    case "$PARTITIONING_SCHEME" in
        MBR | UEFI-GPT)
            eval "mkfs.fat -F32 ${INSTALL_TARGET}${BOOT_PART_NUMBER}"
        ;;
        BIOS-GPT)
            mkfs -t $BOOT_PART_TYPE "${INSTALL_TARGET}${BOOT_PART_NUMBER}"
        ;;
    esac
}

function format_partitions() {
    log $BLUE "Formating partitions"
    format_boot_partition
    mkswap "/dev/${VG_NAME}/swap"
    mkfs -t $OTHERS_PART_TYPE "/dev/${VG_NAME}/root"
    mkfs -t $OTHERS_PART_TYPE "/dev/${VG_NAME}/home"
}

function setup_time() {
    log $BLUE "Setting up time"
    timedatectl set-ntp true
}

function initialize_pacman_keyring() {
    log $BLUE "Initializing pacman keyring"
    pacman-key --init
    pacman-key --populate archlinux
    pacman-key --refresh-keys
}

function mount_root_partion_and_create_dirs() {
    mount /dev/$VG_NAME/root /mnt
    mkdir /mnt/{home,boot}
    [[ $PARTITIONING_SCHEME = "UEFI-GPT" ]] && mkdir /mnt/boot/efi
}

function mount_boot_partition() {
    if [[ $PARTITIONING_SCHEME = "UEFI-GPT" ]];then
        BOOT_PARTITION_MOUNT_POINT=/mnt/boot/efi
    else
        BOOT_PARTITION_MOUNT_POINT=/mnt/boot
    fi
    
    if [[ $PARTITIONING_SCHEME = "BIOS-GTP" ]];then
        mount "${INSTALL_TARGET}${BOOT_PART_NUMBER}" /mnt/boot
    else
        mount "${INSTALL_TARGET}${BOOT_PART_NUMBER}" $BOOT_PARTITION_MOUNT_POINT
    fi
}

function mount_partitions() {
    log $BLUE "Mounting partitions"
    mount_root_partion_and_create_dirs
    mount_boot_partition
    mount /dev/$VG_NAME/home /mnt/home
    swapon /dev/$VG_NAME/swap
}

function install_arch() {
    log $BLUE "Starting install.."
    log $BLUE "Installing Arch Linux, lvm, zsh, vim and GRUB2 as bootloader"
    pacstrap /mnt "${PACSTRAP_LIST[@]}"
}

function generate_fstab() {
    log $BLUE "Generating fstab"
    genfstab -U /mnt >> /mnt/etc/fstab
}

function copy_chroot_needed_files() {
    log $BLUE "Copying files in chroot environment"
    mkdir /mnt/arch-install
    cp -rfv arch-install.sh /mnt/arch-install
    cp -rfv inside-chroot.sh /mnt/arch-install
    cp -rfv after-reboot.sh /mnt/arch-install
    
    cp -rfv arch-install.config /mnt/arch-install
    cp -rfv packages.config /mnt/arch-install
    
    chmod a+x /mnt/arch-install/arch-install.sh
    chmod a+x /mnt/arch-install/inside-chroot.sh
    chmod a+x /mnt/arch-install/after-reboot.sh
}

function chroot() {
    log $GREEN "Preinstall done"
    echo "After chrooting into newly installed OS, please run the inside-chroot.sh script by executing cd arch-install && ./inside-chroot.sh"
    echo "Press any key to chroot..."
    log $BLUE "Chrooting"
    read tmpvar
    arch-chroot /mnt /bin/bash
}

function MAIN() {
    source /arch-install/arch-install.config
    source /arch-installpackages.config
    print_config
    setup_network
    fs_warning
    wipe_device
    create_partitions
    create_lvm
    format_partitions
    setup_time
    initialize_pacman_keyring
    mount_partitions
    install_arch
    generate_fstab
    copy_chroot_needed_files
    chroot
}

MAIN