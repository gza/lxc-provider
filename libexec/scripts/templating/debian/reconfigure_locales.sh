#!/bin/bash
. ${lxc_PATH_LIBEXEC}/functions.sh


LANGUAGE="C"
LC_ALL="C"
LANG="C"

#Launches reconfiguration of locales
needed_var_check "lxc_TMP_ROOTFS"

ROOTFS=${lxc_TMP_ROOTFS}
[[ -x "$ROOTFS/usr/sbin/dpkg-reconfigure" ]] || die "executable $ROOTFS/usr/sbin/dpkg-reconfigure not found"

chroot $ROOTFS /usr/sbin/dpkg-reconfigure locales || die "/usr/sbin/dpkg-reconfigure locales : failed"

echo "locales reconfigured: OK"
exit 0
