#!/bin/bash

#create_lxc_conf.sh

. ${lxc_GLOBAL_FUNCTIONS}
. ${lxc_TEMPLATE_NETCONF} || die "enable to load ${lxc_TEMPLATE_NETCONF}"
needed_var_check "lxc_CONTAINER_FSTAB lxc_CONTAINER_NAME lxc_CONTAINER_ROOTFS lxc_CONTAINER_LXC_CONF lxc_CONTAINER_BRIDGE lxc_CONTAINER_MTU"
#Make checks

[[ -d $(dirname ${lxc_CONTAINER_FSTAB}) ]] || die "$(dirname ${lxc_CONTAINER_FSTAB}) does not exists"
[[ -d $(dirname ${lxc_CONTAINER_LXC_CONF}) ]] || die "$(dirname ${lxc_CONTAINER_LXC_CONF}) does not exists"


touch ${lxc_CONTAINER_FSTAB}

cat <<EOF > ${lxc_CONTAINER_LXC_CONF}
lxc.utsname = ${lxc_CONTAINER_NAME}
lxc.tty = 4
lxc.pts = 1024
lxc.network.type = veth
lxc.network.flags = up
lxc.network.link = ${lxc_CONTAINER_BRIDGE}
lxc.network.name = eth0
lxc.network.mtu = ${lxc_CONTAINER_MTU}
lxc.mount = ${lxc_CONTAINER_FSTAB}
lxc.rootfs = ${lxc_CONTAINER_ROOTFS}
EOF

if lxc-checkconfig | grep -q 'Cgroup device:.*enabled';
then
        cat << EOF >>${lxc_CONTAINER_LXC_CONF}
lxc.cgroup.devices.deny = a
# /dev/null and zero
lxc.cgroup.devices.allow = c 1:3 rwm
lxc.cgroup.devices.allow = c 1:5 rwm
# consoles
lxc.cgroup.devices.allow = c 5:1 rwm
lxc.cgroup.devices.allow = c 5:0 rwm
lxc.cgroup.devices.allow = c 4:0 rwm
lxc.cgroup.devices.allow = c 4:1 rwm
# /dev/{,u}random
lxc.cgroup.devices.allow = c 1:9 rwm
lxc.cgroup.devices.allow = c 1:8 rwm
lxc.cgroup.devices.allow = c 136:* rwm
lxc.cgroup.devices.allow = c 5:2 rwm
# rtc
lxc.cgroup.devices.allow = c 254:0 rwm
EOF

fi

