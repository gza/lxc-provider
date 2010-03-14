#!/bin/bash
#@TODO do some checks
#general conf file
conf=$1

#mode=templating or provisioning
mode=$2

#query
query=$3

conf="/lxc/etc/general.conf"

. ${conf}

cur_dir="${lxc_PATH_ETC}/${mode}"

for step in $(echo ${query} | sed 's|/| |g;s|^|. |g')
do
	[[ "$step" == '.' ]] || cur_dir="${cur_dir}/${step}"
	for conffile in $(find $cur_dir/*.conf 2>/dev/null)
	do
		. $conffile
	done
done

for var in ${!lxc_*}
do
	echo export ${var}=\'$(eval echo '$'$var)\'
done

