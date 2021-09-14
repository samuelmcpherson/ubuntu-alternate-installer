#!/bin/bash



debootstrap $RELEASE $TEMPMOUNT && echo "---> Successfully bootstrapped system at $TEMPMOUNT <--------------------------------------------------------------" || { echo "failed to bootstrap system at $TEMPMOUNT"; exit 1; }

echo "network:" > $TEMPMOUNT/etc/netplan/01-netcfg.yaml
echo "  version: 2" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
echo "  ethernets:" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
echo "    $NETDEVICE:" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
if [ -n "$DHCP" ] && [ -z "$STATIC" ]
then 
echo "      dhcp4: true" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
fi

if [ -n "$STATIC" ] && [ -z "$DHCP" ]
then
echo "      dhcp4: no" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
echo "      addresses:" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
echo "        - $IP/$NETMASK" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
echo "      gateway4: $GATEWAY" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
echo "      nameservers:" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
echo "          search: [$DOMAIN]" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
echo "          addresses: [$GATEWAY]" >> $TEMPMOUNT/etc/netplan/01-netcfg.yaml
fi



echo "deb http://archive.ubuntu.com/ubuntu $RELEASE main restricted universe multiverse" > $TEMPMOUNT/etc/apt/sources.list

echo "deb http://archive.ubuntu.com/ubuntu $RELEASE-updates main restricted universe multiverse" >> $TEMPMOUNT/etc/apt/sources.list

echo "deb http://archive.ubuntu.com/ubuntu $RELEASE-backports main restricted universe multiverse" >> $TEMPMOUNT/etc/apt/sources.list

echo "deb http://security.ubuntu.com/ubuntu $RELEASE-security main restricted universe multiverse" >> $TEMPMOUNT/etc/apt/sources.list

