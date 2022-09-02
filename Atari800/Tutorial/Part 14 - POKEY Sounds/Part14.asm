;
; POKEY Sounds
;
; https://gury.atari8.info/refs/sound.php

rtclok	= $12	;3 byte
pokey	= $d200	;16 registers

audf1	= $d200
audc1	= $d201	;3 bit distortion, 1 bit volume control, 4 bit volume

audctl	= $d208
skctl	= $d20f

	org $2000

	.proc main
	
	lda #0
	ldx #8
clear_loop
	sta pokey,x
	dex
	bpl clear_loop

	mva #3 skctl

main_loop
	.proc fall
	mva #$a8 audc1
	ldx #0
loop	stx audf1
	jsr wait
	inx
	cpx #255
	bne loop
	.endp

	.proc hit_ground
	mva #$08 audc1
	ldx #16
loop	stx audf1
	jsr wait
	inx
	cpx #64
	bne loop
	.endp

	jmp main_loop
	
	.proc wait
	lda rtclok+2
loop	cmp rtclok+2
	beq loop
	rts
	.endp

	.endp
	
	run main
