#!/bin/bash


#chroot $TEMPMOUNT /bin/bash -c "zpool set cachefile=/etc/zfs/zpool.cache bpool"

#chroot $TEMPMOUNT /bin/bash -c "zpool set cachefile=/etc/zfs/zpool.cache rpool"

chroot $TEMPMOUNT /bin/bash -c "update-initramfs -c -k all"
 
chroot $TEMPMOUNT /bin/bash -c "update-grub"

if [ -n "$BIOS" ] 
then
    chroot $TEMPMOUNT /bin/bash -c "grub-install --recheck --no-floppy $DISK1"
elif [ -n "$EFI" ]
then
    chroot $TEMPMOUNT /bin/bash -c "grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ubuntu --recheck --no-floppy"
fi

chroot $TEMPMOUNT /bin/bash -c "systemctl mask grub-initrd-fallback.service"


if [ -n "$ZFS" ]
then

chroot $TEMPMOUNT /bin/bash -c "mkdir /etc/zfs/zfs-list.cache"

chroot $TEMPMOUNT /bin/bash -c "touch /etc/zfs/zfs-list.cache/bpool"

chroot $TEMPMOUNT /bin/bash -c "touch /etc/zfs/zfs-list.cache/rpool"

chroot $TEMPMOUNT /bin/bash -c "ln -s /usr/lib/zfs-linux/zed.d/history_event-zfs-list-cacher.sh /etc/zfs/zed.d"

fi

echo ''
echo ''
echo "/etc/zfs/zed.d/history_event-zfs-list-cacher.sh"
echo ''
cat $TEMPMOUNT/etc/zfs/zed.d/history_event-zfs-list-cacher.sh
echo ''
echo ''
echo "/etc/zfs/zfs-list.cache/bpool"
echo ''
cat $TEMPMOUNT/etc/zfs/zfs-list.cache/bpool
echo ''
echo ''
echo "/etc/zfs/zfs-list.cache/rpool"
echo ''
cat $TEMPMOUNT/etc/zfs/zfs-list.cache/rpool
echo ''
echo ''

if [ ! -f "$TEMPMOUNT/etc/zfs/zed.d/history_event-zfs-list-cacher.sh" ]
then 
    echo "/etc/zfs/zed.d/history_event-zfs-list-cacher.sh does not exist"
    exit 1
fi

if [ ! -f "$TEMPMOUNT/etc/zfs/zfs-list.cache/bpool" ]
then 
    echo "/etc/zfs/zfs-list.cache/bpool does not exist"
    exit 1
fi

if [ ! -f "$TEMPMOUNT/etc/zfs/zfs-list.cache/rpool" ]
then 
    echo "/etc/zfs/zfs-list.cache/rpool does not exist"
    exit 1
fi
