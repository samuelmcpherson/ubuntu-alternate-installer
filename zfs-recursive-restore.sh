#!/bin/bash

 
# Recursively restores the zfs filesystems below a given filesystem to a snapshot
# e.g. given
#   the-pool
#   the-pool/var
#   the-pool/var/lib
#   the-pool/doris
#  and a snapshot of @backup
#
# using this script with the-pool/doris@backup will restore just that one file system
# Using this script with the-pool/var@backup will restore the-pool/var AND the-pool/var/lib
# Using this script with the-pool@backup will restore the-pool. the-pool/var, the-pool/var/lib AND
# the-pool/doris
#
# Accepts just one parameter - the root snapshot reference to restore, in the form of
# the-root-zfs-file-system@snapshot-name

usage() {
    echo "Usage: $0 zpool/root@snapshot"
}

if [ $# -ne 1 ]
then
    usage;
else
    # Pattern matches any valid filename character follwed by @ followeding by anything else
    regex="^([a-zA-Z0-9/\.\_\-]*)\@(.*)"
    if [[ ! $1 =~ $regex ]]
    then
        usage;
    else
        # Curious #/} here drops any leading /
        pool="${BASH_REMATCH[1]#/}"
        root_snapshot="${BASH_REMATCH[2]}"
        echo Restoring ${root_snapshot} in ${pool}
        while IFS= read -r snapshot; do
            echo -n "Rolling Back ${snapshot} : "
            # -r : also destroys the snapshots newer than the specified one
            # -R : also destroys the snapshots newer than the one specified and their clones
            # -f : forces an unmount of any clone file systems that are to be destroyed
            zfs rollback -r ${snapshot}
            echo "Done"
        done < <(zfs list -H -t snapshot -r $pool | grep "@$root_snapshot" | cut -f 1)
    fi
fi
