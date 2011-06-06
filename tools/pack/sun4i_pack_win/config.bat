@echo off
goto START1
/*
**********************************************************************************************************************
*                                                    ePDK
*                                    the Easy Portable/Player Develop Kits
*                                            Software Sub-System
*
*                                   (c) Copyright 2007-2009, Steven.ZGJ.China
*                                             All Rights Reserved
*
* Moudle  : maketool
* File    : makefile.bat
*
* By      : Steven
* Version : v1.0
* Date    : 2008-9-8 14:23:22
**********************************************************************************************************************
*/
:ERROR
    pause
    goto EXIT

:START1
    @echo *********************************************
    @echo *   select storage media                    *
    @echo *********************************************
    @echo  0: NAND FLASH
    @echo  1: SDCARD 0
    @echo  2: SDCARD 2
    @echo  3: SPINOR FLASH
    @echo *********************************************
    set /p SEL=Please Select:
    if %SEL%==0     goto storage_set_nand
    if %SEL%==1     goto storage_set_sdcard0
    if %SEL%==2     goto storage_set_sdcard2
    if %SEL%==3     goto storage_set_spinor
    @echo Error: please input( 0 ~ 3)!
    goto Start1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:storage_set_nand
    set sys_storage_media=nand
    goto START2
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:storage_set_sdcard0
    set sys_storage_media=sdcard
    goto START2
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:storage_set_sdcard2
    set sys_storage_media=sdcard
    goto START2
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:storage_set_spinor
    set sys_storage_media=spinor
    goto START2


:START2
    @echo *********************************************
    @echo *   select board                            *
    @echo *********************************************
    @echo  0: EPDK_BID_P3
    @echo *********************************************
    set /p SEL=Please Select:
    if %SEL%==0     goto x_EPDK_BID_P3
    @echo Error: please input( 0 ~ 0)!
    goto START2

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:x_EPDK_BID_P3
    copy efex\sys_config_bak\sys_config_p3.ini efex\sys_config.fex
    goto conti


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:conti

::    call D:\winners\eBase\tools\software\ArmMakeTool\setpath

    copy eGon\storage_media\%sys_storage_media%\boot0.bin  eGon\boot0.bin
    copy eGon\storage_media\%sys_storage_media%\boot1.bin  eGon\boot1.bin

::    @echo *********************************************
::    @echo *   select de                               *
::    @echo *********************************************
::    pushd .
::    cd D:\winners\eBase\eBSP\BSP\sun_20\de
::    call config_lcdio.bat
::    popd .
    
    
    @echo *********************************************
    pause



