#!/bin/bash

#cfg_parse.sh 
#This script parses the configurations files into the tree corresponding to a query string
#
#Usage : cfg_parse.sh path_to_scripts_home query/string

path=$1
#query string, example : debian/ubuntu/hardy
query=$2

#Load some functions
. /lxc/libexec/functions.sh

#Does some checks
[[ -d ${path} ]] || die "'${path}' is not a dir"
[[ "X${query}" == "X" ]] && die "please provide a query string, example debian/ubuntu/hardy"

#initiate start point of conf
cur_dir="${path}"
[[ -d ${cur_dir} ]] || "configuration start point : ${cur_dir} does not exists"

#Makes a list of successive dirs to parse, example : ". debian ubuntu hardy"
directories=$(echo ${query} | sed 's|/| |g;s|^|. |g')

for dir in $directories
do
	#We add current dir to the path unless it is "."
	[[ "$dir" == '.' ]] || cur_dir="${cur_dir}/${dir}"

	echo "parsing $cur_dir" 1>&2
	for conffile in $(find $cur_dir/*.conf 2>/dev/null)
	do
		. $conffile
	done
done

#displaying result
for var in ${!lxc_*}
do
	echo 'export '${var}'='\'${!var}\'
done

