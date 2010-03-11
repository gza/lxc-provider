#!/bin/bash

#passwd.sh
. ${lxc_PATH_LIBEXEC}/functions.sh

needed_var_check "lxc_TMP_ROOTFS lxc_AUTH_PASSWD lxc_AUTH_SSHPUBKEY lxc_AUTH_NOPASSWD "
ROOTFS=${lxc_TMP_ROOTFS}

[[ -d "${ROOTFS}/etc" ]] || die "unable to find ${ROOTFS}/etc"

if echo "${lxc_AUTH_NOPASSWD}" | grep -iq '^yes$'
then
	sed -i "s|\(root:\)x\(:0:0:root:.*:.*\)|\1*\2|" "${ROOTFS}/etc/passwd"
fi

if [[ -f "${lxc_AUTH_SSHPUBKEY}" ]]
then
	mkdir -p "${ROOTFS}/root/.ssh"
	cat "${lxc_AUTH_SSHPUBKEY}" >> "${ROOTFS}/root/.ssh/authorized_keys"
	chmod 600 "${ROOTFS}/root/.ssh/authorized_keys"
fi

if echo "${lxc_AUTH_PASSWD}" | grep -q '$1$.*'
then
	sed -i "s|\(root:\).*\(:.*:0:.*:.:::\)|\1${lxc_AUTH_PASSWD}\2|" "${ROOTFS}/etc/shadow"
fi
