#!/bin/bash
. ${lxc_PATH_LIBEXEC}/functions.sh

#Launches reconfiguration of locales
needed_var_check "lxc_TMP_ROOTFS lxc_LANG"

LANG="${lxc_LANG}"
ROOTFS=${lxc_TMP_ROOTFS}

[[ -d "$ROOTFS/etc/default" ]] || die "dir $ROOTFS/etc/default not found"
echo "LANG=${LANG}" > "${ROOTFS}/etc/default/locale" || die "cannot create ${ROOTFS}/etc/default/locale"

echo "locale seted: OK"
exit 0
