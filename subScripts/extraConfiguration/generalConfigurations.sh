#!/bin/bash

cd $TEMPMOUNT/home/$USER && git clone $CONFIGREPO

cp $CONFIGDIR/etc/ssh/ssh_config $TEMPMOUNT/etc/ssh/ssh_config

cp $CONFIGDIR/etc/ssh/sshd_config $TEMPMOUNT/etc/ssh/sshd_config

if [ -n "$ZFS" ]
then

    mkdir $TEMPMOUNT/etc/sanoid
    
    cp $CONFIGDIR/etc/sanoid/ubuntu/sanoid.conf $TEMPMOUNT/etc/sanoid/sanoid.conf

fi

if [ -n "$HIDPI" ]
then

cp $CONFIGDIR/etc/default/console-setup $TEMPMOUNT/etc/default/console-setup

fi

cp $CONFIGDIR/home/.gitconfig $TEMPMOUNT/home/$USER/.gitconfig

cp $CONFIGDIR/home/.vimrc $TEMPMOUNT/home/$USER/.vimrc

chroot $TEMPMOUNT /bin/bash -c "usermod -s $ROOTSHELL root"

if [[ "$ROOTSHELL" = "/bin/zsh" || "$ROOTSHELL" = "/usr/bin/zsh" ]]
then

    cp $TEMPMOUNT/usr/share/zsh-antigen/antigen.zsh $TEMPMOUNT/root/antigen.zsh

    cp $CONFIGDIR/home/.zshrc $TEMPMOUNT/root/.zshrc
    
    chroot $TEMPMOUNT /bin/bash -c "chown -R root:root /root"
fi

chroot $TEMPMOUNT /bin/bash -c "usermod -s $USERSHELL $USER"

if [[ "$USERSHELL" = "/bin/zsh" || "$USERSHELL" = "/usr/bin/zsh" ]]
then
 
    cp $TEMPMOUNT/usr/share/zsh-antigen/antigen.zsh $TEMPMOUNT/home/$USER/antigen.zsh

    cp $CONFIGDIR/home/.zshrc $TEMPMOUNT/home/$USER/.zshrc

    chroot $TEMPMOUNT /bin/bash -c "chown -R $USER:users /home/$USER"
fi
