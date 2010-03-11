#!/bin/bash

# locales.sh
# This script configures locales

#Load functions
. ${lxc_PATH_LIBEXEC}/functions.sh

#var checkings
needed_var_check "lxc_TMP_ROOTFS lxc_LANG"

#Shortcuts
rootfs=${lxc_TMP_ROOTFS}
lang="${lxc_LANG}"

#rootfs checking
[[ -f "${rootfs}/etc/lxc-provider.tag" ]] || die "${rootfs} is not a tagged rootfs"

#Pre-checks
[[ -x "${rootfs}/usr/sbin/dpkg-reconfigure" ]] || die "executable ${rootfs}/usr/sbin/dpkg-reconfigure not found"

#Set conf
cat > "${rootfs}/etc/default/locale" << EOF
#lxc-provider
LANG=${lang}
EOF

if egrep -q '#lxc-provider' "${rootfs}/etc/default/locale"
then
	d_green "locale setted to $lang\n"
else
	die "unable to set locale"
fi

#Reconfigure locales
LANGUAGE="C"
LC_ALL="C"
LANG="C"


if chroot ${rootfs} /usr/sbin/dpkg-reconfigure locales
then
	d_green "locales reconfigured: OK\n"
else
	die "/usr/sbin/dpkg-reconfigure locales : failed"
fi

exit 0
