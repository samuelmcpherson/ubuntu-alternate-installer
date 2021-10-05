#!/bin/bash

zfs create -o canmount=off -o mountpoint=none zroot/ROOT  
    
zfs create -o canmount=noauto -o mountpoint=/ zroot/ROOT/ubuntu 

zfs mount zroot/ROOT/ubuntu

zpool set bootfs=zroot/ROOT/ubuntu zroot

mkdir $TEMPMOUNT/var

zfs create -o canmount=off -o mountpoint=none zroot/ROOT/ubuntu/var

zfs create -o canmount=on -o mountpoint=/var/lib zroot/ROOT/ubuntu/var/lib

zfs create -o canmount=on -o mountpoint=/var/cache zroot/ROOT/ubuntu/var/cache

zfs create -o canmount=on -o mountpoint=/root zroot/ROOT/ubuntu/root

zfs create -o canmount=off -o mountpoint=none zroot/DATA

zfs create -o canmount=off -o mountpoint=none zroot/DATA/ubuntu

zfs create -o canmount=off -o mountpoint=none zroot/DATA/ubuntu/var

zfs create -o canmount=off -o mountpoint=none zroot/DATA/ubuntu/var/lib

zfs create -o canmount=on -o mountpoint=/var/log zroot/DATA/ubuntu/var/log

zfs create -o canmount=off -o mountpoint=none zroot/DATA/ubuntu/home

mkdir $TEMPMOUNT/home
    
zfs create -o canmount=on -o mountpoint=/home/$USER zroot/DATA/ubuntu/home/"$USER"

zfs create -V 20G -b 4096 -o logbias=throughput -o sync=always -o primarycache=metadata -o com.sun:auto-snapshot=false zroot/swap

mkswap -f /dev/zvol/zroot/swap


echo "---> created zfs datasets  <--------------------------------------------------------------" || { echo "failed to create zfs datasets"; exit 1; }

