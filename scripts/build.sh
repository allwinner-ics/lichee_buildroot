#!/bin/bash


CUR_DIR=`pwd`

# clean
rm -rf ${CUR_DIR}/out/*
mkdir ${CUR_DIR}/out

# buildroot
cd ${CUR_DIR}/buildroot && ./build.sh

# build kernel
export PATH=${CUR_DIR}/buildroot/output/external-toolchain/bin:$PATH
cd ${CUR_DIR}/linux-2.6.36 && ./build.sh kernel
cd ${CUR_DIR}/linux-2.6.36 && ./build.sh modules


# output
cp -rf ${CUR_DIR}/linux-2.6.36/output/* ${CUR_DIR}/out/
cp -rf ${CUR_DIR}/buildroot/output/images/* ${CUR_DIR}/out/



