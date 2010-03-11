#!/bin/bash
. ${lxc_PATH_LIBEXEC}/functions.sh

#Disables some probelmatic services

needed_var_check "lxc_TMP_ROOTFS lxc_SVC_DISABLE"

LANGUAGE="C"
LC_ALL="C"
LANG="C"

ROOTFS=${lxc_TMP_ROOTFS}

[[ -x $ROOTFS/usr/sbin/update-rc.d ]] || die "No $ROOTFS/usr/sbin/update-rc.d executable found"

for svc in ${lxc_SVC_DISABLE}
do
	chroot $ROOTFS /usr/sbin/update-rc.d -f "${svc}" remove && echo "svc ${svc} disabled" || die "/usr/sbin/update-rc.d -f ${svc} remove : failed"
done

echo "Services disabled: OK"
exit 0
