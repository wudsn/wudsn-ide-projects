;	$2000-RAMTOP Your code

;	$8000-$9fff Cartrige 8k/low 16k
;	$a000-$bfff Cartrige 8k/High 16k/BASIC

;	$c000-$cfff OS part 1
;	$cc00-$cfff OS character set, international

;	$d000-$d0ff GTIA (pixel, color, sprites/player/missle, consol, beep)
;	$d100-$d1ff PBI
;	$d200-$d2ff POKEY (paddle, keyboard, SIO, audio)
;	$d300-$d3ff PIA (joystick, MMU)
;	$d400-$d4ff ANTIC (DMA feed GITA with data)
;	$d500-$d5ff Module port (R/W)
;	$d600-$d7ff reserved (VBXE, SIDE, ...)

;	$d800-$dfff Floating Point Packge (FPP)

;	$e000-$ffff OS part 2
;	$e000-$e3ff OS character set, standard

	org $2000

address = $d800

sm_ptr	= $58	;88, SAVMSC

	.proc main
	ldy #0
loop	lda address,y
	sta (sm_ptr),y
	iny
	bne loop

	jmp main
	.endp
	
	run main
