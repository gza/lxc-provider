#!/bin/bash
. ${lxc_GLOBAL_FUNCTIONS}
#Launch initial bootstrap into then temporary cache dir
needed_var_check "lxc_CACHE_TMPROOTFS lxc_CACHE_ARCH lxc_CACHE_RELEASE lxc_CACHE_MIRROR lxc_CACHE_PKGSUPP"

[[ -d ${lxc_CACHE_TMPROOTFS} ]] || die "cannot find ${lxc_CACHE_TMPROOTFS} dir"

debootstrap --verbose --variant=minbase --arch=${lxc_CACHE_ARCH} \
		    --include ${lxc_CACHE_PKGSUPP} \
		    ${lxc_CACHE_RELEASE} ${lxc_CACHE_TMPROOTFS} ${lxc_CACHE_MIRROR} || die "Failed to download the rootfs, aborting. Code: $?"

echo "Bootstrap : OK"
exit 0
