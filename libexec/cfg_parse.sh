#!/bin/bash
#@TODO do some checks
#general conf file
conf=$1

#mode=templating or provisionning
mode=$2

#query
query=$3

conf="/lxc/etc/general.conf"

. ${conf}

cur_dir="${lxc_PATH_ETC}/${mode}"

for step in $(echo ${query} | sed 's|/| |g;s|^|. |g')
do
	[[ "$step" == '.' ]] || cur_dir="${cur_dir}/${step}"
	for conffile in $cur_dir/*.conf
	do
		. $conffile
	done
done

for var in ${!lxc_*}
do
	echo export ${var}=\'$(eval echo '$'$var)\'
done

