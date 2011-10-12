#!/bin/bash

PLATFORM=""
MODULE=""

CUR_DIR=$PWD
OUT_DIR=$CUR_DIR/out
KERN_DIR=$CUR_DIR/linux-2.6.36
KERN_OUT_DIR=$KERN_DIR/output
BR_DIR=$CUR_DIR/buildroot
BR_PACK_DIR=$BR_DIR/tools/pack
BR_OUT_DIR=$BR_DIR/output


show_help()
{
    printf "\nbuild.sh - Top Level Build Scripts\n\n"
    echo "To pack sdcard, run \"touch .sdcard\" first, then run this script"
    echo "================================================================="
    echo "Valid Options:"
    echo "  -h  Show help message"
    echo "  -p <platform> platform"
    printf "  -m <module> module, default to all\n"
    printf "\nValid Platforms:\n"
    printf "  sun4i        : full sun4i platform, including directfb, ...\n"
    printf "  sun4i-lite   : lite sun4i platform, which has much less packages\n"
    printf "  sun4i_crane  : for android, only have toolchain and kernel\n"
    printf "  sun4i-debug  : for debug purpose\n\n"
    printf "Valid Modules:\n"
    printf "  kernel       : build linux kernel\n"
    printf "  buildroot    : toolchain and package\n"
    printf "  all          : kernel, buildroot, and auto packing\n\n"
    printf "Examples:\n  ./build.sh -p sun4i\n"
    printf "  ./build.sh -p sun4i -m buildroot\n"
    printf "  ./build.sh -p sun4i -m kernel\n\n"
}

regen_rootfs()
{
    echo "Regenerating Rootfs..."
    if [ -d ${BR_OUT_DIR}/target ]; then
        mkdir -p ${BR_OUT_DIR}/target/lib/modules
        rm -rf ${BR_OUT_DIR}/target/lib/modules/2.6.36*
        cp -rf ${KERN_OUT_DIR}/lib/modules/* ${BR_OUT_DIR}/target/lib/modules/

        if [ "$PLATFORM" = "sun4i-debug" ]; then
            cp -rf ${KERN_DIR}/vmlinux ${BR_OUT_DIR}/target
        fi
        (cd ${BR_DIR};  make target-finalize; make LICHEE_GEN_ROOTFS=y rootfs-ext4)
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
    cp -v ${BR_OUT_DIR}/images/rootfs.ext4 ${BR_PACK_DIR}/wboot/rootfs.fex

    if [ ! -d "${OUT_DIR}" ]; then
        mkdir -pv ${OUT_DIR}
    fi

    cp -v ${BR_OUT_DIR}/images/* ${OUT_DIR}/
    cp -r ${KERN_OUT_DIR}/* ${OUT_DIR}/
}

do_pack()
{
    (cd ${BR_PACK_DIR}; ./pack)
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
    regen_rootfs
    gen_output_${PLATFORM}
fi


