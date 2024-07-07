#!/bin/bash

OSTREE_SYSROOT=./build/ostree
OSTREE_REPO=$OSTREE_SYSROOT/ostree/repo

OS_NAME="debian"
BUILDER_ARCH="amd64"

REMOTE_NAME="main"
REMOTE_URL="file:///var/cache/ostree"
REMOTE_REPO_PATH=${OS_NAME}-repo-${BUILDER_ARCH}
OSTREE_REF="${OS_NAME}/testing/$BUILDER_ARCH"

if [ ! -d "$OSTREE_SYSROOT" ]; then
    mkdir -p "$OSTREE_REPO"
    ostree init --mode=archive --repo="$OSTREE_REPO"
    ostree admin init-fs --modern "$OSTREE_SYSROOT"
    ostree admin os-init --sysroot="$OSTREE_SYSROOT" "${OS_NAME}"
    ostree config --repo="$OSTREE_REPO" set sysroot.bootloader none
    ostree remote --repo="$OSTREE_REPO" add --no-gpg-verify --no-sign-verify "${REMOTE_NAME}" "$REMOTE_URL"/"$REMOTE_REPO_PATH" "$OSTREE_REF"
fi
