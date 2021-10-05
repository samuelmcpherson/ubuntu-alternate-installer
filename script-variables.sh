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

export HOSTNAME=IT-laptop-MBP11

export TIMEOUT=20 # number of seconds before selecting the default menu option

export DOMAIN=

export NETDEVICE=ens9

export STATIC=

export IP=

export NETMASK=24

export GATEWAY=192.168.10.1

export DHCP=yes

export BIOS=

export EFI=yes

export ZFS=yes

# existing partitions

    export EFIPART=

    export RPART=

# Format and partition whole disk(s)

    export MIRROR=yes

    export DISK1=/dev/disk/by-id/

    export DISK2=/dev/disk/by-id/

export RELEASE=hirsute # groovy, focal or hirsute

export LANG=en_US.UTF-8

export TIMEZONE=America/Los_Angeles

export SECUREBOOT=

# extra variables to futher customize the install after a minimal base is in place

export CONFIGREPO="https://github.com/samuelmcpherson/config-files.git"
# This variable is used for bringing in configuration files present in a separate repository, this will be cloned in the configured user's home directory

export CONFIGDIR="$TEMPMOUNT/home/$USER/$(echo $CONFIGREPO | cut -d '/' -f5 | sed -r 's/.{4}$//')"

export ANSIBLE=

export DOCKER=

export DESKTOP=yes

    export KDE=yes
        
        export PARACHUTE=yes

        export KROHNKITE=yes
    
    export GESTURES=yes

    export TOUCH=

    export HIDPI=yes

    export THINKPAD=

        export THINKPADTRACKPOINT=

    export SURFACE=

    export MAC=yes

        export FNKEYMODESWAP=yes

        export ALTCMDKEYSWAP=yes

    export GAMES=

export USERSHELL=/bin/zsh

export ROOTSHELL=/bin/bash


