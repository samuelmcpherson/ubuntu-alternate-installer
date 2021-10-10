#!/bin/bash

chroot $TEMPMOUNT /bin/bash -c "apt -y update"

chroot $TEMPMOUNT /bin/bash -c "apt dist-upgrade --yes && echo '---> apt dist-upgrade succeeded <--------------------------------------------------------------' || { echo 'apt dist-upgrade failed'; exit 1; }" || exit 1

chroot $TEMPMOUNT /bin/bash -c "apt install -y --no-install-recommends linux-image-generic linux-headers-generic linux-firmware && echo '---> apt install linux-image-generic linux-headers-generic linux-firmware succeeded <--------------------------------------------------------------' || { echo 'apt install linux-image-generic linux-headers-generic linux-firmware failed'; exit 1; }" || exit 1

if [ -n "$ZFS" ]
then

    chroot $TEMPMOUNT /bin/bash -c "apt install --yes --no-install-recommends dkms wget"

    chroot $TEMPMOUNT /bin/bash -c "apt install -y zfs-dkms zfs-zed zfsutils-linux zfs-initramfs && echo '---> apt install zfs-dkms zfs-zed zfsutils-linux succeeded <--------------------------------------------------------------' || { echo 'apt install zfs-initramfs zfs-doc zfs-dracut zsys failed'; exit 1; }" || exit 1
fi


if [ -n "$BIOS" ] 
then
    chroot $TEMPMOUNT /bin/bash -c "apt -y install git refind kexec-tools dpkg-dev libconfig-inifiles-perl libsort-versions-perl libboolean-perl fzf mbuffer dracut-core && echo '---> apt install refind kexec-tools dpkg-dev libconfig-inifiles-perl libsort-versions-perl libboolean-perl fzf mbuffer succeeded <--------------------------------------------------------------' || apt -y install refind kexec-tools dpkg-dev libconfig-inifiles-perl libsort-versions-perl libboolean-perl fzf mbuffer failed'; exit 1; }" || exit 1
elif [ -n "$EFI" ]
then
    chroot $TEMPMOUNT /bin/bash -c "apt -y install git refind kexec-tools dpkg-dev libconfig-inifiles-perl libsort-versions-perl libboolean-perl fzf mbuffer efibootmgr dracut-core && echo '---> apt install refind kexec-tools dpkg-dev libconfig-inifiles-perl libsort-versions-perl libboolean-perl fzf mbuffer efibootmgr succeeded <--------------------------------------------------------------' || { echo 'apt install refind kexec-tools dpkg-dev libconfig-inifiles-perl libsort-versions-perl libboolean-perl fzf mbuffer efibootmgr failed'; exit 1; }" || exit 1
fi

chroot $TEMPMOUNT /bin/bash -c "apt -y install rsync dosfstools openssh-server curl patch apt-file update-manager-core software-properties-common apt-transport-https && echo '---> apt install rsync dosfstools openssh-server curl patch apt-file update-manager-core software-properties-common apt-transport-https succeeded <--------------------------------------------------------------' || { echo 'apt install rsync dosfstools openssh-server curl patch apt-file update-manager-core software-properties-common apt-transport-https failed'; exit 1; }" || exit 1

if [ -n "$SECUREBOOT" ]
then
    chroot $TEMPMOUNT /bin/bash -c "apt -y install shim shim-signed && echo '---> apt install shim-signed succeeded <--------------------------------------------------------------' || { echo 'apt install shim-signed failed'; exit 1; }" || exit 1
fi

#chroot $TEMPMOUNT /bin/bash -c "apt -y remove --purge os-prober"
