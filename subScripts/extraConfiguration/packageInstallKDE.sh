#!/bin/bash

chroot $TEMPMOUNT /bin/bash -c "apt update"

chroot $TEMPMOUNT /bin/bash -c "apt-get install -y kubuntu-desktop yakuake && echo '---> apt install kubuntu-desktop yakuake succeeded <--------------------------------------------------------------' || { echo 'apt install kubuntu-desktop yakuake failed'; exit 1; }" || exit 1

chroot $TEMPMOUNT /bin/bash -c "apt-get install -y kwrite akregator marble kdenlive kigo kompare krfb ktimer kmousetool && echo '---> apt install kwrite akregator marble kdenlive kigo kompare korganizer krfb ktimer kmousetool succeeded <--------------------------------------------------------------' || { echo 'apt install kwrite akregator kalarm kapman kblocks kbreakout marble kdenlive kigo kompare korganizer krfb ktimer kmousetool failed'; exit 1; }" || exit 1

