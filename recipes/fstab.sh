#!/bin/bash

#echo "/dev/sda2 / btrfs rw,subvol=/ 0 0" >>/etc/fstab
echo "/dev/sda2 /var btrfs rw,subvol=var 0 0" >>/etc/fstab
echo "/dev/sda2 /etc btrfs rw,subvol=etc 0 0" >>/etc/fstab
echo "/dev/sda2 /home btrfs rw,subvol=var/home 0 0" >>/etc/fstab
#echo "/dev/sda2 /usr btrfs rw,subvol=usr 0 0" >>/etc/fstab

ls -lh /
# mount -o subvol=sysroot /dev/vda2 /sysroot
# mount -o subvol=var /dev/vda2 /var
# mount -o subvol=boot /dev/vda2 /boot
# mount /dev/vda1 /boot/efi

ls -l /boot
ls -l /boot/efi
mount

bootctl install --esp-path=/boot/efi