#!/bin/bash

chroot $TEMPMOUNT /bin/bash -c "apt -y update"

chroot $TEMPMOUNT /bin/bash -c "apt dist-upgrade -y && echo '---> apt dist-upgrade succeeded <--------------------------------------------------------------' || { echo 'apt dist-upgrade failed'; exit 1; }" || exit 1

chroot $TEMPMOUNT /bin/bash -c "apt install -y dpkg-dev linux-headers-amd64 linux-image-amd64 systemd-sysv firmware-linux && echo '---> apt install dpkg-dev linux-headers-amd64 linux-image-amd64 systemd-sysv firmware-linux succeeded <--------------------------------------------------------------' || { echo 'apt install dpkg-dev linux-headers-amd64 linux-image-amd64 systemd-sysv firmware-linux failed'; exit 1; }" || exit 1

if [ -n "$ZFS" ]
then
    chroot $TEMPMOUNT /bin/bash -c "apt install -y zfs-dkms zfsutils-linux zfs-zed dracut-core zfs-dracut kexec-tools libconfig-inifiles-perl libsort-versions-perl libboolean-perl fzf mbuffer spl-dkms && echo '---> apt install zfs-dkms zfsutils-linux zfs-zed dracut-core zfs-dracut kexec-tools kexec-tools libconfig-inifiles-perl libsort-versions-perl libboolean-perl fzf mbuffer succeeded <--------------------------------------------------------------' || { echo 'apt install zfs-dkms zfsutils-linux zfs-zed dracut-core zfs-dracut kexec-tools kexec-tools kexec-tools libconfig-inifiles-perl libsort-versions-perl libboolean-perl fzf mbuffer failed'; exit 1; }" || exit 1
fi


if [ -n "$BIOS" ] 
then
    chroot $TEMPMOUNT /bin/bash -c "apt -y install refind dracut-network dropbear && echo '---> apt install refind dracut-network dropbear succeeded <--------------------------------------------------------------' || apt -y install refind dracut-network dropbear failed'; exit 1; }" || exit 1
elif [ -n "$EFI" ]
then
    chroot $TEMPMOUNT /bin/bash -c "apt -y install refind efibootmgr dracut-network dropbear && echo '---> apt install refind efibootmgr dracut-network dropbear succeeded <--------------------------------------------------------------' || { echo 'apt install refind efibootmgr dracut-network dropbear failed'; exit 1; }" || exit 1
fi

chroot $TEMPMOUNT /bin/bash -c "apt -y install locales vim git rsync dosfstools openssh-server curl patch apt-file software-properties-common apt-transport-https && echo '---> apt install locales vim git rsync dosfstools openssh-server curl patch apt-file software-properties-common apt-transport-https succeeded <--------------------------------------------------------------' || { echo 'apt install locales vim git rsync dosfstools openssh-server curl patch apt-file software-properties-common apt-transport-https failed'; exit 1; }" || exit 1

if [ -n "$SECUREBOOT" ]
then
    chroot $TEMPMOUNT /bin/bash -c "apt -y install shim shim-signed && echo '---> apt install shim-signed succeeded <--------------------------------------------------------------' || { echo 'apt install shim-signed failed'; exit 1; }" || exit 1
fi
