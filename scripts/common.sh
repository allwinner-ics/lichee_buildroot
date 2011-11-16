#!/bin/bash
set -e

PLATFORM=""
MODULE=""
BOARD="evb1.1"

CUR_DIR=$PWD
OUT_DIR=$CUR_DIR/out
KERN_VER=2.6.36
KERN_DIR=$CUR_DIR/linux-${KERN_VER}
KERN_OUT_DIR=$KERN_DIR/output
BR_DIR=$CUR_DIR/buildroot
BR_PACK_DIR=$BR_DIR/tools/pack
BR_OUT_DIR=$BR_DIR/output
U_BOOT_DIR=$CUR_DIR/u-boot


#
# VAR0: new KDIR
#
update_kdir()
{
	KERN_VER=$1
	KERN_DIR=${CUR_DIR}/linux-${KERN_VER}
	KERN_OUT_DIR=$KERN_DIR/output
}

show_help()
{
printf "
NAME
    build - The top level build script for Lichee Linux BSP

SYNOPSIS
    build [-h] | [-p platform] [-b board_type] [-k kern_version] [-m module]

OPTIONS
    -h             Display help message
    -p [platform]  platform, e.g. sun4i, sun4i-lite, sun4i-debug, sun4i_crane
                   sun4i: full linux bsp
                   sun4i-lite: linux bsp with less packages
                   sun4i-debug: linux bsp for debug
                   sun4i_crane: android kernel

    -b [board]     Develoment board, e.g. evb1.1, evb1.2A, evb1.2B  [OPTIONAL]
                   evb1.1(default): old EVB board, including EVB-V1.0, EVB-V1.1
                   evb1.2A: RTP
                   evb1.2B: CTP, 7' LCD

    -k [kern_ver]  2.6.36(default), or 3.0                          [OPTIONAL]

    -m [module]    Use this option when you dont want to build all. [OPTIONAL]
                   e.g. kernel, buildroot, all(default)...

Examples:
    ./build.sh -p sun4i-lite
    ./build.sh -p sun4i_crane
    ./build.sh -p sun4i-lite -k 3.0 -b evb1.2B

"

}

regen_rootfs()
{
    if [ -d ${BR_OUT_DIR}/target ]; then
		echo "Copy modules to target..."
        mkdir -p ${BR_OUT_DIR}/target/lib/modules
        rm -rf ${BR_OUT_DIR}/target/lib/modules/${KERN_VER}*
        cp -rf ${KERN_OUT_DIR}/lib/modules/* ${BR_OUT_DIR}/target/lib/modules/

        if [ "$PLATFORM" = "sun4i-debug" ]; then
            cp -rf ${KERN_DIR}/vmlinux ${BR_OUT_DIR}/target
        fi
	fi

	if [ "$PLATFORM" != "sun4i_crane" ]; then
		echo "Regenerating Rootfs..."
		(cd ${BR_DIR}; make target-generic-getty-busybox; make target-finalize)
        (cd ${BR_DIR};  make LICHEE_GEN_ROOTFS=y rootfs-ext4)
    else
        echo "Skip Regenerating Rootfs..."
    fi
}

gen_output_sun3i()
{
    echo "output sun3i"
}

gen_output_generic()
{
    cp -v ${KERN_OUT_DIR}/bImage ${BR_PACK_DIR}/wboot/bootfs/linux/
    cp -v ${U_BOOT_DIR}/u-boot.bin ${BR_PACK_DIR}/wboot/bootfs/linux/
    cp -v ${BR_OUT_DIR}/images/rootfs.ext4 ${BR_PACK_DIR}/wboot/rootfs.fex

    if [ ! -d "${OUT_DIR}" ]; then
        mkdir -pv ${OUT_DIR}
    fi

    cp -v ${BR_OUT_DIR}/images/* ${OUT_DIR}/
    cp -r ${KERN_OUT_DIR}/* ${OUT_DIR}/
}

do_pack()
{
    printf "Packing for $BOARD board\n"
    (cd ${BR_PACK_DIR}; ./pack -B $BOARD)
}

gen_output_sun4i()
{
    gen_output_generic
    do_pack
}

gen_output_sun4i-lite()
{
    gen_output_generic
    do_pack
}

gen_output_sun4i-debug()
{
    gen_output_generic
    do_pack
}

gen_output_sun4i_crane()
{
    cp -v ${KERN_OUT_DIR}/bImage ${BR_PACK_DIR}/wboot/bootfs/linux/

    if [ ! -d "${OUT_DIR}" ]; then
        mkdir -pv ${OUT_DIR}
    fi

    if [ ! -d "${OUT_DIR}/android" ]; then
        mkdir -p ${OUT_DIR}/android
    fi

    cp -r ${KERN_OUT_DIR}/* ${OUT_DIR}/android/
    mkdir -p ${OUT_DIR}/android/toolchain/
    cp ${BR_DIR}/dl/arm-2010.09-50-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2 ${OUT_DIR}/android/toolchain/
}

clean_output()
{
    rm -rf ${OUT_DIR}/*
    rm -rf ${BR_OUT_DIR}/images/*
    rm -rf ${KERN_OUT_DIR}/*
}

while getopts hb:p:m:k: OPTION
do
    case $OPTION in
    h) show_help
    exit 0
    ;;
    p) PLATFORM=$OPTARG
    ;;
    m) MODULE=$OPTARG
    ;;
    k) KERN_VER=$OPTARG
    update_kdir $KERN_VER
    ;;
    b) BOARD=$OPTARG
    ;;
    *) show_help
    exit 1
    ;;
esac
done

if [ -z "$PLATFORM" ]; then
    show_help
    exit 1
fi

clean_output

if [ "$MODULE" = buildroot ]; then
    cd ${BR_DIR} && ./build.sh -p ${PLATFORM}
elif [ "$MODULE" = kernel ]; then
    export PATH=${BR_OUT_DIR}/external-toolchain/bin:$PATH
    cd ${KERN_DIR} && ./build.sh -p ${PLATFORM}
    regen_rootfs
    gen_output_${PLATFORM}
else
    cd ${BR_DIR} && ./build.sh -p ${PLATFORM}
    export PATH=${BR_OUT_DIR}/external-toolchain/bin:$PATH
    cd ${KERN_DIR} && ./build.sh -p ${PLATFORM}
    cd ${U_BOOT_DIR} && make aw1623
    regen_rootfs
    gen_output_${PLATFORM}
fi


