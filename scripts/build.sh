#!/bin/bash

CUR_DIR=`pwd`

# clean
rm -rf ${CUR_DIR}/out/*

if [ ! -d ${CUR_DIR}/out ]; then
mkdir ${CUR_DIR}/out
fi

# buildroot
cd ${CUR_DIR}/buildroot && ./build.sh

# build kernel
export PATH=${CUR_DIR}/buildroot/output/external-toolchain/bin:$PATH
cd ${CUR_DIR}/linux-2.6.36 && ./build.sh kernel
cd ${CUR_DIR}/linux-2.6.36 && ./build.sh modules


# output
rm -rf ${CUR_DIR}/out/rootfs
cp -rf ${CUR_DIR}/buildroot/output/target ${CUR_DIR}/out/rootfs
cp -rf ${CUR_DIR}/linux-2.6.36/output/?Image ${CUR_DIR}/out/
cp -rf ${CUR_DIR}/linux-2.6.36/output/lib/modules ${CUR_DIR}/out/rootfs/lib/modules

if [ -f ${CUR_DIR}/buildroot/output/images/u-boot.bin ]; then
	cp ${CUR_DIR}/buildroot/output/images/u-boot.bin ${CUR_DIR}/out/
	cp -rf ${CUR_DIR}/linux-2.6.36/output/uImage ${CUR_DIR}/out/rootfs/
	rm -rf ~/xyz_nfs
	ln -sv ${CUR_DIR}/out/rootfs ~/xyz_nfs
fi
 
