#!/bin/bash

#passwd.sh

. "${lxc_GLOBAL_FUNCTIONS}"

needed_var_check "lxc_CONTAINER_ROOTFS lxc_CONTAINER_PASSWD lxc_CONTAINER_SSHPUBKEY lxc_CONTAINER_NOPASSWD "

[[ -d "${lxc_CONTAINER_ROOTFS}/etc" ]] || die "unable to find ${lxc_CONTAINER_ROOTFS}/etc"

if echo "${lxc_CONTAINER_NOPASSWD}" | grep -iq '^yes$'
then
	sed -i "s|\(root:\)x\(:0:0:root:.*:.*\)|\1*\2|" "${lxc_CONTAINER_ROOTFS}/etc/passwd"
fi

if [[ -f "${lxc_CONTAINER_SSHPUBKEY}" ]]
then
	mkdir -p "${lxc_CONTAINER_ROOTFS}/root/.ssh"
	cat "${lxc_CONTAINER_SSHPUBKEY}" >> "${lxc_CONTAINER_ROOTFS}/root/.ssh/authorized_keys"
	chmod 600 "${lxc_CONTAINER_ROOTFS}/root/.ssh/authorized_keys"
fi

if echo "${lxc_CONTAINER_PASSWD}" | grep -q '$1$.*'
then
	sed -i "s|\(root:\).*\(:.*:0:.*:.:::\)|\1${lxc_CONTAINER_PASSWD}\2|" "${lxc_CONTAINER_ROOTFS}/etc/shadow"
fi
