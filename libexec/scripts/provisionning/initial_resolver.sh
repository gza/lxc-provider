#!/bin/bash
. ${lxc_PATH_LIBEXEC}/functions.sh

needed_var_check "lxc_TMP_ROOTFS"

#cp the host's resolv.conf to the template
ROOTFS=${lxc_TMP_ROOTFS}

[[ -d $ROOTFS/etc/ ]] || "$ROOTFS/etc/ dir not found"
cp /etc/resolv.conf $ROOTFS/etc/resolv.conf || die "cp /etc/resolv.conf $ROOTFS/etc/resolv.conf : failed"

echo "resolv.conf copied from host: OK"
exit 0
