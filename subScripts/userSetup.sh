#!/bin/bash

chroot $TEMPMOUNT /bin/bash -c "addgroup --system lxd"

chroot $TEMPMOUNT /bin/bash -c "mkdir /home/$USER"

chroot $TEMPMOUNT /bin/bash -c "useradd -M -g users -G sudo,adm,lxd,plugdev,dip,cdrom -s /bin/bash -d /home/$USER $USER"

chroot $TEMPMOUNT /bin/bash -c "cp -a /etc/skel/. /home/$USER"

chroot $TEMPMOUNT /bin/bash -c "chown -R $USER:users /home/$USER/"

chroot $TEMPMOUNT /bin/bash -c "echo root:$ROOTPASS | chpasswd"

chroot $TEMPMOUNT /bin/bash -c "echo $USER:$USERPASS | chpasswd"

