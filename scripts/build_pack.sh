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
	expr $REPLY "+" 10 &> /dev/null
	if [  $? -eq 0 ]
	then
	if [ $REPLY -eq 1 ]
	then
	CHIP_TYPE=sun4i
	break
	fi
	if [ $REPLY -eq 2 ]
        then
	CHIP_TYPE=sun5i
	break
	fi
	fi
	CHIP_TYPE=$REPLY
done
printf "\n"
echo $CHIP_TYPE
 
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
        	expr $REPLY "+" 10 &> /dev/null
			if [  $? -eq 0 ]
			then
			if [ $REPLY -eq 1 ]
			then
			PLATFORM_TYPE=linux
			break
			fi
			if [ $REPLY -eq 2 ]
			then
			PLATFORM_TYPE=crane
			break
			fi
			fi
	PLATFORM_TYPE=$REPLY
done
printf "\n"
echo $PLATFORM_TYPE

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
			
			
			
		    expr $REPLY "+" 10 &> /dev/null
			if [  $? -eq 0 ]
			then
			if [ $PLATFORM_TYPE == linux ]
			then
				case $REPLY in
				1) BOARD_TYPE=evb-v12r ; break;;
				2) BOARD_TYPE=default ; break ;;
				3) BOARD_TYPE=tvdevb ; break ;;
				4) BOARD_TYPE=evb ; break ;;
				5) BOARD_TYPE=aino ;break ;;
				6) BOARD_TYPE=evb-v13 ;break ;;
				*) BOARD_TYPE=not_exist  ;;
				
				esac 
				
			elif [ $PLATFORM_TYPE == crane ]
			then
				case $REPLY in
				1) BOARD_TYPE=onda_m702h6 ;break ;;
				2) BOARD_TYPE=bk7011 ;break ;;
				3) BOARD_TYPE=onda_n507h5 ;break ;;
				4) BOARD_TYPE=evb-v12r ;break ;;
				5) BOARD_TYPE=default ;break ;;
				6) BOARD_TYPE=t780 ;break ;;
				7) BOARD_TYPE=tvdevb ;break ;;
				8) BOARD_TYPE=evb ;break ;;
				9) BOARD_TYPE=aino ;break ;;
				10) BOARD_TYPE=evb-v13 ;break ;;
				*) BOARD_TYPE=not_exist ;;
				
				esac 
			fi
			fi
		
        BOARD_TYPE=$REPLY
done
printf "\n"
echo $BOARD_TYPE
cd $PACK_ROOT
./pack -c $CHIP_TYPE -p $PLATFORM_TYPE -b $BOARD_TYPE
cd -


