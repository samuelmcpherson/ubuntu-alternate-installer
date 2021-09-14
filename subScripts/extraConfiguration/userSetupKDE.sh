#!/bin/bash


if [ -n "$HIDPI" ]
then
    cp -r $CONFIGDIR/home/hidpi/kde/.local/ $TEMPMOUNT/home/$USER/
    cp -r $CONFIGDIR/home/hidpi/kde/.config/ $TEMPMOUNT/home/$USER/
    cp -r $CONFIGDIR/home/hidpi/kde/.icons/ $TEMPMOUNT/home/$USER/
    cp -r $CONFIGDIR/home/hidpi/kde/.kde/ $TEMPMOUNT/home/$USER/
else
    cp -r $CONFIGDIR/home/kde/.local/ $TEMPMOUNT/home/$USER/
    cp -r $CONFIGDIR/home/kde/.config/ $TEMPMOUNT/home/$USER/
    cp -r $CONFIGDIR/home/kde/.icons/ $TEMPMOUNT/home/$USER/
    cp -r $CONFIGDIR/home/kde/.kde/ $TEMPMOUNT/home/$USER/
fi
#chroot $TEMPMOUNT /bin/bash -c "cp -r /home/$USER/$SCRIPTREPO/files/dotfiles/.local/share/konsole/ /home/$USER/.local/share/"

#chroot $TEMPMOUNT /bin/bash -c "cp -r /home/$USER/$SCRIPTREPO/files/dotfiles/.local/share/plasma/desktoptheme/ghost-blue-dark/ /home/$USER/.local/share/plasma/desktoptheme/"

#chroot $TEMPMOUNT /bin/bash -c "cp -r /home/$USER/$SCRIPTREPO/files/dotfiles/.local/share/plasma/plasmoids/com.github.zren.commandoutput /home/$USER/.local/share/plasma/plasmoids/"

#chroot $TEMPMOUNT /bin/bash -c "cp /home/$USER/$SCRIPTREPO/files/dotfiles/.config/konsolerc /home/$USER/.config/"

#chroot $TEMPMOUNT /bin/bash -c "cp /home/$USER/$SCRIPTREPO/files/dotfiles/.config/kwinrc /home/$USER/.config/"

#chroot $TEMPMOUNT /bin/bash -c "cp /home/$USER/$SCRIPTREPO/files/dotfiles/.config/plasma-org.kde.plasma.desktop-appletsrc /home/$USER/.config/"

#chroot $TEMPMOUNT /bin/bash -c "cp /home/$USER/$SCRIPTREPO/files/dotfiles/.config/plasmarc /home/$USER/.config/"

#chroot $TEMPMOUNT /bin/bash -c "cp /home/$USER/$SCRIPTREPO/files/dotfiles/.config/plasmashellrc /home/$USER/.config/"

#chroot $TEMPMOUNT /bin/bash -c "cp /home/$USER/$SCRIPTREPO/files/dotfiles/.config/khotkeysrc /home/$USER/.config/"

#chroot $TEMPMOUNT /bin/bash -c "cp /home/$USER/$SCRIPTREPO/files/dotfiles/.config/kglobalshortcutsrc /home/$USER/.config/"

#chroot $TEMPMOUNT /bin/bash -c "cp /home/$USER/$SCRIPTREPO/files/dotfiles/.config/kdeglobals /home/$USER/.config/"

cp $WORKDIR/$FILEREPO/wallpaper/* $TEMPMOUNT/usr/share/wallpapers

chroot $TEMPMOUNT /bin/bash -c "chown -R $USER:users /home/$USER"

chroot $TEMPMOUNT su - $USER -c "cd /home/$USER && git clone https://github.com/tcorreabr/Parachute.git"

sleep 2

chroot $TEMPMOUNT su - $USER -c "cd /home/$USER/Parachute && make install"

sleep 2



#chroot $TEMPMOUNT su - $USER -c "kwriteconfig5 --file /home/$USER/.config/kwinrc --group ModifierOnlyShortcuts --key Meta 'org.kde.kglobalaccel,/component/kwin,org.kde.kglobalaccel.Component,invokeShortcut,Parachute'"

#chroot $TEMPMOUNT su - $USER -c "qdbus org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.createDesktop 2 'Desktop 2'"

#chroot $TEMPMOUNT su - $USER -c "qdbus org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.createDesktop 3 'Desktop 3'"

#chroot $TEMPMOUNT su - $USER -c "qdbus org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.createDesktop 4 'Desktop 4'"

#chroot $TEMPMOUNT su - $USER -c "qdbus org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.createDesktop 5 'Desktop 5'"

#chroot $TEMPMOUNT su - $USER -c "qdbus org.kde.KWin /VirtualDesktopManager org.kde.KWin.VirtualDesktopManager.rows 5"

#chroot $TEMPMOUNT su - $USER -c "/home/$USER/$SCRIPTREPO/files/set-background.sh"
