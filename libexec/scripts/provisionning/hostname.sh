#!/bin/bash

#update_hostname.sh
. ${lxc_PATH_LIBEXEC}/functions.sh

needed_var_check "lxc_TMP_ROOTFS lxc_CONTAINER_NAME"
ROOTFS=${lxc_TMP_ROOTFS}
[[ -d "${ROOTFS}/etc" ]] || die "unable to find ${ROOTFS}/etc"

cat <<EOF > ${ROOTFS}/etc/hostname
${lxc_CONTAINER_NAME}
EOF
