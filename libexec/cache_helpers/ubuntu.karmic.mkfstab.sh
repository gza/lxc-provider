#!/bin/bash
. ${lxc_GLOBAL_FUNCTIONS}
#Prepare minimal fstab
#karmic container needs proc to be specified

needed_var_check "lxc_CACHE_TMPROOTFS"

ROOTFS=${lxc_CACHE_TMPROOTFS}
[[ -d $ROOTFS/etc/ ]] || die "$ROOTFS/etc/ does not exist"

cat <<EOF > $ROOTFS/etc/fstab
tmpfs  /dev/shm   tmpfs  defaults  0 0
none   /proc	  proc	 defaults  0 0
EOF

echo "minimal fstab creation : OK"
exit 0
