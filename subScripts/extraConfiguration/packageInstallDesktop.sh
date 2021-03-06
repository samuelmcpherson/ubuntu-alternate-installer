#!/bin/bash


chroot $TEMPMOUNT /bin/bash -c "apt update"
chroot $TEMPMOUNT /bin/bash -c "apt -y install conky-all vlc openshot gimp inkscape libudev-dev xdotool libinput-tools libinput-dev quassel-client calibre audacity gparted pass wireshark profile-sync-daemon pandoc && echo '---> apt install conky-all vlc openshot gimp inkscape libudev-dev xdotool libinput-tools libinput-dev quassel-client calibre audacity gparted pass wireshark profile-sync-daemon succeeded <--------------------------------------------------------------' || { echo 'apt install conky-all vlc openshot gimp inkscape libudev-dev xdotool libinput-tools libinput-dev quassel-client calibre audacity gparted pass wireshark profile-sync-daemon failed'; exit 1; }" || exit 1

chroot $TEMPMOUNT /bin/bash -c "apt install -y texlive-base texlive-latex-base texlive-latex-extra texlive-latex-extra-doc texlive-latex-base-doc && echo '---> apt install texlive-base texlive-latex-base texlive-latex-extra texlive-latex-extra-doc texlive-latex-base-doc succeeded <--------------------------------------------------------------' || echo '---> apt install texlive-base texlive-latex-base texlive-latex-extra texlive-latex-extra-doc texlive-latex-base-doc failed <--------------------------------------------------------------'"

chroot $TEMPMOUNT /bin/bash -c "cd /tmp && wget https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc"
chroot $TEMPMOUNT /bin/bash -c "cd /tmp && apt-key add TeamViewer2017.asc"
chroot $TEMPMOUNT /bin/bash -c "echo 'deb http://linux.teamviewer.com/deb stable main' >> /etc/apt/sources.list.d/teamviewer.list"
chroot $TEMPMOUNT /bin/bash -c "wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg"

chroot $TEMPMOUNT /bin/bash -c "wget -qO - https://protonmail.com/download/bridge_pubkey.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/bridge_pubkey.gpg"

chroot $TEMPMOUNT /bin/bash -c "echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' >> /etc/apt/sources.list.d/vscodium.list"

chroot $TEMPMOUNT /bin/bash -c "cd /tmp && wget -O protonmail-bridge.deb 'https://protonmail.com/download/protonmail-bridge_1.8.9-1_amd64.deb'"

chroot $TEMPMOUNT /bin/bash -c "cd /tmp && wget -O discord.deb 'https://discordapp.com/api/download?platform=linux&format=deb'"

chroot $TEMPMOUNT /bin/bash -c "cd /tmp && wget -O slack-desktop.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-4.13.0-amd64.deb"

chroot $TEMPMOUNT /bin/bash -c "cd /tmp && wget https://zoom.us/client/latest/zoom_amd64.deb"

chroot $TEMPMOUNT /bin/bash -c "cd /tmp && wget https://github.com/jgraph/drawio-desktop/releases/download/v12.3.2/draw.io-amd64-12.3.2.deb"

chroot $TEMPMOUNT /bin/bash -c "cd /tmp && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

chroot $TEMPMOUNT /bin/bash -c "add-apt-repository -y ppa:andreasbutti/xournalpp-master"

chroot $TEMPMOUNT /bin/bash -c "apt update"

chroot $TEMPMOUNT /bin/bash -c "apt install -y codium && echo '---> apt install codium succeeded <--------------------------------------------------------------' || echo '---> apt install codium failed <--------------------------------------------------------------'" 

chroot $TEMPMOUNT /bin/bash -c 'echo -en "\n" | apt install -y teamviewer && echo "---> apt install teamviewer succeeded <--------------------------------------------------------------" || echo "---> apt install teamviewer failed <--------------------------------------------------------------"'

chroot $TEMPMOUNT /bin/bash -c "apt install -y /tmp/protonmail-bridge.deb && echo '---> apt install /tmp/protonmail-bridge.deb succeeded <--------------------------------------------------------------' || echo '---> apt install /tmp/protonmail-bridge.deb failed <--------------------------------------------------------------'"

chroot $TEMPMOUNT /bin/bash -c "apt install -y /tmp/discord.deb && echo '---> apt install /tmp/discord.deb succeeded <--------------------------------------------------------------' || echo '---> apt install /tmp/discord.deb failed <--------------------------------------------------------------'"

chroot $TEMPMOUNT /bin/bash -c "apt install -y /tmp/slack-desktop.deb && echo '---> apt install /tmp/slack-desktop.deb succeeded <--------------------------------------------------------------' || echo '---> apt install /tmp/slack-desktop.deb failed <--------------------------------------------------------------'"

chroot $TEMPMOUNT /bin/bash -c "apt install -y /tmp/zoom_amd64.deb && echo '---> apt install zoom_amd64.deb succeeded <--------------------------------------------------------------' || echo '---> apt install zoom_amd64.deb failed <--------------------------------------------------------------'"

chroot $TEMPMOUNT /bin/bash -c "apt install -y /tmp/draw.io-amd64-* && echo '---> apt install /tmp/draw.io-amd64-* succeeded <--------------------------------------------------------------' || echo '---> apt install /tmp/draw.io-amd64-* failed <--------------------------------------------------------------'"

chroot $TEMPMOUNT /bin/bash -c "apt install -y xournalpp && echo '---> apt install xournalpp succeeded <--------------------------------------------------------------' || echo '---> apt install xournalpp failed <--------------------------------------------------------------'"

chroot $TEMPMOUNT /bin/bash -c "apt install -y /tmp/google-chrome-stable_current_amd64.deb && echo '---> apt install /tmp/google-chrome-stable_current_amd64.deb succeeded <--------------------------------------------------------------' || echo '---> apt install /tmp/google-chrome-stable_current_amd64.deb failed <--------------------------------------------------------------'"