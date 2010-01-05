#!/bin/bash

#Create_lxc.sh
#Creates the container
. ${lxc_GLOBAL_FUNCTIONS}

needed_var_check "lxc_CONTAINER_NAME lxc_CONTAINER_LXC_CONF"

[[ -f ${lxc_CONTAINER_LXC_CONF} ]] || die "${lxc_CONTAINER_LXC_CONF} does not exists"

lxc-create -n ${lxc_CONTAINER_NAME} -f ${lxc_CONTAINER_LXC_CONF} || die "Failed to create '${lxc_CONTAINER_NAME}'"
