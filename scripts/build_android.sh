#!/bin/bash

##################################################################################################
# 
# Demonstrates auto build & pack for android under linux
#
# Resume the directory arch:
#   -android2.3.4
#   -lichee+-linux-2.6.36
#   |      |-buildroot
#   |      `-build.sh 
#   `-build_android.sh
#
#                                                  - Benn Huang(benn@allwinnertech.com)
###################################################################################################


printf "Start building android firmware\n"

TOP_ROOT=$PWD
LICHEE_ROOT=$PWD/lichee
CRANE_ROOT=$PWD/android2.3.4

function do_config()
{
    cd $CRANE_ROOT
    source build/envsetup.sh
    lunch
    cd $TOP_ROOT
}

function do_build_lichee()
{
    cd $LICHEE_ROOT
    ./build.sh -p sun4i_crane
    cd $TOP_ROOT
}

function do_build_crane()
{
    cd $CRANE_ROOT
    make update-api
    make -j8
    mkimg
    cd $TOP_ROOT
}

function do_pack()
{
    rm -rf $LICHEE_ROOT/buildroot/tools/pack/wboot/android/*.fex
    ln -sv ${OUT}/images/root.img  $LICHEE_ROOT/buildroot/tools/pack/wboot/android/root.fex
    ln -sv ${OUT}/images/system.img  $LICHEE_ROOT/buildroot/tools/pack/wboot/android/system.fex
    ln -sv ${OUT}/images/recovery.img  $LICHEE_ROOT/buildroot/tools/pack/wboot/android/recovery.fex
    cd $LICHEE_ROOT/buildroot/tools/pack

#FIXME: to support more board
    case $TARGET_PRODUCT in
    crane_evb_v13)
        echo "use evb1.2B"
        ./pack -B evb1.2B -p crane
        ;;
    crane_evb)
        echo "use evb1.2A"
        ./pack -B evb1.2A -p crane
        ;;
    *)
        echo "Skip pack, please pack manually"
        ;;
    esac
    
    cd $TOP_ROOT
}


do_config
do_build_lichee
do_build_crane
do_pack



