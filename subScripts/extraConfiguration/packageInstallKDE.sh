#!/bin/bash

chroot $TEMPMOUNT /bin/bash -c "apt update"

chroot $TEMPMOUNT /bin/bash -c "apt-get install -y kde-plasma-desktop && echo '---> apt install kde-plasma-desktop succeeded <--------------------------------------------------------------' || { echo 'apt install kde-plasma-desktop failed'; exit 1; }" || exit 1

chroot $TEMPMOUNT /bin/bash -c "apt-get install -y yakuake akregator marble kdenlive kigo kompare krfb ktimer kmousetool node-typescript && echo '---> apt install yakuake akregator marble kdenlive kigo kompare korganizer krfb ktimer kmousetool node-typescript succeeded <--------------------------------------------------------------' || { echo 'apt install yakuake akregator kalarm kapman kblocks kbreakout marble kdenlive kigo kompare korganizer krfb ktimer kmousetool node-typescript failed'; exit 1; }" || exit 1

