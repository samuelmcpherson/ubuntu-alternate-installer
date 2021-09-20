#!/bin/bash

chroot $TEMPMOUNT /bin/bash -c "usermod -aG audio,video,games,input $USER" #wireshark

if [ -n "$HIDPI" ]
then
    cp $CONFIGDIR/home/hidpi/.conkyrc $TEMPMOUNT/home/$USER/

    cp $CONFIGDIR/home/hidpi/.conkyrc2 $TEMPMOUNT/home/$USER/
else
    cp $CONFIGDIR/home/.conkyrc $TEMPMOUNT/home/$USER/

    cp $CONFIGDIR/home/.conkyrc2 $TEMPMOUNT/home/$USER/
fi

mkdir -p $TEMPMOUNT/home/$USER/.config/autostart

cp $CONFIGDIR/home/.config/autostart/* $TEMPMOUNT/home/$USER/.config/autostart

chroot $TEMPMOUNT su - $USER -c "systemctl --user enable psd.service"

chroot $TEMPMOUNT su - $USER -c "cd /home/$USER && git clone https://github.com/osleg/gebaar-libinput-fork.git"

chroot $TEMPMOUNT su - $USER -c "cd /home/$USER/gebaar-libinput-fork  && git checkout v0.1.4 && git submodule update --init"

sleep 2

chroot $TEMPMOUNT su - $USER -c "mkdir /home/$USER/gebaar-libinput-fork/build && cd /home/$USER/gebaar-libinput-fork/build && cmake .. && make -j$(nproc)"

sleep 2

cp -r $CONFIGDIR/home/.config/gebaar $TEMPMOUNT/home/$USER/.config/gebaar

#chroot $TEMPMOUNT /bin/bash -c "cd /home/$USER/gebaar-libinput-fork/build && make install"

chroot $TEMPMOUNT /bin/bash -c "chown -R $USER:users /home/$USER"
