/*******************************************************************************
*
* Filename:	./board.ld
*
* Project:	OpenArty, an entirely open SoC based upon the Arty platform
*
* DO NOT EDIT THIS FILE!
* Computer Generated: This file is computer generated by AUTOFPGA. DO NOT EDIT.
* DO NOT EDIT THIS FILE!
*
* CmdLine:	autofpga autofpga -d -o . global.txt bkram.txt buserr.txt dlyarbiter.txt clock.txt gpio.txt spio.txt icape.txt mdio.txt gps.txt eqspi.txt pic.txt pwrcount.txt rtcdate.txt rtcgps.txt clrspio.txt version.txt wbuconsole.txt zipmaster.txt sdspi.txt
*
* Creator:	Dan Gisselquist, Ph.D.
*		Gisselquist Technology, LLC
*
/*******************************************************************************
*
* Copyright (C) 2017-2018, Gisselquist Technology, LLC
*
* This program is free software (firmware): you can redistribute it and/or
* modify it under the terms of  the GNU General Public License as published
* by the Free Software Foundation, either version 3 of the License, or (at
* your option) any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
* FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
* for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program.  (It's in the $(ROOT)/doc directory.  Run make with no
* target there if the PDF file isn't present.)  If not, see
* <http://www.gnu.org/licenses/> for a copy.
*
* License:	GPL, v3, as defined and found on www.gnu.org,
*		http://www.gnu.org/licenses/gpl.html
*
*
/*******************************************************************************
*
*
*/
ENTRY(_start)

MEMORY
{
	/* To be listed here, a slave must be of type MEMORY.  If the slave
	* has a defined name in its @LD.NAME tag, it will be listed here
	* under that name.  The permissions are given by the @LD.PERM tag.
	* If no permission tag exists, a permission of 'r' will be assumed.
	*/
	   bkram(wx) : ORIGIN = 0x00a00000, LENGTH = 0x00100000
	   flash(rx) : ORIGIN = 0x01000000, LENGTH = 0x01000000
}

/* For each defined memory peripheral, we also define a pointer to that
* memory.  The name of this pointer is given by the @LD.NAME tag within
* the memory peripheral's configuration
*/
_bkram    = ORIGIN(bkram);
_flash    = ORIGIN(flash);
_top_of_stack = ORIGIN(bkram) + LENGTH(bkram) - 4;
/* _rom  = ORIGIN(flash); */
_rom  = 0;
/* _kram = ORIGIN(bkram); */
_ram = ORIGIN(bkram);
SECTIONS
{
       .rocode 0x01400000 : ALIGN(4) {
               _boot_address = .;
               *(.start) *(.boot)
       } > bkram
       _kram_start = . ;
       _kram_end = . ;
       _ram_image_start = . ;
       .kernel : ALIGN_WITH_INPUT {
               *(.kernel)
               *(.text.startup)
               *(.text*)
               *(.rodata*) *(.strings)
               *(.data) *(COMMON)
               }> bkram
       _ram_image_end = . ;
       .bss : ALIGN_WITH_INPUT {
               *(.bss)
               _bss_image_end = . ;
               } > bkram
       _top_of_heap = .;
}

