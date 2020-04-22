#! /bin/bash

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
    echo "Wiping Device"
    wipe_all_partitions
    dd if=/dev/zero of="$INSTALL_TARGET" bs=1M count=1
    flush
    probe_partition
}

# to create the partitions programatically (rather than manually)
# https://superuser.com/a/984637
function create_partitions() {
    echo "Creating Partitions"
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
    echo "Creating LVM PG VG LV"
    get_lvm_partition_number
    pvcreate "${INSTALL_TARGET}${LVM_PART_NUMBER}"
    vgcreate $VG_NAME "${INSTALL_TARGET}${LVM_PART_NUMBER}"
    lvcreate -L $LV_ROOT_SIZE -n root $VG_NAME
    lvcreate -L $LV_HOME_SIZE -n home $VG_NAME
    lvcreate -L $LV_SWAP_SIZE -n swap $VG_SWAP
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
    echo "Formating partitions"
    format_boot_partition
    create_and_enable_swap
    mkswap /dev/$VG_NAME/swap
    mkfs -t $OTHERS_PART_TYPE "/dev/${VG_NAME}/root"
    mkfs -t $OTHERS_PART_TYPE "/dev/${VG_NAME}/home"
}

function setup_time() {
    echo "Setting up time"
    timedatectl set-ntp true
}

function initialize_pacman_keyring() {
    echo "Initializing pacman keyring"
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
    echo "Mounting partitions"
    mount_root_partion_and_create_dirs
    mount_boot_partition
    mount /dev/$VG_NAME/home /mnt/home
    swapon /dev/$VG_NAME/swap
}

function install_arch() {
    echo "Starting install.."
    echo "Installing Arch Linux, lvm, zsh, vim and GRUB2 as bootloader"
    pacstrap /mnt \
    base base-devel linux linux-firmware pacman-contrib \
    grub os-prober intel-ucode efibootmgr \
    netctl wpa-supplicant wifi-menu \
    lvm2 \
    zsh \
    git \
    vim
}

function generate_fstab() {
    echo "Generating fstab"
    genfstab -U /mnt >> /mnt/etc/fstab
}

function copy_chroot_needed_files() {
    echo "Copying files in chroot environment"
    cp -rfv inside-chroot.sh /mnt
    chmod a+x /mnt/inside-chroot.sh
    cp -rfv after-reboot.sh /mnt
    chmod a+x /mnt/after-reboot.sh
    cp -rfv arch-install.config /mnt
    cp -rfv packages.config /mnt
}

function chroot() {
    echo "After chrooting into newly installed OS, please run the inside-chroot.sh script by executing ./inside-chroot.sh"
    echo "Press any key to chroot..."
    read tmpvar
    arch-chroot /mnt /bin/bash
}

function MAIN() {
    source arch-install.config
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