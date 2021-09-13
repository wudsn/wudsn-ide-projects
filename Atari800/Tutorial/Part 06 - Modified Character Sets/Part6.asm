;	$2000-RAMTOP Your code

;	$c000-$cfff OS part 1
;	$cc00-$cfff OS character set, international

;	$e000-$ffff OS part 2
;	$e000-$e3ff OS character set, standard

sm_ptr	= $58	;88, SAVMSC
ch	= $2f4	;High byte of character set pointer
chr	= $2400	;Character set in RAM
rom_chr	= $e000	;Character set in ROM

	org $2000

	.proc main
	
	mva #>chr ch	;Set high byte of character set

	ldx #0		;Copy 1k character set from ROM to RAM
copy_loop
	mva rom_chr,x chr,x
	mva rom_chr+$100,x chr+$100,x
	mva rom_chr+$200,x chr+$200,x
	mva rom_chr+$300,x chr+$300,x
	inx
	bne copy_loop

	ldx #0		;Copy 8 bytes bitmat for SPACE character
space_loop
	lda charset.space,x
	sta chr,x
	inx
	cpx #8
	bne space_loop
 
	ldy #0		;Fill screen with all characters
loop	tya
	sta (sm_ptr),y
	iny
	bne loop

	jmp *

	.local charset
space	.byte %01000100	;Binary format
	.byte %00101000
	.byte %01111100
	.byte %01010100
	.byte %11111110
	.byte %10101010
	.byte %10111010
	.byte %00000000
	.endl

	.endp
	
	run main
