#!/bin/bash

# locales.sh
# This script configures locales

#Load functions
. ${lxc_PATH_LIBEXEC}/functions.sh

#var checkings
needed_var_check "lxc_TMP_ROOTFS lxc_DEBIAN_LOCALE lxc_DEBIAN_CHARSET"

#Shortcuts
rootfs=${lxc_TMP_ROOTFS}

#rootfs checking
[[ -f "${rootfs}/etc/lxc-provider.tag" ]] || die "${rootfs} is not a tagged rootfs"

#Pre-checks
[[ -x "${rootfs}/usr/sbin/dpkg-reconfigure" ]] || die "executable ${rootfs}/usr/sbin/dpkg-reconfigure not found"
[[ -x "${rootfs}/usr/bin/debconf-set-selections" ]] || die "executable ${rootfs}/usr/bin/debconf-set-selections not found"

#Set conf

cat > "${rootfs}/etc/default/locale" << EOF
#lxc-provider
LANG=${lxc_DEBIAN_LOCALE}
EOF

if egrep -q '#lxc-provider' "${rootfs}/etc/default/locale"
then
	log "locale setted"
else
	die "unable to set locale"
fi

cat > "${rootfs}/etc/locale.gen" << EOF
#lxc-provider
${lxc_DEBIAN_LOCALE} ${lxc_DEBIAN_CHARSET}
EOF

if egrep -q '#lxc-provider' "${rootfs}/etc/locale.gen"
then
        log "locale.gen setted"
else
        die "unable to set locale.gen"
fi

if chroot ${rootfs} locale-gen
then
	log "locales generation: OK"
else
	die "locale-gen : failed"
fi

exit 0
