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

d_green() {
	echo -ne "${color_Green}${1}${color_None}"
}

d_red() {
        echo -ne "${color_Red}${1}${color_None}"
}

d_yellow() {
	echo -ne "${color_Yellow}${1}${color_None}"
}

die() {
	echo -ne "Error : "
	d_red "$1\n" 1>&2
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
