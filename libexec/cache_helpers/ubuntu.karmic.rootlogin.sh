#!/bin/bash
. ${lxc_GLOBAL_FUNCTIONS}

#Enables root login on tty
#@TODO : make some post checks
needed_var_check "lxc_CACHE_TMPROOTFS"
ROOTFS=${lxc_CACHE_TMPROOTFS}

[[ -f "${ROOTFS}/etc/securetty" ]] || die "$ROOTFS/etc/securetty not found"

echo "UNKNOWN" >> "${ROOTFS}/etc/securetty"

echo "rootlogin enabled on : not verified"
exit 0

