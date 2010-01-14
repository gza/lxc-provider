#!/bin/bash

#debian.networking.sh
. ${lxc_GLOBAL_FUNCTIONS}
. ${lxc_TEMPLATE_NETCONF} || die "enable to load ${lxc_TEMPLATE_NETCONF}"

needed_var_check "lxc_CONTAINER_ROOTFS lxc_TEMPLATE_NETCONF lxc_CONTAINER_GATEWAY lxc_CONTAINER_NETMASK lxc_CONTAINER_MTU lxc_CONTAINER_NAME"

if [[ -z ${lxc_CONTAINER_IP} ]]
then
	lxc_CONTAINER_IP=$(getent hosts ${lxc_CONTAINER_NAME} | awk 'NR==1 { print $1 }')
	[[ "x${lxc_CONTAINER_IP}" == "x" ]] && die "IP address not provided and enable to find it from hostname"
	echo "Found IP address ${lxc_CONTAINER_IP}"
fi

[[ -d ${lxc_CONTAINER_ROOTFS}/etc/network ]] || die "enable to find ${lxc_CONTAINER_ROOTFS}/etc/network"

cat <<EOF > ${lxc_CONTAINER_ROOTFS}/etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
address ${lxc_CONTAINER_IP}
netmask ${lxc_CONTAINER_NETMASK}
gateway ${lxc_CONTAINER_GATEWAY}
mtu ${lxc_CONTAINER_MTU}
EOF

if [[ ! -d "${lxc_CONTAINER_ROOTFS}/var/run/network" ]] 
then
	mkdir -p "${lxc_CONTAINER_ROOTFS}/var/run/network" || die "unable to create ${lxc_CONTAINER_ROOTFS}/var/run/network dir"
fi

cat <<EOF > ${lxc_CONTAINER_ROOTFS}/etc/hosts
127.0.0.1 localhost
${lxc_CONTAINER_IP} ${lxc_CONTAINER_NAME}
EOF
