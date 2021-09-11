#!/bin/bash

chroot $TEMPMOUNT /bin/bash -c "apt -y update"

chroot $TEMPMOUNT /bin/bash -c "apt dist-upgrade --yes && echo '---> apt dist-upgrade succeeded <--------------------------------------------------------------' || { echo 'apt dist-upgrade failed'; exit 1; }" || exit 1

chroot $TEMPMOUNT /bin/bash -c "apt install -y ubuntu-standard && echo '---> apt install ubuntu-standard succeeded <--------------------------------------------------------------' || { echo 'apt install ubuntu-standard failed'; exit 1; }" || exit 1

chroot $TEMPMOUNT /bin/bash -c "apt install -y linux-image-generic && echo '---> apt install linux-image-generic succeeded <--------------------------------------------------------------' || { echo 'apt install linux-image-generic failed'; exit 1; }" || exit 1

if [ -n "$ZFS" ]
then
    chroot $TEMPMOUNT /bin/bash -c "apt install -y zfs-initramfs zsys && echo '---> apt install zfs-initramfs zfs-doc zfs-dracut zsys succeeded <--------------------------------------------------------------' || { echo 'apt install zfs-initramfs zfs-doc zfs-dracut zsys failed'; exit 1; }" || exit 1
fi


if [ -n "$BIOS" ] 
then
    chroot $TEMPMOUNT /bin/bash -c "apt -y install grub-pc && echo '---> apt install grub-pc succeeded <--------------------------------------------------------------' || apt -y install grub-pc failed'; exit 1; }" || exit 1
elif [ -n "$EFI" ]
then
    chroot $TEMPMOUNT /bin/bash -c "apt -y install grub-efi-amd64 grub-efi-amd64-signed && echo '---> apt install grub-efi-amd64 grub-efi-amd64-signed succeeded <--------------------------------------------------------------' || { echo 'apt install grub-efi-amd64 grub-efi-amd64-signed failed'; exit 1; }" || exit 1
fi

chroot $TEMPMOUNT /bin/bash -c "apt -y install rsync dosfstools openssh-server curl patch apt-file update-manager-core software-properties-common apt-transport-https && echo '---> apt install rsync dosfstools openssh-server zsh curl patch apt-file update-manager-core software-properties-common apt-transport-https succeeded <--------------------------------------------------------------' || { echo 'apt install rsync dosfstools openssh-server zsh curl patch apt-file update-manager-core software-properties-common apt-transport-https failed'; exit 1; }" || exit 1

if [ -n "$SECUREBOOT" ]
then
    chroot $TEMPMOUNT /bin/bash -c "apt -y install shim shim-signed && echo '---> apt install shim-signed succeeded <--------------------------------------------------------------' || { echo 'apt install shim-signed failed'; exit 1; }" || exit 1
fi

chroot $TEMPMOUNT /bin/bash -c "apt -y remove --purge os-prober"