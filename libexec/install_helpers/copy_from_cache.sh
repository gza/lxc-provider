#!/bin/bash

#copy_from_cache.sh

. ${lxc_GLOBAL_FUNCTIONS}

needed_var_check "lxc_TEMPLATE_CACHE_SOURCE lxc_CONTAINER_ROOTFS"

[[ -d ${lxc_CONTAINER_ROOTFS} ]] || die "${lxc_CONTAINER_ROOTFS} does not exists"

cp -a ${lxc_TEMPLATE_CACHE_SOURCE}/* ${lxc_CONTAINER_ROOTFS}/ || die "cp -a ${lxc_TEMPLATE_CACHE_SOURCE}/* ${lxc_CONTAINER_ROOTFS}/ : failed"
