#!/bin/bash

cd $TEMPMOUNT/home/$USER && git clone $CONFIGREPO

cp $CONFIGDIR/etc/ssh/ssh_config $TEMPMOUNT/etc/ssh/ssh_config

cp $CONFIGDIR/etc/ssh/sshd_config $TEMPMOUNT/etc/ssh/sshd_config

if [ -n "$ZFS" ]
then

    mkdir $TEMPMOUNT/etc/sanoid
    
    cp $CONFIGDIR/etc/sanoid/ubuntu/sanoid.conf $TEMPMOUNT/etc/sanoid/sanoid.conf

    cp $SCRIPTDIR/zfs-recursive-restore.sh $TEMPMOUNT/usr/bin

    chroot $TEMPMOUNT /bin/bash -c "chmod +x /usr/bin/zfs-recursive-restore.sh"

    for file in $TEMPMOUNT/etc/logrotate.d/* ; do
        if grep -Eq "(^|[^#y])compress" "$file" ; then
            sed -i -r "s/(^|[^#y])(compress)/\1#\2/" "$file"
        fi
    done
fi

if [ -n "$HIDPI" ]
then
    echo '# CONFIGURATION FILE FOR SETUPCON' > $TEMPMOUNT/etc/default/console-setup 

    echo '# Consult the console-setup(5) manual page.' >> $TEMPMOUNT/etc/default/console-setup

    echo '' >> $TEMPMOUNT/etc/default/console-setup

    echo 'ACTIVE_CONSOLES="/dev/tty[1-6]"' >> $TEMPMOUNT/etc/default/console-setup

    echo '' >> $TEMPMOUNT/etc/default/console-setup

    echo 'CHARMAP="UTF-8"' >> $TEMPMOUNT/etc/default/console-setup

    echo '' >> $TEMPMOUNT/etc/default/console-setup

    echo 'CODESET="guess"' >> $TEMPMOUNT/etc/default/console-setup

    echo 'FONTFACE="Fixed"' >> $TEMPMOUNT/etc/default/console-setup

    echo 'FONTSIZE="16x32"' >> $TEMPMOUNT/etc/default/console-setup

    echo '' >> $TEMPMOUNT/etc/default/console-setup

    echo 'VIDEOMODE=' >> $TEMPMOUNT/etc/default/console-setup

    echo '' >> $TEMPMOUNT/etc/default/console-setup

    echo '# The following is an example how to use a braille font' >> $TEMPMOUNT/etc/default/console-setup

    echo '# FONT="lat9w-08.psf.gz brl-8x8.psf"' >> $TEMPMOUNT/etc/default/console-setup

fi


cp $CONFIGDIR/home/.vimrc $TEMPMOUNT/home/$USER/.vimrc

chroot $TEMPMOUNT /bin/bash -c "usermod -s $ROOTSHELL root"

if [[ "$ROOTSHELL" = "/bin/zsh" || "$ROOTSHELL" = "/usr/bin/zsh" ]]
then

    cp $CONFIGDIR/home/.zshrc $TEMPMOUNT/root/.zshrc
    
    chroot $TEMPMOUNT /bin/bash -c "chown -R root:root /root"
fi

chroot $TEMPMOUNT /bin/bash -c "usermod -s $USERSHELL $USER"

if [[ "$USERSHELL" = "/bin/zsh" || "$USERSHELL" = "/usr/bin/zsh" ]]
then
 
    cp $CONFIGDIR/home/.zshrc $TEMPMOUNT/home/$USER/.zshrc

    chroot $TEMPMOUNT /bin/bash -c "chown -R $USER:users /home/$USER"
fi
