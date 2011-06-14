#!/bin/bash

PLATFORM=""
MODULE=""
CUR_DIR=`pwd`

show_help()
{
	printf "\nbuild.sh - Top Level Build Scripts\n\n"
	echo "Valid Options:"
	echo "  -h  Show help message"
	echo "  -p <platform> platform"
	printf "  -m <module> module, default to all\n"
	printf "\nValid Platforms: sun3i, sun4i\n"
	printf "Valid Modules: buildroot, kernel, test\n\n"
	printf "Examples:\n  ./build.sh -p sun4i\n"
	printf "  ./build.sh -p sun4i -m buildroot\n"
	printf "  ./build.sh -p sun4i -m kernel\n\n"
}

while getopts hp:m: OPTION
do
	case $OPTION in
	h) show_help
	;;
	p) PLATFORM=$OPTARG
	;;
	m) MODULE=$OPTARG
	;;
	*) show_help
	;;
esac
done

if [ -z "$PLATFORM" ]; then
	show_help
	exit 1
fi


if [ "$MODULE" = buildroot ]; then
	cd ${CUR_DIR}/buildroot && ./build.sh -p ${PLATFORM}
elif [ "$MODULE" = kernel ]; then
	cd ${CUR_DIR}/linux-2.6.36 && ./build.sh -p ${PLATFORM}
else
	cd ${CUR_DIR}/buildroot && ./build.sh -p ${PLATFORM}
	cd ${CUR_DIR}/linux-2.6.36 && ./build.sh -p ${PLATFORM}
fi

