#!/bin/bash

LICHEE_ROOT=$PWD
PACK_ROOT=tools/pack
INDEX=0

printf "Start packing for Lichee system\n\n"

printf "chips:\n"
for chipp in $(find $PACK_ROOT/configs/ -mindepth 1 -maxdepth 1 -type d )
do
	let INDEX=$INDEX+1
	chip=`basename $chipp`
	printf "$INDEX. $chip\n"
done

CHIP_TYPE=not_exist
while [ ! -d $PACK_ROOT/configs/$CHIP_TYPE ]; do
	read -p "Please select a chip(name): "
	CHIP_TYPE=$REPLY
done
printf "\n"


INDEX=0
printf "platforms:\n"
for platformp in $(find $PACK_ROOT/configs/$CHIP_TYPE/ -mindepth 1 -maxdepth 1 -type d)
do
	let INDEX=$INDEX+1
	platform=`basename $PACK_ROOT/configs/$chip/$platformp`
	printf "$INDEX. $platform\n"
done

PLATFORM_TYPE=not_exist
while [ ! -d $PACK_ROOT/configs/$CHIP_TYPE/$PLATFORM_TYPE ]; do
        read -p "Please select a platform(name): "
        PLATFORM_TYPE=$REPLY
done
printf "\n"

INDEX=0
printf "boards:\n"
for boardp in $(find $PACK_ROOT/configs/$CHIP_TYPE/$PLATFORM_TYPE -mindepth 1 -maxdepth 1 -type d)
do
	let INDEX=$INDEX+1
	board=`basename $PACK_ROOT/configs/$chip/$platformp/$boardp`
	printf "$INDEX. $board\n"
done

BOARD_TYPE=not_exist
while [ ! -d $PACK_ROOT/configs/$CHIP_TYPE/$PLATFORM_TYPE/$BOARD_TYPE ]; do
        read -p "Please select a board: "
        BOARD_TYPE=$REPLY
done
printf "\n"

cd $PACK_ROOT
./pack -c $CHIP_TYPE -p $PLATFORM_TYPE -b $BOARD_TYPE
cd -


