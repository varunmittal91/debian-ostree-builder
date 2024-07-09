#!/bin/bash

ls -lh /scratch/mnt
ls -lh /scratch/mnt/sysroot
ls -lh /scratch/mnt/sysroot/ostree/deploy/debian

EIB_OSTREE_CHECKOUT=/scratch/mnt/sysroot
EIB_OSTREE_OS=debian

OSTREE_CURRENT_DEPLOYMENT=$(ostree admin --sysroot="${EIB_OSTREE_CHECKOUT}" status | awk '{print $2; exit}')
echo "Current deployment: ${OSTREE_CURRENT_DEPLOYMENT}"

OSTREE_DEPLOYMENT="${EIB_OSTREE_CHECKOUT}"/ostree/deploy/${EIB_OSTREE_OS}/deploy/${OSTREE_CURRENT_DEPLOYMENT}
OSTREE_VAR="${EIB_OSTREE_CHECKOUT}"/ostree/deploy/${EIB_OSTREE_OS}/var
echo "Deployment: ${OSTREE_DEPLOYMENT}"
echo "Var: ${OSTREE_VAR}"

ls -lh $OSTREE_DEPLOYMENT
ls -lh $OSTREE_DEPLOYMENT/boot

cp -r $OSTREE_DEPLOYMENT/boot /scratch/mnt/boot/${OSTREE_CURRENT_DEPLOYMENT}

echo "Mounting btrfs subvolumes - boot"
ls -lh /scratch/mnt/boot
echo "Mounting btrfs subvolumes - boot done"

# ostree checkout 4bfd5675fb12df9db272eaf8a56ccfd62f3e00e0e17c5c42e82e88889caf3e1d ${OSTREE_DEPLOYMENT} --union-add
ls -lh $OSTREE_DEPLOYMENT/usr/bin | grep nano

mount --bind,rw /scratch/mnt/sysroot/ostree/deploy/debian/deploy/${OSTREE_CURRENT_DEPLOYMENT} /scratch/mnt/
ls -lh /scratch/mnt

cat /etc/fstab
echo "/sys ${OSTREE_DEPLOYMENT}/sys none bind 0 0" >>/etc/fstab
echo "/proc ${OSTREE_DEPLOYMENT}/proc none bind 0 0" >>/etc/fstab
echo "/dev ${OSTREE_DEPLOYMENT}/dev none bind 0 0" >>/etc/fstab
echo "/dev/pts ${OSTREE_DEPLOYMENT}/dev/pts none bind 0 0" >>/etc/fstab
echo "/var ${OSTREE_DEPLOYMENT}/var none bind 0 0" >>/etc/fstab
#echo "/sysroot ${OSTREE_DEPLOYMENT}/sysroot none bind 0 0" >>/etc/fstab
echo "${OSTREE_DEPLOYMENT} / none bind 0 0" >>/etc/fstab
cat /etc/fstab

mount --bind /sys /scratch/mnt/sys
mount --bind /proc /scratch/mnt/proc
mount --bind /dev /scratch/mnt/dev
mount --bind /dev/pts /scratch/mnt/dev/pts
# mount --bind "${OSTREE_VAR}" "${OSTREE_DEPLOYMENT}"/var
# mount --bind "${EIB_OSTREE_CHECKOUT}" "${OSTREE_DEPLOYMENT}"/sysroot

# mount subvolumes systree using btrfs
mount --bind,subvol=sysroot /dev/vda2 /scratch/mnt/sysroot
mount --bind,subvol=var /dev/vda2 /scratch/mnt/var
mount --bind,subvol=boot /dev/vda2 /scratch/mnt/boot
mount --bind /dev/vda1 /scratch/mnt/boot/efi

# mount -o subvol=sysroot /dev/vda2 /scratch/mnt/sysroot
# mount -o subvol=var /dev/vda2 /scratch/mnt/var
# mount -o subvol=boot /dev/vda2 /scratch/mnt/boot

mkdir -p /scratch/mnt/boot/efi
mount /dev/vda1 /scratch/mnt/boot/efi

echo "Mounting btrfs subvolumes"
# ls -lh /scratch/mnt/etc
mount -o subvol=etc /dev/vda2 /scratch/mnt/etc
# ls -lh /scratch/mnt/etc
echo "Mounting btrfs subvolumes"

#mkdir -p "${OSTREE_DEPLOYMENT}"/etc

mount
ls -lh /scratch/mnt/boot
ls -lh /scratch/mnt/boot/efi

# add these to the fstab
echo "/sys ${OSTREE_DEPLOYMENT}/sys none bind 0 0" >>"${OSTREE_DEPLOYMENT}"/etc/fstab
echo "/proc ${OSTREE_DEPLOYMENT}/proc none bind 0 0" >>"${OSTREE_DEPLOYMENT}"/etc/fstab
echo "/dev ${OSTREE_DEPLOYMENT}/dev none bind 0 0" >>"${OSTREE_DEPLOYMENT}"/etc/fstab
echo "/dev/pts ${OSTREE_DEPLOYMENT}/dev/pts none bind 0 0" >>"${OSTREE_DEPLOYMENT}"/etc/fstab
echo "/var ${OSTREE_DEPLOYMENT}/var none bind 0 0" >>"${OSTREE_DEPLOYMENT}"/etc/fstab
#echo "/sysroot ${OSTREE_DEPLOYMENT}/sysroot none bind 0 0" >>"${OSTREE_DEPLOYMENT}"/etc/fstab
echo "${OSTREE_DEPLOYMENT} / none bind 0 0" >>/etc/fstab
