#!/bin/bash
. ${lxc_PATH_LIBEXEC}/functions.sh

#Prepare minimal fstab
needed_var_check "lxc_TMP_ROOTFS"

#Shorter var
ROOTFS="${lxc_TMP_ROOTFS}"

[[ -d $ROOTFS/etc/ ]] || die "$ROOTFS/etc/ does not exist"

cat <<EOF > $ROOTFS/etc/fstab
tmpfs  /dev/shm   tmpfs  defaults  0 0
EOF

echo "minimal fstab creation : OK"
exit 0
