#!/bin/bash
. ${lxc_GLOBAL_FUNCTIONS}

LANGUAGE="C"
LC_ALL="C"
LANG="C"

#Launches reconfiguration of locales
needed_var_check "lxc_CACHE_TMPROOTFS"

ROOTFS=${lxc_CACHE_TMPROOTFS}
[[ -x "$ROOTFS/usr/sbin/dpkg-reconfigure" ]] || die "executable $ROOTFS/usr/sbin/dpkg-reconfigure not found"

chroot $ROOTFS /usr/sbin/dpkg-reconfigure locales || die "/usr/sbin/dpkg-reconfigure locales : failed"

echo "locales reconfigured: OK"
exit 0
