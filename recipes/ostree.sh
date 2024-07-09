#!/bin/bash

ostree admin init-fs /scratch/mnt/sysroot
ostree admin os-init debian --sysroot /scratch/mnt/sysroot

alias cp="rsync -ah --inplace --no-whole-file --info=progress2"
rsync -ah --inplace --no-whole-file --info=progress2 $ARTIFACTDIR/build/ostree/ostree /scratch/mnt/sysroot

ostree admin deploy --sysroot /scratch/mnt/sysroot --os=debian debian/testing/amd64

EIB_OSTREE_CHECKOUT=/scratch/mnt/sysroot
OSTREE_CURRENT_DEPLOYMENT=$(ostree admin --sysroot="${EIB_OSTREE_CHECKOUT}" status | awk '{print $2; exit}')
echo "Current deployment: ${OSTREE_CURRENT_DEPLOYMENT}"

ls -lh /scratch/mnt/sysroot
ostree log --repo /scratch/mnt/sysroot/ostree/repo debian/testing/amd64

exit 1

# mount --bind /scratch/mnt /scratch/mnt/sysroot/ostree/deploy/debian/deploy/${OSTREE_CURRENT_DEPLOYMENT}
# mkdir -p /scratch/mnt/sysroot/ostree/deploy/debian/deploy/${OSTREE_CURRENT_DEPLOYMENT}/sysroot

# echo nameserver 8.8.8.8 >> /scratch/root/etc/resolv.conf
