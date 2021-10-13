#!/bin/bash

chroot $TEMPMOUNT /bin/bash -c "mkdir /home/$USER"

chroot $TEMPMOUNT /bin/bash -c "useradd -M -g users -G sudo,adm,plugdev,dip -s /bin/bash -d /home/$USER $USER"

chroot $TEMPMOUNT /bin/bash -c "cp -a /etc/skel/. /home/$USER"

chroot $TEMPMOUNT /bin/bash -c "mkdir -p /home/$USER/.ssh"

chroot $TEMPMOUNT /bin/bash -c "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCpK7l0iotVvTsvs+4LuYODQD+C7r7peA4CmssXUVtv8hVAuK753Lpf9ShTxJkiDWrpnrbw+Fs62RenCDr/zyLtG1jt76XBtnYWUGk0pSPinZH2uwKxZNxLNueb5/x4+RcA4UEsakvfvJ9ycwTDl6xnmoAShQbFoIc2bEbD3E4BpzqObg0a1sTNkk8qstxBVm1QR+HH6+uPifTZQqluL2CxS3D6n/AAb3nvcvlZAgnqZB0301jPhF8pppFvprS8CSHJCd4w9pjJKIK0QDaquvbS/t7arBZx+pJidFU072CaBFuqppQVGlVd6M0vpPr1yu1ihBxbcinZWjDr4agmMoNcNSjCErNLQkN6H5ngxSaebDv4FuiOhcJHubLzc1yYy9A59brHvpeFcmjkKh7Jr+iPMArP7Ls93ZkX7Z3PlOiHszEcCib3nPUcDwg0s4nPynP0iTKalQbmUZxqDZCjtPIqTz4LstJ+r5sqsD9/TBWo0E6z1xPCg2bRwtyWgENccOr7nCjVG2V84HfilsvDP1HiPEoWQoo2q00yA8dqeNMgbit03/AZ1qT0xCY1vkamAMQfubpgUeVkJIpE3T3fqfEFrYLuXSWgyw44pAz3iTit57bAmo9asbPVYe9kCOlBKOfxD4g9O7X/kcOk8ItSm0aPU4WC3A0VwvYvYZtgIWAZGQ== contact@samuelmcpherson.net' > /home/$USER/.ssh/authorized_keys"

chroot $TEMPMOUNT /bin/bash -c "chown -R $USER:users /home/$USER/"

chroot $TEMPMOUNT /bin/bash -c "echo root:$ROOTPASS | chpasswd"

chroot $TEMPMOUNT /bin/bash -c "echo $USER:$USERPASS | chpasswd"

