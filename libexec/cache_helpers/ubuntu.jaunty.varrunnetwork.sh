#!/bin/bash
. ${lxc_GLOBAL_FUNCTIONS}
#Jaunty's init scripts does not creates /var/run/network

needed_var_check "lxc_CACHE_TMPROOTFS"
ROOTFS=${lxc_CACHE_TMPROOTFS}

[[ -d $ROOTFS/dev/ ]] || die "$ROOTFS/dev/ dir not found"
mkdir -p "${lxc_CACHE_TMPROOTFS}/dev/.initramfs/varrun/network" || die "unable to create ${lxc_CACHE_TMPROOTFS}/dev/.initramfs/varrun/network"

echo "/var/run/network : OK"
exit 0
