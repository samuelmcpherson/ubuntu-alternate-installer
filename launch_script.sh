#!/bin/bash

export USER=$1

export USERPASS=$2

export ROOTPASS=$3

menuStart()
{
RUNCOUNT=0    
while true
do    
n=
if (( $RUNCOUNT < 1 ))
then 
DEFAULT=1
echo "Starting installation: $CURRENTFUNC $CURRENTARGS is the current function to run."
echo ""
elif (( $RUNCOUNT >= 1 ))
then 
DEFAULT=4
else 
echo "Something weird happend with the functions RUNCOUNT that determines the correct default option to take when no user input is given. The timeout variable will be set to 10,000 seconds to avoid any issues that may result from this. This can be reversed by opening a shell to the live environment setting it to a new value with 'export TIMEOUT=#' with # being any number of seconds."
TIMEOUT=10000
fi

echo "select the operation ************"
echo ""
echo "  1)Run $CURRENTFUNC $CURRENTARGS"
echo "  2)Edit $CURRENTFUNC"
echo "  3)Open Shell to live environment"
echo "  4)Skip running $CURRENTFUNC $CURRENTARGS and continue to next function" 
echo "  5)Abort install"

read -t $TIMEOUT n
if [ -z "$n" ]
then
    n=$DEFAULT
fi
case $n in
  1) $SCRIPTDIR/subScripts/$CURRENTFUNC $CURRENTARGS $@ ;;
  2) vim $SCRIPTDIR/subScripts/$CURRENTFUNC ;;
  3) /bin/bash ;;
  4) break ;;
  5) exit 1 ;;
  *) echo "invalid option";;
esac

echo ''

CURRENTFUNCSTATUS=${PIPESTATUS[0]}

if [ $n = 1 ]
then
    if [ "$CURRENTFUNCSTATUS" == 1 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and FAILED"
        echo ""
    elif [ "$CURRENTFUNCSTATUS" == 0 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and SUCCEEDED"
        echo ""
        RUNCOUNT=$(($RUNCOUNT + 1))
    fi
fi
done
}

menuPreSystem()
{
RUNCOUNT=0    
while true
do    
n=
if (( $RUNCOUNT < 1 ))
then 
DEFAULT=1
echo "$LASTFUNC $LASTARGS was the previous function. $CURRENTFUNC $CURRENTARGS is the current function to run."
echo ""
elif (( $RUNCOUNT >= 1 ))
then 
DEFAULT=4
else 
echo "Something weird happend with the functions RUNCOUNT that determines the correct default option to take when no user input is given. The timeout variable will be set to 10,000 seconds to avoid any issues that may result from this. This can be reversed by opening a shell to the live environment setting it to a new value with 'export TIMEOUT=#' with # being any number of seconds."
TIMEOUT=10000
fi

echo "select the operation ************"
echo ""
echo "  1)Run $CURRENTFUNC $CURRENTARGS"
echo "  2)Edit $CURRENTFUNC"
echo "  3)Open Shell to live environment"
echo "  4)Skip running $CURRENTFUNC $CURRENTARGS and continue to next function" 
echo "  5)Go back to $LASTFUNC $LASTARGS"
echo "  6)Abort install"

read -t $TIMEOUT n
if [ -z "$n" ]
then
    n=$DEFAULT
fi
case $n in
  1) $SCRIPTDIR/subScripts/$CURRENTFUNC $CURRENTARGS $@ ;;
  2) vim $SCRIPTDIR/subScripts/$CURRENTFUNC ;;
  3) /bin/bash ;;
  4) break ;;
  5) NEXTFUNC=$CURRENTFUNC; NEXTARGS=$CURRENTARGS; CURRENTFUNC=$LASTFUNC; CURRENTARGS=$LASTARGS; menuPreSystemPrev ;;
  6) exit 1 ;;
  *) echo "invalid option";;
esac

echo ''

CURRENTFUNCSTATUS=${PIPESTATUS[0]}

if [ $n = 1 ]
then
    if [ "$CURRENTFUNCSTATUS" == 1 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and FAILED"
        echo ""
        RUNCOUNT=0
    elif [ "$CURRENTFUNCSTATUS" == 0 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and SUCCEEDED"
        echo ""
        RUNCOUNT=$(($RUNCOUNT + 1))
    fi
fi
done
}

menuPreSystemPrev()
{
RUNCOUNT=0    
while true
do    
n=
if (( $RUNCOUNT < 1 ))
then 
DEFAULT=1
echo "$LASTFUNC $LASTARGS was the previous function. $CURRENTFUNC $CURRENTARGS is the current function to run."
echo ""
elif (( $RUNCOUNT >= 1 ))
then 
DEFAULT=4
else 
echo "Something weird happend with the functions RUNCOUNT that determines the correct default option to take when no user input is given. The timeout variable will be set to 10,000 seconds to avoid any issues that may result from this. This can be reversed by opening a shell to the live environment setting it to a new value with 'export TIMEOUT=#' with # being any number of seconds."
TIMEOUT=10000
fi

echo "select the operation ************"
echo ""
echo "  1)Run $CURRENTFUNC $CURRENTARGS"
echo "  2)Edit $CURRENTFUNC"
echo "  3)Open Shell to live environment"
echo "  4)Skip forward to $NEXTFUNC $NEXTARGS" 
echo "  5)Abort install"

read -t $TIMEOUT n
if [ -z "$n" ]
then
    n=$DEFAULT
fi
case $n in
  1) $SCRIPTDIR/subScripts/$CURRENTFUNC $CURRENTARGS $@ ;;
  2) vim $SCRIPTDIR/subScripts/$CURRENTFUNC ;;
  3) /bin/bash ;;
  4) LASTFUNC=$CURRENTFUNC; LASTARGS=$CURRENTARGS; CURRENTFUNC=$NEXTFUNC; CURRENTARGS=$NEXTARGS; break ;;
  5) exit 1 ;;
  *) echo "invalid option";;
esac

echo ''

CURRENTFUNCSTATUS=${PIPESTATUS[0]}

if [ $n = 1 ]
then
    if [ "$CURRENTFUNCSTATUS" == 1 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and FAILED"
        echo ""
        RUNCOUNT=0
    elif [ "$CURRENTFUNCSTATUS" == 0 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and SUCCEEDED"
        echo ""
        RUNCOUNT=$(($RUNCOUNT + 1))
    fi
fi
done
}

menuPreSystemPostZfs()
{
RUNCOUNT=0    
while true
do    
n=
if (( $RUNCOUNT < 1 ))
then 
DEFAULT=1
echo "$LASTFUNC $LASTARGS was the previous function. $CURRENTFUNC $CURRENTARGS is the current function to run."
echo ""
elif (( $RUNCOUNT >= 1 ))
then 
DEFAULT=5
else 
echo "Something weird happend with the functions RUNCOUNT that determines the correct default option to take when no user input is given. The timeout variable will be set to 10,000 seconds to avoid any issues that may result from this. This can be reversed by opening a shell to the live environment setting it to a new value with 'export TIMEOUT=#' with # being any number of seconds."
TIMEOUT=10000
fi

echo "select the operation ************"
echo ""
echo "  1)Run $CURRENTFUNC $CURRENTARGS"
echo "  2)Edit $CURRENTFUNC"
echo "  3)**ONLY AVAILABLE FOR ZFS INSTALLS** Rollback system state to snapshot from before $CURRENTFUNC $CURRENTARGS was run"
echo "  4)Open Shell to live environment"
echo "  5)Skip running $CURRENTFUNC $CURRENTARGS and continue to next function" 
echo "  6)Go back to $LASTFUNC $LASTARGS"
echo "  7)Abort install"

read -t $TIMEOUT n
if [ -z "$n" ]
then
    n=$DEFAULT
fi
case $n in
  1) $SCRIPTDIR/subScripts/$CURRENTFUNC $CURRENTARGS $@ ;;
  2) vim $SCRIPTDIR/subScripts/$CURRENTFUNC ;;
  3) if [ -n "$ZFS" ]; then umount -Rl $TEMPMOUNT; $SCRIPTDIR/zfs-recursive-restore.sh rpool@$CURRENTFUNC-$CURRENTARGS; $SCRIPTDIR/zfs-recursive-restore.sh bpool@$CURRENTFUNC-$CURRENTARGS; $SCRIPTDIR/subScripts/systemMounts.sh; else echo "NOT A ZFS INSTALL"; fi ;;
  4) /bin/bash ;;
  5) break ;;
  6) NEXTFUNC=$CURRENTFUNC; NEXTARGS=$CURRENTARGS; CURRENTFUNC=$LASTFUNC; CURRENTARGS=$LASTARGS; menuPreSystemPostZfsPrev ;;
  7) exit 1 ;;
  *) echo "invalid option";;
esac

echo ''

CURRENTFUNCSTATUS=${PIPESTATUS[0]}

if [ $n = 1 ]
then
    if [ "$CURRENTFUNCSTATUS" == 1 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and FAILED"
        echo ""
        RUNCOUNT=0
    elif [ "$CURRENTFUNCSTATUS" == 0 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and SUCCEEDED"
        echo ""
        RUNCOUNT=$(($RUNCOUNT + 1))
    fi
fi
done
}

menuPreSystemPostZfsPrev()
{
RUNCOUNT=0    
while true
do    
n=
if (( $RUNCOUNT < 1 ))
then 
DEFAULT=1
echo "$LASTFUNC $LASTARGS was the previous function. $CURRENTFUNC $CURRENTARGS is the current function to run."
echo ""
elif (( $RUNCOUNT >= 1 ))
then 
DEFAULT=5
else 
echo "Something weird happend with the functions RUNCOUNT that determines the correct default option to take when no user input is given. The timeout variable will be set to 10,000 seconds to avoid any issues that may result from this. This can be reversed by opening a shell to the live environment setting it to a new value with 'export TIMEOUT=#' with # being any number of seconds."
TIMEOUT=10000
fi

echo "select the operation ************"
echo ""
echo "  1)Run $CURRENTFUNC $CURRENTARGS"
echo "  2)Edit $CURRENTFUNC $CURRENTARGS"
echo "  3)**ONLY AVAILABLE FOR ZFS INSTALLS** Rollback system state to snapshot from before $CURRENTFUNC $CURRENTARGS was run"
echo "  4)Open Shell to live environment"
echo "  5)Skip forward to $NEXTFUNC $NEXTARGS" 
echo "  6)Abort install"

read -t $TIMEOUT n
if [ -z "$n" ]
then
    n=$DEFAULT
fi
case $n in
  1) $SCRIPTDIR/subScripts/$CURRENTFUNC $CURRENTARGS $@ ;;
  2) vim $SCRIPTDIR/subScripts/$CURRENTFUNC ;;
  3) if [ -n "$ZFS" ]; then umount -Rl $TEMPMOUNT; $SCRIPTDIR/zfs-recursive-restore.sh rpool@$CURRENTFUNC-$CURRENTARGS; $SCRIPTDIR/zfs-recursive-restore.sh bpool@$CURRENTFUNC-$CURRENTARGS; $SCRIPTDIR/subScripts/systemMounts.sh; else echo "NOT A ZFS INSTALL"; fi ;;
  4) /bin/bash ;;
  5) LASTFUNC=$CURRENTFUNC; LASTARGS=$CURRENTARGS; CURRENTFUNC=$NEXTFUNC; CURRENTARGS=$NEXTARGS; break ;;
  6) exit 1 ;;
  *) echo "invalid option";;
esac

echo ''

CURRENTFUNCSTATUS=${PIPESTATUS[0]}

if [ $n = 1 ]
then
    if [ "$CURRENTFUNCSTATUS" == 1 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and FAILED"
        echo ""
        RUNCOUNT=0
    elif [ "$CURRENTFUNCSTATUS" == 0 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and SUCCEEDED"
        echo ""
        RUNCOUNT=$(($RUNCOUNT + 1))
    fi
fi
done
}

menuFull()
{
RUNCOUNT=0    
while true
do    
n=
if (( $RUNCOUNT < 1 ))
then 
DEFAULT=1
echo "$LASTFUNC $LASTARGS was the previous function. $CURRENTFUNC $CURRENTARGS is the current function to run."
echo ""
elif (( $RUNCOUNT >= 1 ))
then 
DEFAULT=6
else 
echo "Something weird happend with the functions RUNCOUNT that determines the correct default option to take when no user input is given. The timeout variable will be set to 10,000 seconds to avoid any issues that may result from this. This can be reversed by opening a shell to the live environment setting it to a new value with 'export TIMEOUT=#' with # being any number of seconds."
TIMEOUT=10000
fi

echo "select the operation ************"
echo ""
echo "  1)Run $CURRENTFUNC $CURRENTARGS"
echo "  2)Edit $CURRENTFUNC $CURRENTARGS"
echo "  3)**ONLY AVAILABLE FOR ZFS INSTALLS** Rollback system state to snapshot from before $CURRENTFUNC $CURRENTARGS was run"
echo "  4)Open Shell to live environment"
echo "  5)Open chroot to current install"
echo "  6)Skip running $CURRENTFUNC $CURRENTARGS and continue to next function" 
echo "  7)Go back to $LASTFUNC $LASTARGS"
echo "  8)Abort install"

read -t $TIMEOUT n
if [ -z "$n" ]
then
    n=$DEFAULT
fi
case $n in
  1) $SCRIPTDIR/subScripts/$CURRENTFUNC $CURRENTARGS $@ ;;
  2) vim $SCRIPTDIR/subScripts/$CURRENTFUNC ;;
  3) if [ -n "$ZFS" ]; then umount -Rl $TEMPMOUNT; $SCRIPTDIR/zfs-recursive-restore.sh rpool@$CURRENTFUNC-$CURRENTARGS; $SCRIPTDIR/zfs-recursive-restore.sh bpool@$CURRENTFUNC-$CURRENTARGS; $SCRIPTDIR/subScripts/systemMounts.sh; else echo "NOT A ZFS INSTALL"; fi ;;
  4) /bin/bash ;;
  5) chroot $TEMPMOUNT /bin/bash ;;
  6) break ;;
  7) NEXTFUNC=$CURRENTFUNC; NEXTARGS=$CURRENTARGS; CURRENTFUNC=$LASTFUNC; CURRENTARGS=$LASTARGS; menuFullPrev ;;
  8) exit 1 ;;
esac

echo ''

CURRENTFUNCSTATUS=${PIPESTATUS[0]}

if [ $n = 1 ]
then
    if [ "$CURRENTFUNCSTATUS" == 1 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and FAILED"
        echo ""
        RUNCOUNT=0
    elif [ "$CURRENTFUNCSTATUS" == 0 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and SUCCEEDED"
        echo ""
        RUNCOUNT=$(($RUNCOUNT + 1))
    fi
fi
done
}

menuFullPrev()
{
RUNCOUNT=0    
while true
do    
n=
if (( $RUNCOUNT < 1 ))
then 
DEFAULT=1
echo "$LASTFUNC $LASTARGS was the previous function. $CURRENTFUNC $CURRENTARGS is the current function to run."
elif (( $RUNCOUNT >= 1 ))
then 
DEFAULT=6
else 
echo "Something weird happend with the functions RUNCOUNT that determines the correct default option to take when no user input is given. The timeout variable will be set to 10,000 seconds to avoid any issues that may result from this. This can be reversed by opening a shell to the live environment setting it to a new value with 'export TIMEOUT=#' with # being any number of seconds."
TIMEOUT=10000
fi

echo "select the operation ************"
echo ""
echo "  1)Run $CURRENTFUNC $CURRENTARGS"
echo "  2)Edit $CURRENTFUNC $CURRENTARGS"
echo "  3)**ONLY AVAILABLE FOR ZFS INSTALLS** Rollback system state to snapshot from before $CURRENTFUNC $CURRENTARGS was run"
echo "  4)Open Shell to live environment"
echo "  5)Open chroot to current install"
echo "  6)Skip forward to $NEXTFUNC $NEXTARGS" 
echo "  7)Abort install"

read -t $TIMEOUT n
if [ -z "$n" ]
then
    n=$DEFAULT
fi
case $n in
  1) $SCRIPTDIR/subScripts/$CURRENTFUNC $CURRENTARGS $@ ;;
  2) vim $SCRIPTDIR/subScripts/$CURRENTFUNC ;;
  3) if [ -n "$ZFS" ]; then umount -Rl $TEMPMOUNT; $SCRIPTDIR/zfs-recursive-restore.sh rpool@$CURRENTFUNC-$CURRENTARGS; $SCRIPTDIR/zfs-recursive-restore.sh bpool@$CURRENTFUNC-$CURRENTARGS; $SCRIPTDIR/subScripts/systemMounts.sh; else echo "NOT A ZFS INSTALL"; fi ;;
  4) /bin/bash ;;
  5) chroot $TEMPMOUNT /bin/bash ;;
  6) LASTFUNC=$CURRENTFUNC; LASTARGS=$CURRENTARGS; CURRENTFUNC=$NEXTFUNC; CURRENTARGS=$NEXTARGS; break ;;
  7) exit 1 ;;
esac

echo ''

CURRENTFUNCSTATUS=${PIPESTATUS[0]}

if [ $n = 1 ]
then
    if [ "$CURRENTFUNCSTATUS" == 1 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and FAILED"
        echo ""
        RUNCOUNT=0
    elif [ "$CURRENTFUNCSTATUS" == 0 ]
    then
        echo ""
        echo "$CURRENTFUNC $CURRENTARGS ran and SUCCEEDED"
        echo ""
        RUNCOUNT=$(($RUNCOUNT + 1))
    fi
fi
done
}

# environment prep

apt install -y debootstrap gdisk zfs-initramfs vim

systemctl stop zed

source ./script-variables.sh

echo "Start $(date +%Y-%m-%d_%H:%M)"

if [ -n "$ZFS" ] && [ -z "$RPART" ] && [ -z "$BPART" ] && [ -n "$DISK1" ] && [ -n "$DISK2" ]
then

    export CURRENTFUNC="baseSystem/diskFormat.sh"
    export CURRENTARGS=$DISK1
    echo "Beginning automanted ubuntu zfs on root install with $CURRENTFUNC $CURRENTARGS"
    menuStart
    
    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS


    export CURRENTFUNC="baseSystem/diskFormat.sh"
    export CURRENTARGS=$DISK2
	menuPreSystem
    
    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS


    export CURRENTFUNC="baseSystem/bpoolSetup.sh"
    
    if [ -n "$EFI" ] && [ -z "$BIOS" ]
    then

        export CURRENTARGS="$DISK1-part2 $DISK2-part2"
    
    elif [ -z "$EFI" ] && [ -n "$BIOS" ]
    then

        export CURRENTARGS="$DISK1-part1 $DISK2-part1"

    else

        echo "Variables for EFI or BIOS install are both unset, aborting..."
        exit 1

    fi

    menuPreSystem
    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS    


    export CURRENTFUNC="baseSystem/rpoolSetup.sh"

    if [ -n "$EFI" ] && [ -z "$BIOS" ]
    then

        export CURRENTARGS="$DISK1-part3 $DISK2-part3"
    
    elif [ -z "$EFI" ] && [ -n "$BIOS" ]
    then

        export CURRENTARGS="$DISK1-part2 $DISK2-part2"

    else
    
        echo "Variables for EFI or BIOS install are both unset, aborting..."
        exit 1

    fi

    menuPreSystem
    
    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS

    if [ -n "$EFI" ] && [ -z "$BIOS" ] 
    then
        export EFIPART="$DISK1-part1"
        export EFIPART_2="$DISK2-part1"

    fi

elif [ -n "$ZFS" ] && [ -z "$RPART" ] && [ -z "$BPART" ] && [ -n "$DISK1" ] && [ -z "$DISK2" ]
then

    export CURRENTFUNC="baseSystem/diskFormat.sh"
    export CURRENTARGS=$DISK1
    echo "Beginning automanted ubuntu zfs on root install with $CURRENTFUNC $CURRENTARGS"
    menuStart
    
    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS


    export CURRENTFUNC="baseSystem/bpoolSetup.sh"

    if [ -n "$EFI" ] && [ -z "$BIOS" ]
    then

        export CURRENTARGS="$DISK1-part2"
    
    elif [ -z "$EFI" ] && [ -n "$BIOS" ]
    then

        export CURRENTARGS="$DISK1-part1"

    else
    
        echo "Variables for EFI or BIOS install are both unset, aborting..."
        exit 1

    fi

    menuPreSystem
    
    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS 


    export CURRENTFUNC="baseSystem/rpoolSetup.sh"

    if [ -n "$EFI" ] && [ -z "$BIOS" ]
    then

        export CURRENTARGS="$DISK1-part3"
    
    elif [ -z "$EFI" ] && [ -n "$BIOS" ]
    then

        export CURRENTARGS="$DISK1-part2"

    else
    
        echo "Variables for EFI or BIOS install are both unset, aborting..."
        exit 1

    fi

    menuPreSystem
    
    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS

    if [ -n "$EFI" ] && [ -z "$BIOS" ] 
    then
        export EFIPART="$DISK1-part1"
    fi

elif [ -n "$ZFS" ] && [ -n "$RPART" ] && [ -n "$BPART" ] && [ -z "$DISK1" ] && [ -z "$DISK2" ] 
then
    
    export CURRENTFUNC="baseSystem/bpoolSetup.sh"
    export CURRENTARGS=$BPART
    echo "Beginning automanted ubuntu zfs on root install with $CURRENTFUNC $CURRENTARGS"
    menuStart
    
    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS
    

    export CURRENTFUNC="baseSystem/rpoolSetup.sh"
    export CURRENTARGS=$RPART
    menuPreSystem
    
    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS
   

elif [ -z "$ZFS" ] 
then 


    export CURRENTFUNC="baseSystem/diskFormat.sh"
    export CURRENTARGS=$DISK1
    echo "Beginning automanted ubuntu zfs on root install with $CURRENTFUNC $CURRENTARGS"
    menuStart
    
    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS

    if [ -n "$EFI" ] && [ -z "$BIOS" ]
    then

        export EFIPART="$DISK1-part1"

        export EXT4ROOT="$DISK1-part2"
    
    elif [ -z "$EFI" ] && [ -n "$BIOS" ]
    then

        export EXT4ROOT="$DISK1-part1"

    fi
    
else
	echo "Failed to setup disks correctly"
	exit 1
fi

if [ -n "$ZFS" ]
then

export CURRENTFUNC="baseSystem/createZfsDatasets.sh"
export CURRENTARGS=
menuPreSystem

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS

fi
# -------------------------------------- zfs rollback able at this point

export CURRENTFUNC="baseSystem/bootstrap.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuPreSystemPostZfs

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS




export CURRENTFUNC="baseSystem/systemMounts.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuPreSystemPostZfs

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS

# ----------------------------- chrootable from this point

export CURRENTFUNC="baseSystem/baseChrootConfig.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="baseSystem/packageInstallBase.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="baseSystem/systemConfigPostInstall.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="baseSystem/userSetup.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="baseSystem/bootSetup.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


if [ -n "$MIRROR" ] && [ -n "$EFI" ]
then

    export CURRENTFUNC="baseSystem/syncEFIs.sh"
    export CURRENTARGS=
    
    if [ -n "$ZFS" ]
    then
    zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
    fi
    
    menuFull
    
    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS

fi

if [ -n "$ZFS" ]
    then
    zfs snapshot -r rpool@base-install; zfs snapshot -r bpool@base-install
fi

echo '#########################################################################################'
echo '#########################################################################################'
echo 'Minimal base system has been successfully installed, now performing extra configurations'
echo '#########################################################################################'
echo '#########################################################################################'

if [ -n "$ZFS" ]
then

    export CURRENTFUNC="extraConfiguration/createExtraZfsDatasets.sh"
    export CURRENTARGS=


    if [ -n "$ZFS" ]
    then
        zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
    fi

    menuFull

    export LASTFUNC=$CURRENTFUNC
    export LASTARGS=$CURRENTARGS

fi


export CURRENTFUNC="extraConfiguration/generalConfigurations.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
    zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="extraConfiguration/packageInstallBase.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
    zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="extraConfiguration/packageInstallAnsible.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
    zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="extraConfiguration/packageInstallDocker.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
    zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="extraConfiguration/packageInstallKDE.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
    zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="extraConfiguration/packageInstallDesktop.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
    zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="extraConfiguration/packageInstallGames.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
    zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="extraConfiguration/userSetupKDE.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
    zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS


export CURRENTFUNC="extraConfiguration/userSetupDesktop.sh"
export CURRENTARGS=

if [ -n "$ZFS" ]
then
    zfs snapshot -r rpool@$CURRENTFUNC-$CURRENTARGS; zfs snapshot -r bpool@$CURRENTFUNC-$CURRENTARGS
fi

menuFull

export LASTFUNC=$CURRENTFUNC
export LASTARGS=$CURRENTARGS

exit 0
