#!/bin/bash

createDockerDataset()
{
zfs create -o canmount=on -o mountpoint=/var/lib/docker rpool/var/lib/docker
}

createAnsibleUserDataset()
{
zfs create -o com.ubuntu.zsys:bootfs-datasets=rpool/ROOT/ubuntu_$UUID -o canmount=on -o mountpoint=/home/ansible rpool/USERDATA/ansible_$(dd if=/dev/urandom bs=1 count=100 2>/dev/null | tr -dc 'a-z0-9' | cut -c-6)  
}

zfs create -o canmount=off rpool/var
zfs create -o canmount=off rpool/var/lib
zfs create -o mountpoint=/data rpool/data

if [ -n "$DOCKER" ] 
then
	createDockerDataset
fi

if [ -n "$ANSIBLE" ] 
then
	createAnsibleUserDataset
fi

echo "---> created zfs datasets  <--------------------------------------------------------------" || { echo "failed to create zfs datasets"; exit 1; }
