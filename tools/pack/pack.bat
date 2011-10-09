@echo off
set /p b=πÃº˛¿‡–Õ 1:nand 2:sdcard 
if %b%==2 goto f0
set a=nand
goto f1
:f0
set a=sdcard
:f1



set TOOLS_DIR=%CD%\pctools\windows
set PATH=%TOOLS_DIR%\mod_update;%TOOLS_DIR%\fsbuild200;%TOOLS_DIR%\edragonex200;%PATH%

echo %TOOLS_DIR%
echo %PATH%

if exist out (
    echo Delete old out dir , and create it again
    rmdir /s /q out
    mkdir out out\bootfs
) else (
    echo Create out dir
    mkdir out out\bootfs
)

copy eFex\sys_config.fex out
copy eFex\sys_config1.fex out
copy eFex\card\mbr.fex out
copy eFex\split_xxxx.fex out
copy eGon\storage_media\nand\boot0.bin out
copy eGon\storage_media\nand\boot1.bin out
copy eGon\storage_media\sdcard\boot0.bin  out\card_boot0.fex
copy eGon\storage_media\sdcard\boot1.bin  out\card_boot1.fex
copy wboot\bootfs.ini out
copy wboot\image_nand.cfg out
copy wboot\image_sdcard.cfg out
copy wboot\rootfs.fex out
copy wboot\diskfs.fex out
xcopy /q /e wboot\bootfs\* out\bootfs\


cd out

rename bootfs\boot_%a%.axf boot.axf 
rename bootfs\sprite_%a%.axf  sprite.axf 
script_old.exe  sys_config.fex
script.exe sys_config1.fex
update_23.exe sys_config1.bin boot0.bin boot1.bin
update_23.exe sys_config1.bin card_boot0.fex card_boot1.fex SDMMC_CARD
copy sys_config1.bin bootfs\script.bin
copy sys_config1.bin bootfs\script0.bin
update_mbr.exe sys_config.bin mbr.fex
fsbuild.exe "%CD%\bootfs.ini" "%CD%\split_xxxx.fex"
compile.exe -o image.bin image_%a%.cfg
dragon.exe image_%a%.cfg 


cd ..

echo.
echo Pack Done!!!
echo.

pause

