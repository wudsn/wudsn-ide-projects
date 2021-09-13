;	$2000-RAMTOP Your code

;	$c000-$cfff OS part 1
;	$cc00-$cfff OS character set, international

;	$e000-$ffff OS part 2
;	$e000-$e3ff OS character set, standard

	org $2000

ch	= $2f4
chr	= $0000

sm_ptr	= $58	;88, SAVMSC

	.proc main
	
	lda #>chr	;Set high byte of character set
	sta ch

	ldy #0		;Fill screen with all characters
loop	tya
	sta (sm_ptr),y
	iny
	bne loop

	jmp main
	
	.endp
	
	run main
