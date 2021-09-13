;	$d000-$d0ff GTIA (pixel, color, sprites/player/missle, consol, beep)
;	$d200-$d2ff POKEY (paddle, keyboard, SIO, audio)
;	$d400-$d4ff ANTIC (DMA feed GITA with data)

	org $2000

color0  = $2c4
color2  = $2c6
color4	= $2c8	;Shadow of colbk

colpf1	= $d017
colpf2	= $d018
colbk	= $d01a

	.proc main

	lda #$38
	sta color4

loop	lda $14
	sta color2
	jmp loop
	.endp
	
	run main
