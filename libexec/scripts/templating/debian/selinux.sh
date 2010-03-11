#!/bin/bash
. ${lxc_PATH_LIBEXEC}/functions.sh

#Disables selinux in the VPS
needed_var_check "lxc_TMP_ROOTFS"
ROOTFS=${lxc_TMP_ROOTFS}

mkdir -p $ROOTFS/selinux || die "Unable to make $ROOTFS/selinux dir"
echo 0 > $ROOTFS/selinux/enforce || die "Unable to create $ROOTFS/selinux/enforce file"

echo "selinux disabled : OK"
exit 0
