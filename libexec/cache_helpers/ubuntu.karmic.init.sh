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
	>/etc/mtab
	mount -a
        initctl emit virtual-filesystems
	initctl emit local-filesystems
        initctl emit remote-filesystems
        initctl emit filesystem
end script
EOF

patch -p0 -d "${ROOTFS}" << EOF
--- etc/init/networking.conf.old	2010-01-11 23:45:12.572772953 +0100
+++ etc/init/networking.conf	2010-01-11 23:45:44.136845540 +0100
@@ -5,8 +5,7 @@
 
 description	"configure virtual network devices"
 
-start on (local-filesystems
-	  and stopped udevtrigger)
+start on local-filesystems
 
 task
 
EOF
echo "upstart initiated: not verified"
exit 0

