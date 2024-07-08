#!/bin/bash

echo "Creating btrfs subvolumes"
btrfs subvolume create /scratch/mnt/var
btrfs subvolume create /scratch/mnt/etc
btrfs subvolume create /scratch/mnt/var/home
btrfs subvolume create /scratch/mnt/usr

btrfs subvolume list /scratch/mnt

echo "Mounting btrfs subvolumes"
mount -o subvol=var /dev/vda2 /scratch/mnt/var
mount -o subvol=etc /dev/vda2 /scratch/mnt/etc

mkdir -p /scratch/mnt/home
mount -o subvol=var/home /dev/vda2 /scratch/mnt/home
