/*
 *  linux/arch/arm/boot/compressed/vmlinux.lds.in
 *
 *  Copyright (C) 2000 Russell King
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
OUTPUT_ARCH(arm)
ENTRY(_start)
params_phys = 0x80000100;
arch_code = 0x859;
SECTIONS
{
  . = 0x80000000;
  _start = .;
  params_boot1 = .;

  .start : {
  	*(.__start)
  }
  
  . = 0x80008000;
  .head : {
  	*(.__head)
  }
  
  para_start = .;
  .para : { 
  	*(.__para_data)
  }
  para_end = .;

  zImage_start = .;
  .zImage : {
  	*(.__zImage) 
    . = ALIGN(4);
  }
}

