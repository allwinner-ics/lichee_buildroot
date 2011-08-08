if exist bootfs rmdir /s /q bootfs
xcopy /i /s /q /y bootfs_nand bootfs
if exist image.cfg del image.cfg
copy config\image_nand.cfg image.cfg
if exist bootfs\linux\bImage del bootfs\linux\bImage
copy bImage bootfs\linux
::-------------生成bootfs.iso
..\pctools\mod_update\script.exe ..\eFex\sys_config1.fex
copy  ..\eGon\nand_boot0.bin    ..\eGon\Boot0.bin
copy  ..\eGon\nand_boot1.bin    ..\eGon\Boot1.bin
..\pctools\mod_update\update_23.exe ..\eFex\sys_config1.bin ..\eGon\Boot0.bin           ..\eGon\Boot1.bin
copy  ..\eGon\sd_boot0.bin  ..\eFex\card\card_boot0.fex
copy  ..\eGon\sd_boot1.bin  ..\eFex\card\card_boot1.fex
..\pctools\mod_update\update_23.exe ..\eFex\sys_config1.bin ..\eFex\card\card_boot0.fex ..\eFex\card\card_boot1.fex  SDMMC_CARD
copy  ..\eFex\sys_config1.bin	.\bootfs\script.bin
copy  ..\eFex\sys_config1.bin	.\bootfs\script0.bin

::-------------生成MBR
if exist ..\eFex\sys_config.bin del   ..\eFex\sys_config.bin
..\pctools\mod_update\script_old.exe  ..\eFex\sys_config.fex
..\pctools\mod_update\update_mbr.exe  ..\eFex\sys_config.bin    ..\eFex\card\mbr.fex


if exist bootfs.fex  del  bootfs.fex
..\pctools\fsbuild200\fsbuild.exe config\bootfs.ini ^ ..\efex\split_xxxx.fex

::-------------生成ePDKv100.img
if exist ePDKv100_nand.img del ePDKv100_nand.img
..\pctools\eDragonEx200\compile -o image.bin image.cfg
..\pctools\eDragonEx200\dragon image.cfg
if exist bootfs.fex  del  bootfs.fex

::-------------清理工作
del ..\eGon\Boot0.bin ..\eGon\Boot1.bin ..\eFex\card\card_boot0.fex ..\eFex\card\card_boot1.fex ..\eFex\sys_config1.bin ..\eFex\sys_config.bin image.cfg
::del rootfs.fex bootfs\linux\bImage

pause
