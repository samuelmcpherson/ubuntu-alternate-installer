#!/bin/bash

createDockerDataset()
{
zfs create -o canmount=on -o mountpoint=/var/lib/docker rpool/var/lib/docker
}

createMariadbDataset()
{
zfs create -o primarycache=metadata -o recordsize=16k -o atime=off -o mountpoint=/var/lib/mysql rpool/var/lib/mysql
}

createPostgresDataset()
{
zfs create -o primarycache=metadata -o recordsize=128k -o atime=off -o mountpoint=/var/lib/postgresql rpool/var/lib/postgresql
zfs create -o mountpoint=/var/lib/postgresql/$POSTGRESVER rpool/var/lib/postgresql/$POSTGRESVER

#zfs create -o primarycache=metadata -o recordsize=128k -o atime=off -o mountpoint=/data/patroni rpool/data/patroni
}

createAnsibleUserDataset()
{
zfs create -o com.ubuntu.zsys:bootfs-datasets=rpool/ROOT/ubuntu_$UUID -o canmount=on -o mountpoint=/home/ansible rpool/USERDATA/ansible_$(dd if=/dev/urandom bs=1 count=100 2>/dev/null | tr -dc 'a-z0-9' | cut -c-6)  
}

zfs create -o canmount=off rpool/var
zfs create -o canmount=off rpool/var/lib
zfs create -o mountpoint=/data rpool/data

if [ -n "$MARIADB" ] 
then
	createMariadbDataset
fi

if [ -n "$POSTGRES" ] 
then
	createPostgresDataset
fi

if [ -n "$DOCKER" ] 
then
	createDockerDataset
fi

if [ -n "$ANSIBLE" ] 
then
	createAnsibleUserDataset
fi

if [ -n "$GLUSTER" ]
then	
	glusterDataset
fi

if [ -n "$DOCKER_COMPOSE_CUSTOM" ]
then	
	customDockerComposeDatasets
fi

echo "---> created zfs datasets  <--------------------------------------------------------------" || { echo "failed to create zfs datasets"; exit 1; }
