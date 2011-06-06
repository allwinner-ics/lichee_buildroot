::-------------生成bootfs.iso
..\pctools\mod_update\script.exe ..\eFex\sys_config1.fex
copy  ..\eGon\storage_media\nand\Boot0.bin    ..\eGon\Boot0.bin
copy  ..\eGon\storage_media\nand\Boot1.bin    ..\eGon\Boot1.bin
..\pctools\mod_update\update_23.exe ..\eFex\sys_config1.bin ..\eGon\Boot0.bin           ..\eGon\Boot1.bin
copy  ..\eGon\storage_media\sdcard\Boot0.bin  ..\eFex\card\card_boot0.fex
copy  ..\eGon\storage_media\sdcard\Boot1.bin  ..\eFex\card\card_boot1.fex
..\pctools\mod_update\update_23.exe ..\eFex\sys_config1.bin ..\eFex\card\card_boot0.fex ..\eFex\card\card_boot1.fex  SDMMC_CARD


::-------------生成MBR
if exist ..\eFex\sys_config.bin del   ..\eFex\sys_config.bin
..\pctools\mod_update\script_old.exe  ..\eFex\sys_config.fex
..\pctools\mod_update\update_mbr.exe  ..\eFex\sys_config.bin    ..\eFex\card\mbr.fex


if exist bootfs.fex  del  bootfs.fex
call bootfs_build.bat

::-------------生成ePDKv100.img
if exist ePDKv100.img del ePDKv100.img
..\pctools\eDragonEx200\compile -o image.bin image.cfg
..\pctools\eDragonEx200\dragon image.cfg  > image.txt
if exist bootfs.fex  del  bootfs.fex

pause
