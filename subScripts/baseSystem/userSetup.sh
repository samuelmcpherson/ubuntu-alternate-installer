#!/bin/bash

if [[ -z "/home/$USER" ]]
then
    chroot $TEMPMOUNT /bin/bash -c "mkdir /home/$USER"
fi

chroot $TEMPMOUNT /bin/bash -c "useradd -M -g users -G sudo,adm,plugdev,dip -s /bin/bash -d /home/$USER $USER"

chroot $TEMPMOUNT /bin/bash -c "cp -a /etc/skel/. /home/$USER"

chroot $TEMPMOUNT /bin/bash -c "chown -R $USER:users /home/$USER/"

chroot $TEMPMOUNT /bin/bash -c "echo root:$ROOTPASS | chpasswd"

chroot $TEMPMOUNT /bin/bash -c "echo $USER:$USERPASS | chpasswd"

