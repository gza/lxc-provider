#!/bin/bash

#update_hostname.sh

. ${lxc_GLOBAL_FUNCTIONS}

needed_var_check "lxc_CONTAINER_ROOTFS lxc_CONTAINER_NAME"

[[ -d "${lxc_CONTAINER_ROOTFS}/etc" ]] || die "unable to find ${lxc_CONTAINER_ROOTFS}/etc"

cat <<EOF > ${lxc_CONTAINER_ROOTFS}/etc/hostname
${lxc_CONTAINER_NAME}
EOF
