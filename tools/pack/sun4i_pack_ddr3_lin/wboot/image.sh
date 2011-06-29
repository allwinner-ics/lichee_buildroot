#FILEPATH是需要打包的文件的目录（包含eFex,eGon的目录）
#WORKPATH是打包的脚本文件image.sh所在的目录
#SOFTWAREPATH是存放打包软件的目录

#!/bin/bash
FILEPATH=`(cd ../; pwd)`
echo $FILEPATH

WORKPATH=$FILEPATH/wboot
SOFTWAREPATH=$FILEPATH/pctools

#-------------------------------设置LD_LIBRARY_PATH变量
LDPATH=$SOFTWAREPATH/libs
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LDPATH
export LD_LIBRARY_PATH

#--------------------------------生成bootfs.iso
pushd .
cd $WORKPATH

$SOFTWAREPATH/mod_update/script ../eFex/sys_config1.fex
cp -f ../eGon/storage_media/nand/boot0.bin ../eGon/boot0.bin
cp -f ../eGon/storage_media/nand/boot1.bin ../eGon/boot1.bin
$SOFTWAREPATH/mod_update/update_23 ../eFex/sys_config1.bin ../eGon/boot0.bin ../eGon/boot1.bin
cp -f ../eGon/storage_media/sdcard/boot0.bin ../eFex/card/card_boot0.fex
cp -f ../eGon/storage_media/sdcard/boot1.bin ../eFex/card/card_boot1.fex
$SOFTWAREPATH/mod_update/update_23 ../eFex/sys_config1.bin ../eFex/card/card_boot0.fex ../eFex/card/card_boot1.fex SDMMC_CARD

#----------------------------------生成mbr
if [ -e ../eFex/sys_config.bin ]
then rm -r ../eFex/sys_config.bin
fi
$SOFTWAREPATH/mod_update/script_old ../eFex/sys_config.fex
$SOFTWAREPATH/mod_update/update_mbr ../eFex/sys_config.bin ../eFex/card/mbr.fex

if [ -e bootfs.fex ]
then rm -r bootfs.fex
fi
$SOFTWAREPATH/fsbuild200/fsbuild ./bootfs.ini ../eFex/split_c43a2a92-a8ed-4f92-abdb-ca0d5d29666d.bin
mv bootfs.iso bootfs.fex

#-------------------------生成ePDKv100.img
if [ -e ePDKv100.img ]
then rm -r ePDKv100.img
fi
$SOFTWAREPATH/eDragonEx/dragon image.cfg >image.txt
popd
