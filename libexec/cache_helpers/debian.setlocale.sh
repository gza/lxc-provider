#!/bin/bash
. ${lxc_GLOBAL_FUNCTIONS}

#Launches reconfiguration of locales
needed_var_check "lxc_CACHE_TMPROOTFS lxc_GLOBAL_DEFAULT_LANG"

LANG="${lxc_GLOBAL_DEFAULT_LANG}"
ROOTFS=${lxc_CACHE_TMPROOTFS}

[[ -d "$ROOTFS/etc/default" ]] || die "dir $ROOTFS/etc/default not found"
echo "LANG=${LANG}" > "${ROOTFS}/etc/default/locale" || die "cannot create ${ROOTFS}/etc/default/locale"

echo "locale seted: OK"
exit 0
