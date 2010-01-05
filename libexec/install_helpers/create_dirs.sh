#!/bin/bash

#create_dirs.sh
#creates rootfs and tmp dir

. ${lxc_GLOBAL_FUNCTIONS}
needed_var_check "lxc_CONTAINER_ROOTFS lxc_GLOBAL_TMP_HOME lxc_CONTAINER_NAME"

TMP_DIR="${lxc_GLOBAL_TMP_HOME}/${lxc_CONTAINER_NAME}"
[[ -d $TMP_DIR ]] && die "Temporary dir $TMP_DIR already exists"
[[ -d ${lxc_CONTAINER_ROOTFS} ]] && die "Rootfs dir ${lxc_CONTAINER_ROOTFS} already exists"

mkdir -p $TMP_DIR || die "Cannot create $TMP_DIR"
mkdir -p ${lxc_CONTAINER_ROOTFS} || die "Cannot create ${lxc_CONTAINER_ROOTFS}"

echo "Temporary and rootfs dirs created"
exit 0
