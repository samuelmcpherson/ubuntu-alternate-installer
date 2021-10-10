#!/bin/bash

chroot $TEMPMOUNT /bin/bash -c "zfs set org.zfsbootmenu:commandline=\"spl_hostid=$( hostid ) ro quiet\" zroot/ROOT"

chroot $TEMPMOUNT /bin/bash -c "cd /root && git clone 'https://github.com/zbm-dev/zfsbootmenu.git'"
chroot $TEMPMOUNT /bin/bash -c "cd /root/zfsbootmenu && make install"

chroot $TEMPMOUNT /bin/bash -c "echo yes | cpan 'YAML::PP'"

chroot $TEMPMOUNT /bin/bash -c "mkdir -p /etc/dracut.conf.d"
chroot $TEMPMOUNT /bin/bash -c "touch /etc/dracut.conf.d/100-zol.conf"
{    
  echo "omit_dracutmodules+=\" systemd systemd-initrd dracut-systemd \"" 
  #echo "install_items+=\" /etc/zfs/zroot.key \""
} > $TEMPMOUNT/etc/dracut.conf.d/100-zol.conf

chroot $TEMPMOUNT /bin/bash -c "mkdir -p /etc/zfsbootmenu"
chroot $TEMPMOUNT /bin/bash -c "touch /etc/zfsbootmenu/config.yaml"
{
  echo "Global:"
  echo "  ManageImages: true"
  echo "  BootMountPoint: /boot/efi"
  echo "  DracutConfDir: /etc/zfsbootmenu/dracut.conf.d"
  echo "Components:"
  echo "  ImageDir: /boot/efi/EFI/debian"
  echo "  Versions: 3"
  echo "  Enabled: true"
  echo "  syslinux:"
  echo "    Config: /boot/syslinux/syslinux.cfg"
  echo "    Enabled: false"
  echo "EFI:"
  echo "  ImageDir: /boot/efi/EFI/debian"
  echo "  Versions: 2"
  echo "  Enabled: true"
  #echo "  Stub: /usr/lib/systemd/boot/efi/linuxx64.efi.stub"
  echo "Kernel:"
  echo "  CommandLine: ro quiet loglevel=0"
} > $TEMPMOUNT/etc/zfsbootmenu/config.yaml

chroot $TEMPMOUNT /bin/bash -c "mkdir -p /etc/zfsbootmenu/dracut.conf.d"
chroot $TEMPMOUNT /bin/bash -c "touch /etc/zfsbootmenu/dracut.conf.d/zfsbootmenu.conf"
{    
  echo "hostonly=\"no\"" 
  echo "nofsck=\"yes\"" 
  echo "add_dracutmodules+=\" zfs \"" 
  echo "omit_dracutmodules+=\" btrfs \"" 
  #echo "install_items+=\" /etc/zfs/zroot.key \"" 
} > $TEMPMOUNT/etc/zfsbootmenu/dracut.conf.d/zfsbootmenu.conf

chroot $TEMPMOUNT /bin/bash -c "dracut --force"

chroot $TEMPMOUNT /bin/bash -c "generate-zbm"

chroot $TEMPMOUNT /bin/bash -c "refind-install"

chroot $TEMPMOUNT /bin/bash -c "mkdir -p /boot/efi/EFI/debian"
chroot $TEMPMOUNT /bin/bash -c "touch /boot/efi/EFI/debian/refind_linux.conf"
echo "\"Boot default\"  \"zfsbootmenu:POOL=zroot spl_hostid=$( hostid ) zbm.timeout=0 ro loglevel=0\"" > $TEMPMOUNT/boot/efi/EFI/debian/refind_linux.conf
echo "\"Boot to menu\"  \"zfsbootmenu:POOL=zroot spl_hostid=$( hostid ) zbm.timeout=-1 ro loglevel=0\"" >> $TEMPMOUNT/boot/efi/EFI/debian/refind_linux.conf


#echo ''
#echo ''
#echo "/etc/zfs/zed.d/history_event-zfs-list-cacher.sh"
#echo ''
#cat $TEMPMOUNT/etc/zfs/zed.d/history_event-zfs-list-cacher.sh
#echo ''
#echo ''
#echo "/etc/zfs/zfs-list.cache/bpool"
#echo ''
#cat $TEMPMOUNT/etc/zfs/zfs-list.cache/bpool
#echo ''
#echo ''
#echo "/etc/zfs/zfs-list.cache/rpool"
#echo ''
#cat $TEMPMOUNT/etc/zfs/zfs-list.cache/rpool
#echo ''
#echo ''

#if [ ! -f "$TEMPMOUNT/etc/zfs/zed.d/history_event-zfs-list-cacher.sh" ]
#then 
#    echo "/etc/zfs/zed.d/history_event-zfs-list-cacher.sh does not exist"
#    exit 1
#fi

#if [ ! -f "$TEMPMOUNT/etc/zfs/zfs-list.cache/bpool" ]
#then 
#    echo "/etc/zfs/zfs-list.cache/bpool does not exist"
#    exit 1
#fi

#if [ ! -f "$TEMPMOUNT/etc/zfs/zfs-list.cache/rpool" ]
#then 
#    echo "/etc/zfs/zfs-list.cache/rpool does not exist"
#    exit 1
#fi
