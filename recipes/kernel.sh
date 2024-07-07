#!/bin/bash

kernel="$(find /boot -name 'vmlinuz-*' | sort -V | tail -n 1)"
version="${kernel#*-}"

declare -A TOPLEVEL_LINKS=(
    ["home"]="var/home"
    ["media"]="run/media"
    ["mnt"]="var/mnt"
    ["opt"]="var/opt"
    # ["ostree"]="$OSTREE_SYSROOT/ostree"
    # ["root"]="var/roothome"
    ["srv"]="var/srv"
    ["etc"]="usr/etc"
)

for link in "${!TOPLEVEL_LINKS[@]}"; do
    target=${TOPLEVEL_LINKS[$link]}
    echo mv "$link" $(dirname "$target")
    mv "$link" $(dirname "$target")
    echo ln -sf "$target" "$link"
    ln -sf "$target" "$link"
done

mv root var/roothome
ln -sf var/roothome root

ln -s sysroot/ostree ostree

# remove etc from sysroot
rm -rf etc

echo $(date --utc +%Y-%m-%dT%H:%M:%S%Z) >/timestamp

echo "kernel: $kernel"
echo "version: $version"

SYSTEMD_ESP_PATH=/boot/ kernel-install --verbose --entry-token literal:Default add "$version" "$kernel"

# ostree kernel location: https://ostreedev.github.io/ostree/deployment/#contents-of-a-deployment
mkdir -p /usr/lib/modules/"$version"/
cp "$kernel" /usr/lib/modules/"$version"/vmlinuz
cp "/boot/initrd.img-$version" /usr/lib/modules/"$version"/initramfs.img
