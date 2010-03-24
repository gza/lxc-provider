#Colors
color_Green='\e[0;32m' 
color_Red='\e[0;31m'
color_Yellow='\e[0;33m'
color_Blue='\e[0;34m'
color_Cyan='\e[0;36m'
color_Magenta='\e[0;35m'
color_None='\e[0m'

progname=$(basename $0)

usage() {
	echo "Usage $1 : $2" 1>&2
	exit 1
}

debug() {
	[[ -n $TERM && "${lxc_DEBUG}" == "true" ]] && echo -ne "${color_Blue}$(date) : ${progname} : debug : ${1}${color_None}\n" 1>&2
	[[ -n ${lxc_LOGFILE} ]] && echo -ne "$(date) : ${progname} : debug : ${1}\n" >> ${lxc_LOGFILE}
}

log() {
	[[ -n $TERM ]] && echo -ne "${color_Green}$(date) : ${progname} : log : ${1}${color_None}\n" 1>&2
	[[ -n ${lxc_LOGFILE} ]] && echo -ne "$(date) : ${progname} : log : ${1}\n" >> ${lxc_LOGFILE}
}

warning() {
	[[ -n $TERM ]] && echo -ne "${color_Yellow}$(date) : ${progname} : warning : ${1}${color_None}\n" 1>&2
	[[ -n ${lxc_LOGFILE} ]] && echo -ne "$(date) : ${progname} : warning : ${1}\n" >> ${lxc_LOGFILE}
}

alert() {
        [[ -n $TERM ]] && echo -ne "${color_Red}$(date) : ${progname} : alert : ${1}${color_None}\n" 1>&2
	[[ -n ${lxc_LOGFILE} ]] && echo -ne "$(date) : ${progname} : alert : ${1}\n" >> ${lxc_LOGFILE}
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
	alert "$1" 1>&2
	exit 1
}

needed_var_check() {
	needed_vars=$1
	for var in ${needed_vars}
	do
		if [[ -z ${!var} ]] 
		then
			die "env var $var not available"
			needed_var_check_failed=1
		fi
	done
	[[ "${needed_var_check_failed}" == "1" ]] && die "Needed vars unavailable"
}

rm_rf() {
	#this function rm -rf but does some checks
	debug "rm_rf : about to delete $1"
	dir=$1
	real=$(realpath $dir)
	debug "rm_rf : about to delete $1, which is ${real}"
	[[ "X${real}" == "X/" ]] && die "I don't want to rm -rf / !!!"

	rm -rf ${dir} && log "${dir} removed"
}
