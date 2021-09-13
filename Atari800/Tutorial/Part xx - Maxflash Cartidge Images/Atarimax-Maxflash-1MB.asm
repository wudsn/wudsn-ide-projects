;
;	>> Atarimax Maxflash Example Program for MADS by JAC! <<
;
;	For 1 MB Maxflash with 128 banks of 8k each. Last updated 2015-08-06.
;	You can choose cartmapper "42 - MaxFlash 1M / 8Mbit -older (bank127)
;	or "MaxFlash 1M / 8Mbit - new (bank0)" in Altirra. Both will work with this.
;
;	Assumes that you have you emulator registered for the ".rom" file extension
;	or have configured the following start parameters:
;	"${runnerExecutablePath} /singleinstance ${outputFilePath} /cartmapper 42"
;
;	@com.wudsn.ide.asm.outputfileextension=.rom

;CARTCS	= $bffa 			;Start address vector, used if CARTFG has CARTFG_START_CART bit set
;CART	= $bffc				;Flag, must be zero for modules
;CARTFG	= $bffd				;Flags or-ed together, indicating how to start the module.
;CARTAD	= $bffe				;Initialization address vector

CARTFG_DIAGNOSTIC_CART = $80		;Flag value: Directly jump via CARTAD during RESET.
CARTFG_START_CART = $04			;Flag value: Jump via CARTAD and then via CARTCS.
CARTFG_BOOT = $01			;Flag value: Boot peripherals, then start the module.


	opt h-				;Disable Atari COM/XEX file headers

;===============================================================
;	Bank 0 is the startup bank on newer
;	Atarimax Maxflash 1MB cartridges only.
;	See bank 127 for the compatibility code for the older models.

	org $a000			;Bank 0
	opt f+				;Activate fill mode
	lmb #0				;Load memory bank 0

	.proc bank_0			;Powerup code for new Atarmax 1 MB cartridges

	.proc init			;Cartridge initalization
	rts				;Only the minimum of the OS initialization is complete, you don't want to code here normally.
	.endp

	.proc start			;Cartridge start, RAM, graphics 0 and IOCB no for the editor (E:) are ready

	.proc your_actual_code
loop	lda $d40b
	sta $d01a
	jmp loop
	.endp

	.endp

	org $bff4			;Powerup code for old Atarmax 1 MB cartridges

	.proc powerup
	lda $d500			;Dummy, will never be excuted, see bank 127
	jmp start			;Continuation from bank 127				
	.endp

	org $bffa			;Cartridge control block
	.word start			;CARTCS
	.byte 0				;CART
	.byte CARTFG_START_CART		;CARTFG
	.word init			;CARTAD
	.endp				;End of bank_0

	opt f-				;Dectivate fill mode, so ORG can be changed again

;===============================================================
;	Including a ready to use binary file with "INS"
;	or part thereof will be much faster

	.proc other_banks
	

	.rept 126

	org $a000
	opt f+

	.sav 8192			;Save 8192 bytes from the empty compiler buffer 
	
	opt f-

	.endr
	.endp
	
;===============================================================
;	Special startup on bank 127 because older
;	Atarimax Maxflash 1MB cartridges have start bank 127
;	Newer cartridges have start bank 0, but you should keep
;	this code for compatibility with older hardware.

	org $a000			;Bank 127
	opt f+				;Activate fill mode
	lmb #127			;Load memory bank 127

	.proc bank_127			;Powerup code for old Atarmax 1 MB cartridges

	org $bff3

	.proc init			;Cartridge initalization
	rts				;Only the minimum of the OS initialization is complete, you don't want to code here normally.
	.endp

	.proc powerup
	lda $d500			;Activate bank 0
	jmp *				;Dummy, will never be excuted, see bank 0
	.endp

	org $bffa			;Cartridge control block
	.word powerup			;CARTCS
	.byte 0				;CART
	.byte CARTFG_START_CART 	;CARTFG
	.word init			;CARTAD

	.endp				;End of bank127
	opt f-				;Deactivate fill mode

