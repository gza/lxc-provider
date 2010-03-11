#!/bin/bash
. ${lxc_PATH_LIBEXEC}/functions.sh

#Jaunty's init scripts does not creates /var/run/network

needed_var_check "lxc_TMP_ROOTFS"
ROOTFS=${lxc_TMP_ROOTFS}

[[ -d $ROOTFS/dev/ ]] || die "$ROOTFS/dev/ dir not found"
mkdir -p "${ROOTFS}/dev/.initramfs/varrun/network" || die "unable to create ${ROOTFS}/dev/.initramfs/varrun/network"

echo "/var/run/network : OK"
exit 0
