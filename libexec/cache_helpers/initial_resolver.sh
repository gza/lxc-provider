#!/bin/bash
. ${lxc_GLOBAL_FUNCTIONS}
needed_var_check "lxc_CACHE_TMPROOTFS"

#cp the host's resolv.conf to the template
ROOTFS=${lxc_CACHE_TMPROOTFS}

[[ -d $ROOTFS/etc/ ]] || "$ROOTFS/etc/ dir not found"
cp /etc/resolv.conf $ROOTFS/etc/resolv.conf || die "cp /etc/resolv.conf $ROOTFS/etc/resolv.conf : failed"

echo "resolv.conf copied from host: OK"
exit 0
