;	Change color per line
;
;	@com.wudsn.ide.asm.hardware=ATARI2600
;	@com.wudsn.ide.asm.mainsourcefile=HelloWorld.asm

	ldx #0			;X=0
kernel	sta wsync		;Stop CPU for 1 scanline (wait sync)
	stx colubk		;Set background color
	inx			;X=X+1
	cpx #effect_lines	;Compare X with 192
	bne kernel		;Branch not equal
