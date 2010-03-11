#!/bin/bash
#Usage : $0 /lxc/etc/general.conf templating debian/ubuntu/karmic

Conf=$1
Mode=$2
Template=$3

. ${Conf}

root=$(realpath "${lxc_PATH_SCRIPTS}")
current_pwd=$(realpath "${root}/${Mode}/${Template}")

while [[ "$current_pwd" != "$(realpath ${root}/..)" ]]
do
	for script in $current_pwd/*.sh
	do
		scriptname=$(basename ${script} .sh)
		eval '[[ -z $lxc_script_'$scriptname' ]] && export lxc_script_'$scriptname'='${script}
	done
	current_pwd=$(realpath ${current_pwd}/..)
done

for var in ${!lxc_script_*}
do
	eval echo '$'$var
done
