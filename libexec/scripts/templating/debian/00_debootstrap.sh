#!/bin/bash
. ${lxc_PATH_LIBEXEC}/functions.sh
#Launch initial bootstrap into then temporary cache dir
needed_var_check "lxc_TMP_ROOTFS lxc_ARCH lxc_RELEASE lxc_MIRROR lxc_PKGSUPP lxc_PATH_CACHE"

[[ -d ${lxc_TMP_ROOTFS} ]] || die "cannot find ${lxc_TMP_ROOTFS} dir"

CMD="debootstrap --verbose --variant=minbase --arch=${lxc_ARCH} \
		    --include ${lxc_PKGSUPP} \
		    ${lxc_RELEASE} ${lxc_TMP_ROOTFS} ${lxc_MIRROR}"

MD5SUM=$(echo "${lxc_ARCH}${lxc_PKGSUPP}${lxc_RELEASE}" | md5sum | cut -d ' ' -f 1)
cache="${lxc_PATH_CACHE}/debootstrap/${MD5SUM}.tgz"

if [[ -f $cache ]]
then
	tar xvzf $cache -C ${lxc_TMP_ROOTFS}
	RET=$?
else
	$CMD 
	RET=$?
fi

if [[ $RET == 0 ]]
then
	echo "Bootstrap : OK"
	#@TODO make cache an option
	mkdir -p "${lxc_PATH_CACHE}/debootstrap"
	[[ -f $cache ]] || tar -C ${lxc_TMP_ROOTFS} -c -z -f $cache .
	exit 0
else
	echo "Failed to download the rootfs, aborting. Code: $RET"
	exit $RET
fi
