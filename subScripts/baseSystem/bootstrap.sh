#!/bin/bash



debootstrap $RELEASE $TEMPMOUNT && echo "---> Successfully bootstrapped system at $TEMPMOUNT <--------------------------------------------------------------" || { echo "failed to bootstrap system at $TEMPMOUNT"; exit 1; }

#echo "network:" > $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#echo "  version: 2" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#echo "  ethernets:" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#echo "    $NETDEVICE:" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#if [ -n "$DHCP" ] && [ -z "$STATIC" ]
#then 
#echo "      dhcp4: true" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#fi

#if [ -n "$STATIC" ] && [ -z "$DHCP" ]
#then
#echo "      dhcp4: no" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#echo "      addresses:" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#echo "        - $IP/$NETMASK" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#echo "      gateway4: $GATEWAY" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#echo "      nameservers:" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#echo "          search: [$DOMAIN]" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#echo "          addresses: [$GATEWAY]" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
#fi

cp /etc/hostid $TEMPMOUNT/etc/hostid
cp /etc/resolv.conf $TEMPMOUNT/etc/resolv.conf


mkdir -p $TEMPMOUNT/etc/apt/sources.list.d

echo "deb http://deb.debian.org/debian $RELEASE main contrib non-free" > $TEMPMOUNT/etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian $RELEASE main contrib non-free" >> $TEMPMOUNT/etc/apt/sources.list
echo "#deb http://security.debian.org/debian-security $RELEASE/updates main contrib non-free" >> $TEMPMOUNT/etc/apt/sources.list
echo "#deb-src http://security.debian.org/debian-security $RELEASE/updates main contrib non-free" >> $TEMPMOUNT/etc/apt/sources.list
echo "deb http://deb.debian.org/debian $RELEASE-updates main contrib non-free" >> $TEMPMOUNT/etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian $RELEASE-updates main contrib non-free" >> $TEMPMOUNT/etc/apt/sources.list


echo "deb http://deb.debian.org/debian $RELEASE-backports main contrib non-free" > $TEMPMOUNT/etc/apt/sources.list.d/$RELEASE-backports.list
echo "deb-src http://deb.debian.org/debian $RELEASE-backports main contrib" >> $TEMPMOUNT/etc/apt/sources.list.d/$RELEASE-backports.list


mkdir $TEMPMOUNT/etc/apt/preferences.d


echo "Package: libnvpair1linux libuutil1linux libzfs2linux libzfslinux-dev libzpool2linux python3-pyzfs pyzfs-doc spl spl-dkms zfs-dkms zfs-dracut zfs-initramfs zfs-test zfsutils-linux zfsutils-linux-dev zfs-zed" > $TEMPMOUNT/etc/apt/preferences.d/90_zfs
echo "Pin: release n=$RELEASE-backports" >> $TEMPMOUNT/etc/apt/preferences.d/90_zfs
echo "Pin-Priority: 990" >> $TEMPMOUNT/etc/apt/preferences.d/90_zfs
