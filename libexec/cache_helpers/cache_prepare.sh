#!/bin/bash
. ${lxc_GLOBAL_FUNCTIONS}
#Creates the temporary dir for cache creation
needed_var_check "lxc_CACHE_ROOTFS lxc_CACHE_TMPROOTFS"

# Cache presence verification
[[ -d "${lxc_CACHE_ROOTFS}" ]] && die "Cache (${lxc_CACHE_ROOTFS}) already exists"
[[ -d "${lxc_CACHE_TMPROOTFS}" ]] && die "Temporary Cache (${lxc_CACHE_TMPROOTFS}) already exists"

# Cache creation
mkdir -p "${lxc_CACHE_TMPROOTFS}" || die "Temporary Cache (${TMP_CACHE_ROOT}) mkdir failed"

echo "Cache dir creation : OK"
exit 0
