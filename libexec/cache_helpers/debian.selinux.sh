#!/bin/bash
. ${lxc_GLOBAL_FUNCTIONS}
#Disables selinux in the VPS
needed_var_check "lxc_CACHE_TMPROOTFS"
ROOTFS=${lxc_CACHE_TMPROOTFS}

mkdir -p $ROOTFS/selinux || die "Unable to make $ROOTFS/selinux dir"
echo 0 > $ROOTFS/selinux/enforce || die "Unable to create $ROOTFS/selinux/enforce file"

echo "selinux disabled : OK"
exit 0
