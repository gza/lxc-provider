#!/bin/bash
. ${lxc_GLOBAL_FUNCTIONS}
#Disables some probelmatic services

needed_var_check "lxc_CACHE_TMPROOTFS lxc_CACHE_DISSVC"

LANGUAGE="C"
LC_ALL="C"
LANG="C"

ROOTFS=${lxc_CACHE_TMPROOTFS}

[[ -x $ROOTFS/usr/sbin/update-rc.d ]] || die "No $ROOTFS/usr/sbin/update-rc.d executable found"

for svc in ${lxc_CACHE_DISSVC}
do
	chroot $ROOTFS /usr/sbin/update-rc.d -f "${svc}" remove && echo "svc ${svc} disabled" || die "/usr/sbin/update-rc.d -f ${svc} remove : failed"
done

echo "Services disabled: OK"
exit 0
