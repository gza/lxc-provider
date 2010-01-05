#!/bin/bash
. ${lxc_GLOBAL_FUNCTIONS}
#@TODO : make some post checks
needed_var_check "lxc_CACHE_TMPROOTFS"
ROOTFS=${lxc_CACHE_TMPROOTFS}

[[ -d $ROOTFS/etc/ ]] || die "$ROOTFS/etc/ dir not found"

init_to_delete="
/etc/init/control-alt-delete.conf
/etc/init/hwclock.conf
/etc/init/hwclock-save.conf
/etc/init/mountall.conf
/etc/init/mountall-net.conf
/etc/init/mountall-reboot.conf
/etc/init/mountall-shell.conf
/etc/init/networking.conf
/etc/init/procps.conf
/etc/init/rsyslog-kmsg.conf
/etc/init/tty2.conf
/etc/init/tty3.conf
/etc/init/tty4.conf
/etc/init/tty5.conf
/etc/init/tty6.conf
/etc/init/upstart-udev-bridge.conf"

for File in $init_to_delete
do
	rm -f "${ROOTFS}/$File"
done

cat > ${ROOTFS}/etc/init/lxc.conf <<EOF
start on startup
script
	mount -a
        initctl emit virtual-filesystems
	initctl emit local-filesystems
        initctl emit remote-filesystems
        initctl emit filesystem
end script
EOF

echo "upstart initiated: not verified"
exit 0

