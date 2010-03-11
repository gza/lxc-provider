#!/bin/bash

#debian.networking.sh
. ${lxc_PATH_LIBEXEC}/functions.sh

needed_var_check "lxc_TMP_ROOTFS lxc_NET_GATEWAY lxc_NET_eth0_NETMASK lxc_NET_eth0_MTU lxc_CONTAINER_NAME"
ROOTFS=${lxc_TMP_ROOTFS}
if [[ -z ${lxc_CONTAINER_IP} ]]
then
	lxc_CONTAINER_IP=$(getent hosts ${lxc_CONTAINER_NAME} | awk 'NR==1 { print $1 }')
	[[ "x${lxc_CONTAINER_IP}" == "x" ]] && die "IP address not provided and enable to find it from hostname"
	echo "Found IP address ${lxc_CONTAINER_IP}"
fi

[[ -d ${ROOTFS}/etc/network ]] || die "enable to find ${ROOTFS}/etc/network"

cat <<EOF > ${ROOTFS}/etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
address ${lxc_CONTAINER_IP}
netmask ${lxc_NET_eth0_NETMASK}
gateway ${lxc_NET_GATEWAY}
mtu ${lxc_NET_eth0_MTU}
EOF

if [[ ! -d "${ROOTFS}/var/run/network" ]] 
then
	mkdir -p "${ROOTFS}/var/run/network" || die "unable to create ${ROOTFS}/var/run/network dir"
fi

cat <<EOF > ${ROOTFS}/etc/hosts
127.0.0.1 localhost
${lxc_CONTAINER_IP} ${lxc_CONTAINER_NAME}
EOF
