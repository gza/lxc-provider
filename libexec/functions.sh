#Colors
color_Green='\e[0;32m' 
color_Red='\e[0;31m'
color_Yellow='\e[0;33m'
color_Blue='\e[0;34m'
color_Cyan='\e[0;36m'
color_Magenta='\e[0;35m'
color_None='\e[0m'

usage() {
	echo "Usage $1 : $2" 1>&2
	exit 1
}

die() {
	echo -ne "Error : ${color_Red}$1${color_None}\n" 1>&2
	exit 1
}

needed_var_check() {
	needed_vars=$1
	for var in ${needed_vars}
	do
		if [[ -z ${!var} ]] 
		then
			echo "env var $var not available" 1>&2
			needed_var_check_failed=1
		fi
	done
	[[ "${needed_var_check_failed}" == "1" ]] && die "Needed vars unavailable"
}
