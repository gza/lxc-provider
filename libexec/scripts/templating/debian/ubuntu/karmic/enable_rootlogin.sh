#!/bin/bash
. ${lxc_PATH_LIBEXEC}/functions.sh

#Enables root login on tty
#@TODO : make some post checks
needed_var_check "lxc_TMP_ROOTFS"
ROOTFS=${lxc_TMP_ROOTFS}

[[ -f "${ROOTFS}/etc/securetty" ]] || die "$ROOTFS/etc/securetty not found"

echo "UNKNOWN" >> "${ROOTFS}/etc/securetty"

echo "rootlogin enabled on : not verified"
exit 0

