#!/bin/bash
. ${lxc_PATH_LIBEXEC}/functions.sh

# 00_debootstrap.sh
# Launch initial bootstrap into then temporary template dir
# TODO Make cache of debootstrap on option

needed_var_check "lxc_TMP_ROOTFS lxc_ARCH lxc_RELEASE lxc_MIRROR lxc_PKGSUPP lxc_PATH_CACHE"

#Shortcuts
rootfs="${lxc_TMP_ROOTFS}"

#Let's do some checks
[[ -d ${rootfs} ]] || die "cannot find ${rootfs} dir"
[[ "$(realpath "${rootfs}/")" == "/" ]] && die "tring to deploy to / !!!!\n i wont do this"

#Let's go
cmd="debootstrap --verbose --variant=minbase --arch=${lxc_ARCH} --include ${lxc_PKGSUPP} ${lxc_RELEASE} ${rootfs} ${lxc_MIRROR}"

#Compute uniq identifier for this debootstrap to cache it
md5=$(echo "${lxc_ARCH}${lxc_PKGSUPP}${lxc_RELEASE}" | md5sum | cut -d ' ' -f 1)
cache="${lxc_PATH_CACHE}/debootstrap/${md5}.tgz"

if [[ -f $cache ]]
then
	d_green "debootstrap cache found, using it...\n"
	tar xzf $cache -C ${rootfs}
	ret=$?
	used_cache="with cache"
else
	d_yellow "no debootstrap cache\n"
	$cmd
	ret=$?
fi

if [[ $ret == 0 ]]
then
	d_green "Bootstrap done ${used_cache}\n"
	if [[ -z ${used_cache} ]]
	then
		mkdir -p "${lxc_PATH_CACHE}/debootstrap"
		if tar -C ${lxc_TMP_ROOTFS} -c -z -f $cache .
		then	
			d_green "debootstrap cache stored : uuid $md5\n"
		else
			die "debootstrap cache storage failed"
		fi
	fi
else
	die "Failed to download the rootfs, aborting. Code: $RET"
fi

#We tag the template in order to secure future operations
touch "${rootfs}/etc/lxc-provider.tag" || die "unable to create tag : ${rootfs}/etc/lxc-provider.tag"
exit 0
