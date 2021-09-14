#!/bin/bash



chroot $TEMPMOUNT /bin/bash -c "echo applesmc >> /etc/modules"
chroot $TEMPMOUNT /bin/bash -c "echo wl >> /etc/modules"
chroot $TEMPMOUNT /bin/bash -c "touch /etc/modprobe.d/hid_apple.conf"
chroot $TEMPMOUNT /bin/bash -c "echo options hid_apple fnmode=2 >> /etc/modprobe.d/hid_apple.conf"
chroot $TEMPMOUNT /bin/bash -c "echo options hid_apple swap_opt_cmd=1 >> /etc/modprobe.d/hid_apple.conf"
chroot $TEMPMOUNT /bin/bash -c "cp $WORKDIR/$FILEREPO/apple/90-xhc_sleep.rules /etc/udev/rules.d/"
chroot $TEMPMOUNT /bin/bash -c "mkdir -p /etc/X11/xorg.conf.d/"
chroot $TEMPMOUNT /bin/bash -c "cp $WORKDIR/$FILEREPO/apple/30-touchpad.conf /etc/X11/xorg.conf.d/"
chroot $TEMPMOUNT /bin/bash -c "update-initramfs -c -k all"