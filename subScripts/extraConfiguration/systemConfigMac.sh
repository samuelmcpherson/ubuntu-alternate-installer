#!/bin/bash

chroot $TEMPMOUNT /bin/bash -c "apt install -y firmware-b43-installer mbpfan && echo '---> apt install firmware-b43-installer mbpfan succeeded <--------------------------------------------------------------' || { echo 'apt install firmware-b43-installer mbpfan failed'; exit 1; }" || exit 1

chroot $TEMPMOUNT /bin/bash -c "systemctl unmask mbpfan"

chroot $TEMPMOUNT /bin/bash -c "echo coretemp >> /etc/modules"

chroot $TEMPMOUNT /bin/bash -c "echo applesmc >> /etc/modules"

chroot $TEMPMOUNT /bin/bash -c "touch /etc/modprobe.d/hid_apple.conf"

cp $CONFIGDIR/etc/udev/rules.d/90-xhc_sleep.rules $TEMPMOUNT/etc/udev/rules.d/90-xhc_sleep.rules

if [[ -n "$FNKEYMODESWAP" ]]
then
    chroot $TEMPMOUNT /bin/bash -c "echo options hid_apple fnmode=2 >> /etc/modprobe.d/hid_apple.conf"
fi

if [[ -n "$FNKEYMODESWAP" ]]
then
    chroot $TEMPMOUNT /bin/bash -c "echo options hid_apple swap_opt_cmd=1 >> /etc/modprobe.d/hid_apple.conf"
fi

chroot $TEMPMOUNT /bin/bash -c "dracut --force --kver $(ls $TEMPMOUNT/lib/modules)"

chroot $TEMPMOUNT /bin/bash -c "generate-zbm"

if [[ -n "$MIRROR" ]]
then 
    chroot $TEMPMOUNT /bin/bash -c "/usr/bin/rsync -a /boot/efi/ /boot/efi2"
fi