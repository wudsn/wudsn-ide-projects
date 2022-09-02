;
; RASTER Music Tracker Modules
;
; http://raster.infos.cz/atari/rmt/rmt.htm#download
;
; http://asma.atari.org/
;
; C:\jac\wudsn\Tools\ASM\MADS\examples\players\rmt_player_relocator

	org $2400

rtclok	= $12

	.proc music
STEREOMODE = 0
init	= RASTERMUSICTRACKER+0
play	= RASTERMUSICTRACKER+3
stop	= RASTERMUSICTRACKER+9

	icl "music.feat"

	icl "rmt_player.a65"			;include RMT player routine
	
	icl 'rmt_relocator.mac'
module
	rmt_relocator 'music.rmt' module	;include music RMT module

	.endp

	.proc main
	ldx #<music.module			;low byte of RMT module to X reg
	ldy #>music.module			;Hi byte of RMT module to Y reg
	lda #0					;Starting song line 0-255 to A reg
	jsr music.init				;Init RMT player for module & song

main_loop
	jsr wait
	jsr music.play
	jmp main_loop

	.proc wait
	lda rtclok+2
loop	cmp rtclok+2
	beq loop
	rts
	.endp

	.endp
	
	run main

