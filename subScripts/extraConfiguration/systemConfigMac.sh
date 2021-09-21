#!/bin/bash

chroot $TEMPMOUNT /bin/bash -c "apt install -y bcmwl-kernel-source mbpfan && echo '---> apt install bcmwl-kernel-source mbpfan succeeded <--------------------------------------------------------------' || { echo 'apt install bcmwl-kernel-source mbpfan failed'; exit 1; }" || exit 1

chroot $TEMPMOUNT /bin/bash -c "systemctl unmask mbpfan"

chroot $TEMPMOUNT /bin/bash -c "echo coretemp >> /etc/modules"

chroot $TEMPMOUNT /bin/bash -c "echo applesmc >> /etc/modules"

chroot $TEMPMOUNT /bin/bash -c "cp $CONFIGDIR/etc/udev/rules.d/90-xhc_sleep.rules /etc/udev/rules.d/90-xhc_sleep.rules"

chroot $TEMPMOUNT /bin/bash -c "touch /etc/modprobe.d/hid_apple.conf"

if [[ -n "$FNKEYMODESWAP" ]]
then
    chroot $TEMPMOUNT /bin/bash -c "echo options hid_apple fnmode=2 >> /etc/modprobe.d/hid_apple.conf"
fi

if [[ -n "$FNKEYMODESWAP" ]]
then
    chroot $TEMPMOUNT /bin/bash -c "echo options hid_apple swap_opt_cmd=1 >> /etc/modprobe.d/hid_apple.conf"
fi

chroot $TEMPMOUNT /bin/bash -c "update-initramfs -c -k all"
