#!/bin/bash


chroot $TEMPMOUNT /bin/bash -c "apt install -y bcmwl-kernel-source mbpfan && echo '---> apt install bcmwl-kernel-source mbpfan succeeded <--------------------------------------------------------------' || { echo 'apt install bcmwl-kernel-source mbpfan failed'; exit 1; }" || exit 1

chroot $TEMPMOUNT /bin/bash -c "systemctl unmask mbpfan"
