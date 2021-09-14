#!/bin/bash

# takes input $DISK1-part2 as $1 (and $DISK2-part2 as $2 for mirror setups) for full disk format installs

# takes input $BPART as $1 for no drive formatting installs 

zpool create -f -o ashift=12 -o autotrim=on -d -o feature@async_destroy=enabled -o feature@bookmarks=enabled -o feature@embedded_data=enabled -o feature@empty_bpobj=enabled -o feature@enabled_txg=enabled -o feature@extensible_dataset=enabled -o feature@filesystem_limits=enabled -o feature@hole_birth=enabled -o feature@large_blocks=enabled -o feature@lz4_compress=enabled -o feature@spacemap_histogram=enabled -O acltype=posixacl -O canmount=off -O compression=lz4 -O devices=off -O normalization=formD -O relatime=on -O xattr=sa -O mountpoint=none -R $TEMPMOUNT bpool $MIRROR $1 $2 && echo "---> created $MIRROR zpool: bpool with $1  $2  <--------------------------------------------------------------" || { echo "failed to create $MIRROR zpool: bpool with $1  $2"; exit 1; }

sleep 2