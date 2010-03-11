#!/bin/bash
. ${lxc_PATH_LIBEXEC}/functions.sh

#@TODO : make some post checks
needed_var_check "lxc_TMP_ROOTFS"
ROOTFS=${lxc_TMP_ROOTFS}

[[ -d $ROOTFS/etc/ ]] || die "$ROOTFS/etc/ dir not found"

init_to_divert="
/etc/init/control-alt-delete.conf
/etc/init/hwclock.conf
/etc/init/hwclock-save.conf
/etc/init/mountall.conf
/etc/init/mountall-net.conf
/etc/init/mountall-reboot.conf
/etc/init/mountall-shell.conf
/etc/init/procps.conf
/etc/init/rsyslog-kmsg.conf
/etc/init/tty2.conf
/etc/init/tty3.conf
/etc/init/tty4.conf
/etc/init/tty5.conf
/etc/init/tty6.conf
/etc/init/upstart-udev-bridge.conf
/etc/init/networking.conf
"

for File in $init_to_divert
do
	chroot ${ROOTFS} dpkg-divert --rename "$File"
done

cat > ${ROOTFS}/etc/init/lxc.conf <<EOF
# lxc - provide some workaround to make upstart to work with lxc
# Guillaume ZITTA

start on startup
script
	>/etc/mtab
	mount -a
        initctl emit virtual-filesystems
	initctl emit local-filesystems
        initctl emit remote-filesystems
        initctl emit filesystem
end script
EOF

cat > ${ROOTFS}/etc/init/networking.conf << EOF
# networking - configure virtual network devices
#
# This task causes virtual network devices that do not have an associated
# kernel object to be started on boot.
# Modified by lxc-provider
description	"configure virtual network devices"

start on local-filesystems

task

exec ifup -a
EOF

echo "upstart initiated: not verified"
exit 0

