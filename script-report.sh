variableReport()
{
if [ -n "$MIRROR" ]
then
	export MIRROR=mirror
fi

if [ ! "$RELEASE" = "groovy" -o "$RELEASE" = "focal" -o "$RELEASE" = "hirsute" ]
then
    echo "RELEASE needs to be set to a valid ubuntu release"
    PS3="Choose an option: Focal Fossa 20.04, Groovy Gorilla 20.10, or Hirsute Hippo 21.04"
    options=(focal groovy hirsute abort)
    select menu in "${options[@]}";
    do
        if [[ $REPLY == "1" ]]; then
            echo -e "\nyou picked $menu ($REPLY)"
            export RELEASE=focal
            break;
        elif [[ $REPLY == "2" ]]; then
            echo -e "\nyou picked $menu ($REPLY)"
            export RELEASE=groovy
            break; 
        elif [[ $REPLY == "3" ]]; then
            echo -e "\nyou picked $menu ($REPLY)"
            export RELEASE=hirsute
        elif [[ $REPLY == "4" ]]; then
            echo -e "\nyou picked $menu ($REPLY)"
            exit 1
        fi    
    done
fi


### Required vars:

echo "WORKDIR=$WORKDIR" >> $VARIABLEREPORT
echo "Location where the ubuntu-zfs repo is expected to be found, as well as the .ssh directory that will be copied to the new system" >> $VARIABLEREPORT

if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset, it is required for the install script--------------------"
fi
    echo ''>> $VARIABLEREPORT

echo "TEMPMOUNT=$TEMPMOUNT" >> $VARIABLEREPORT
echo "Mountpoint for the root of the new system" >> $VARIABLEREPORT
if [ -n "$TEMPMOUNT" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset, it is required for the install script--------------------"
fi
    echo ''>> $VARIABLEREPORT


echo "HOSTNAME=$HOSTNAME" >> $VARIABLEREPORT
echo "Hostname of the new system" >> $VARIABLEREPORT
 if [ -n "$HOSTNAME" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset, it is required for the install script--------------------"
fi
    echo ''>> $VARIABLEREPORT

echo "OUTPUTLOG=$OUTPULOG" >> $VARIABLEREPORT
echo "Path to the script logs: each individual function will create its own log with the following format: $OUPUTLOG-FUNCTIONNAME.txt. After the function has been moved on from, these logs are appended to the full log at $OUTPUTLOG.txt " >> $VARIABLEREPORT
if [ -n "$OUTPUTLOG" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset, it is required for the install script--------------------"
fi  
    echo ''>> $VARIABLEREPORT

echo "VARIABLEREPORT=$VARIABLEREPORT" >> $VARIABLEREPORT
echo "Path to this report of variables for the current install" >> $VARIABLEREPORT
if [ -n "$VARIABLEREPORT" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset, it is required for the install script--------------------"
fi 
    echo ''>> $VARIABLEREPORT

echo "SCRIPTREPORT=$SCRIPTREPORT" >> $VARIABLEREPORT
echo "Path to the report of functions that will run and their order" >> $VARIABLEREPORT
if [ -n "$SCRIPTREPORT" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset, it is required for the install script--------------------"
fi
    echo ''>> $VARIABLEREPORT

echo "DOMAIN=$DOMAIN" >> $VARIABLEREPORT
echo "Domain name of the system, will be used along with HOSTNAME to create the systems FQDN for the hosts file" >> $VARIABLEREPORT
if [ -n "$DOMAIN" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset, it is required for the install script--------------------"
fi    
    echo ''>> $VARIABLEREPORT

echo "USER=$USER" >> $VARIABLEREPORT
echo "Privleged user account for the new system" >> $VARIABLEREPORT
if [ -n "$USER" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset, it is required for the install script--------------------"
fi    
    echo ''>> $VARIABLEREPORT

echo "UUID=$UUID" >> $VARIABLEREPORT
echo "Unique ID for system datasets" >> $VARIABLEREPORT
if [ -n "$UUID" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset, it is required for the install script--------------------"
fi    
    echo ''>> $VARIABLEREPORT

echo "DEBIAN_FRONTEND=noninteractive" >> $VARIABLEREPORT
echo "Used to fully automate software installation by blocking full page notifications" >> $VARIABLEREPORT
    echo ''>> $VARIABLEREPORT

echo "NETDEVICE=$NETDEVICE" >> $VARIABLEREPORT
echo "Main network interface of device used in the current connection to the internet" >> $VARIABLEREPORT
if [ -n "$NETDEVICE" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset, it is required for the install script--------------------"
fi    
    echo ''>> $VARIABLEREPORT

#existing partitions

echo "The following three variables are used for installing onto an already partitioned disk - the partition table and all other existing partitions will not be modified if these variables are used" >> $VARIABLEREPORT
    echo ''>> $VARIABLEREPORT

echo "EFIPART=$EFIPART" >> $VARIABLEREPORT
echo "The full ID of an existing partition to be used for the EFI system partition - this will not be formatted or overwritten and is safe for dual-booting with existing installations" >> $VARIABLEREPORT   
if [ -n "$EFIPART" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi
    echo ''>> $VARIABLEREPORT

echo "BPART=$BPART" >> $VARIABLEREPORT
echo "The full ID of an existing partition to be used for the EFI system bootpool - any data on this partition will be erased when creating the zpool, but the size will remain the same. This partition does not need to be large, as it will primarily be used just to store the kernel and bootloader." >> $VARIABLEREPORT
    if [ -n "$BPART" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi
    echo ''>> $VARIABLEREPORT

echo "RPART=$RPART" >> $VARIABLEREPORT
echo "The full ID of an existing partition to be used for the EFI system rootpool - any data on this partition will be erased when creating the zpool, but the size will remain the same. This should have enough size for the entirety of the system." >> $VARIABLEREPORT
    if [ -n "$RPART" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi
    echo ''>> $VARIABLEREPORT

#nuke and pave

echo "MIRROR=$MIRROR" >> $VARIABLEREPORT

echo "DISK1=$DISK1" >> $VARIABLEREPORT
echo "The full ID of a disk to install the new system to. This device will be fully erased and reformatted with the following partitions: 1) 512MB EFI system partition 2) 4GB partition for the ZFS boot pool 3) partition for the ZFS root pool using all remaining available space. If 2 disks are given, they will both be partitioned in the same way. Both sets of bpool and rpool partitions will be used in their respective pools in a striped (RAID0) configuration by default; setting the MIRROR variable will create a mirrored (RADI1) configuration of these devices isntead." >> $VARIABLEREPORT
if [ -n "$DISK1" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi  
    echo ''>> $VARIABLEREPORT


echo "DISK2=$DISK2" >> $VARIABLEREPORT
echo "The full ID of a disk to install the new system to. This device will be fully erased and reformatted with the following partitions: 1) 512MB EFI system partition 2) 4GB partition for the ZFS boot pool 3) partition for the ZFS root pool using all remaining available space. If 2 disks are given, they will both be partitioned in the same way. Both sets of bpool and rpool partitions will be used in their respective pools in a striped (RAID0) configuration by default; setting the MIRROR variable will create a mirrored (RADI1) configuration of these devices isntead." >> $VARIABLEREPORT
    if [ -n "$DISK2" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi
echo ''>> $VARIABLEREPORT


echo "EFIPART_2= "

echo "RELEASE=$RELEASE" # groovy or focal

### optional vars:

echo ANSIBLE=

    if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi

echo MARIADB=

    if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi

echo DOCKER=
    if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi

echo POSTGRES=

    if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi

echo VM=

    if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi

echo DESKTOP=yes

    if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi

echo SURFACE=

    if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi

echo MACBOOKPRO=yes

    if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi

echo WINE=

    if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi

echo KDE=yes

    if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi

echo HIDPI=yes

    if [ -n "$WORKDIR" ]
then 
    echo "--------------------This variable is set and will be used during the install--------------------"
else 
    echo "--------------------This variable is unset and will not influence the install--------------------"
fi

}

scriptReport()
{
if [ -z "$RPART" ] && [ -z "$BPART" ] && [ -z "$EFI" ] && [ -n "$DISK1" ] && [ -n "$DISK2" ]
then
    echo "Two full disks were given, they will be formatted and setup as a zfs mirror with two pools: bpool and rpool. Each disk will have an EFI system partition mounted at /boot/efi and /boot/efi2 that will be kept in sync with a systemd service." >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT

    echo "diskFormat.sh $DISK1" >> $SCRIPTREPORT
    echo "This function clears a given disk and partitions it with a 512MB EFI partition, a 4GB partition for the bpool and a third partition for the rpool using the rest of the available space." >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT

    echo "diskFormat.sh $DISK2" >> $SCRIPTREPORT
    echo "This function clears a given disk and partitions it with a 512MB EFI partition, a 4GB partition for the bpool and a third partition for the rpool using the rest of the available space." >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT  
	
    echo "EFIPART=$DISK1-part1" >> $SCRIPTREPORT
    echo "Sets the EFIPART variable for later use" >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT  	
    
    echo "EFIPART_2=$DISK2-part1" >> $SCRIPTREPORT
    echo "Sets the EFIPART_2 variable for later use" >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT  

    echo "efiFormat.sh $EFIPART" >> $SCRIPTREPORT
    echo "Creates the fat32 filesystem on the EFIPART partition with the lable EFI" >> $SCRIPTREPORT 
    echo ''>> $SCRIPTREPORT  

    echo "efi2Format.sh $EFIPART_2" >> $SCRIPTREPORT
    echo "Creates the fat32 filesystem on the EFIPART_2 partition with the lable EFI2" >> $SCRIPTREPORT 
    echo ''>> $SCRIPTREPORT   

    echo "bpoolSetup.sh $DISK1-part2 $DISK2-part2" >> $SCRIPTREPORT
    echo "Creates the bpool zpool with limited options for grub compatitibilty" >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT  

    echo "rpoolSetup.sh $DISK1-part3 $DISK2-part3" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT  

elif [ -z "$RPART" ] && [ -z "$BPART" ] && [ -z "$EFI" ] && [ -n "$DISK1" ] && [ -z "$DISK2" ]
then

    echo "diskFormat.sh $DISK1" >> $SCRIPTREPORT
    echo "This function clears a given disk and partitions it with a 512MB EFI partition, a 4GB partition for the bpool and a third partition for the rpool using the rest of the available space." >> $SCRIPTREPORT 
    echo ''>> $SCRIPTREPORT    
	
	echo "EFI=$DISK1-part1" >> $SCRIPTREPORT
    echo "Sets the EFI variable for later use" >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT  

    echo "efiFormat.sh $EFI" >> $SCRIPTREPORT
    echo "Creates the fat32 filesystem on the EFI partition with the lable EFI" >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT  

    echo "bpoolSetup.sh $DISK1-part2" >> $SCRIPTREPORT
    echo "Creates the bpool zpool with limited options for grub compatitibilty" >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT  

    echo "rpoolSetup.sh $DISK1-part3" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT 
    echo ''>> $SCRIPTREPORT    

elif [ -n "$RPART" ] && [ -n "$BPART" ] && [ -n "$EFI" ] && [ -z "$DISK1" ] && [ -z "$DISK2" ] 
then
    
    echo "bpoolSetup.sh $BPART" >> $SCRIPTREPORT
    echo "Creates the bpool zpool with limited options for grub compatitibilty" >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT  

    echo "rpoolSetup.sh $RPART" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT  
else
	echo "Will fail to setup disks correctly" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT
fi

echo "createZfsDatasets.sh" >> $SCRIPTREPORT
echo >> $SCRIPTREPORT
echo ''>> $SCRIPTREPORT  

# -------------------------------------- zfs rollback able at this point

echo "bootstrap.sh" >> $SCRIPTREPORT
echo >> $SCRIPTREPORT
echo ''>> $SCRIPTREPORT  

# ----------------------------- chrootable from this point


echo "EFImount.sh" >> $SCRIPTREPORT
echo >> $SCRIPTREPORT
echo ''>> $SCRIPTREPORT  

if [ -n "$MIRROR" ]
then
    "EFI2mount.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT     
fi	


echo "baseChrootConfig.sh" >> $SCRIPTREPORT
echo >> $SCRIPTREPORT
echo ''>> $SCRIPTREPORT 

echo "packageInstallBase.sh" >> $SCRIPTREPORT
echo >> $SCRIPTREPORT
echo ''>> $SCRIPTREPORT 

echo "userSetup.sh" >> $SCRIPTREPORT
echo >> $SCRIPTREPORT
echo ''>> $SCRIPTREPORT 

if [ -n "$ANSIBLE" ] 
then

    "packageInstallAnsible.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT    
   
fi

if [ -n "$DOCKER" ] 
then

    "packageInstallDocker.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT    
    

fi

if [ -n "$MARIADB" ] 
then

    "packageInstallMariadb.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT    
   

fi

if [ -n "$POSTGRES" ] 
then

    "packageInstallPostgresql.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT    
    

fi

if [ -n "$KDE" ] 
then

    "packageInstallKDE.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT    
    

fi

if [ -n "$DESKTOP" ] 
then

    "packageInstallDesktop.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT    
   

fi

if [ -n "$WINE" ] 
then

    "packageInstallWine.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT    
   
fi

#if [ -n "$SURFACE" ] 
#then
#	packageInstallSurface
#fi

if [ -n "$MACBOOKPRO" ] 
then

    "packageInstallMBP.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT   

fi

echo "systemConfigPostInstall.sh" >> $SCRIPTREPORT
echo >> $SCRIPTREPORT


#if [ -n "$SURFACE" ] 
#then
#	systemConfigPostInstallSurface
#fi

if [ -n "$MACBOOKPRO" ] 
then

    "systemConfigPostInstallMBP.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT    
    
fi

if [ -n "$KDE" ] 
then

    "userSetupKDE.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT    
   
fi

if [ -n "$DESKTOP" ] 
then

    "userSetupDesktop.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT    
    
fi

echo "zfsBootSetup.sh" >> $SCRIPTREPORT
echo >> $SCRIPTREPORT

if [ -n "$MIRROR" ]
then

    "syncEFIs.sh" >> $SCRIPTREPORT
    echo >> $SCRIPTREPORT
    echo ''>> $SCRIPTREPORT        
fi

}
