
; POKEY Sounds
;
; https://gury.atari8.info/refs/sound.php

rtclok	= $12

pokey	= $d200

audf1	= $d200
audc1	= $d201
audctl	= $d201
skctl	= $d20f

	org $2000

	.proc main
	
	lda #0
	ldx #8
clear_loop
	sta audf1,x
	dex
	bpl clear_loop
	mva #3 skctl

	
	mva #$a8 audc1
;	mva #121 audf1

main_loop
	ldx #16
loop	stx audf1
	jsr wait
	inx
	cpx #64
	bne loop

	jmp main_loop

	
	
	.proc wait
	lda rtclok+2
loop	cmp rtclok+2
	beq loop
	rts
	.endp
	
	.endp

	run main
