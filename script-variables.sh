#!/bin/bash

### imutable variables

export SCRIPTDIR=$(pwd)

export TEMPMOUNT=/mnt

export CONFIGREPO="https://github.com/samuelmcpherson/config-files.git"
# This variable is used for bringing in configuration files present in a separate repository, this will be cloned in the configured user's home directory

export CONFIGDIR="$TEMPMOUNT/home/$USER/$(echo $CONFIGREPO | cut -d '/' -f5 | sed -r 's/.{4}$//')"

export UUID=$(dd if=/dev/urandom bs=1 count=100 2>/dev/null | tr -dc 'a-z0-9' | cut -c-6)

export DEBIAN_FRONTEND=noninteractive

### Required vars:

export HOSTNAME=ubuntu-thinkpad-430

export TIMEOUT=20 # number of seconds before selecting the default menu option

export DOMAIN=housenet.lan

export NETDEVICE=enp0s25

export STATIC=

export IP=

export NETMASK=24

export GATEWAY=192.168.10.1

export DHCP=yes

export BIOS=

export EFI=yes

export ZFS=yes
#existing partitions

export EFIPART=

export BPART=

export RPART=

#nuke and pave

export MIRROR=mirror

export DISK1=/dev/disk/by-id/ata-Samsung_SSD_850_EVO_500GB_S2RANB0HA26883V

export DISK2=/dev/disk/by-id/ata-Samsung_SSD_850_EVO_500GB_S21HNXAGB51863E

export EFIPART_2=

export RELEASE=hirsute # groovy, focal or hirsute

export LANG=en_US.UTF-8

export TIMEZONE=America/Los_Angeles

export SECUREBOOT=yes

# extra variables to futher customize the install after a minimal base is in place

export CONFIGREPO="https://github.com/samuelmcpherson/config-files.git"
# This variable is used for bringing in configuration files present in a separate repository, this will be cloned in the configured user's home directory

export CONFIGDIR="$TEMPMOUNT/home/$USER/$(echo $CONFIGREPO | cut -d '/' -f5 | sed -r 's/.{4}$//')"

export HIDPI=

export ANSIBLE=yes

export DOCKER=

export DESKTOP=yes

export TOUCH=

export SURFACE=

export MACBOOKPRO=

export GAMES=yes

export KDE=yes

export USERSHELL=/bin/zsh

export ROOTSHELL=/bin/bash


