
putchar_ptr = $346
csrhinh     = 752

character = $80
rowcrs	= $54	;Byte 0..23
colcrs	= $55	;Word 0..39 (319)

	org $2000
	
	.proc main
	mva #1 csrhinh
	mva #6 rowcrs
	mva #10 colcrs

	mva #0 character
next_character
	ldx character
	cpx #.len text
	beq stop
	lda text,x
	jsr putchar
	inc character
	jmp next_character

stop	jmp stop

	.proc putchar
	tax
	lda putchar_ptr+1
	pha
	lda putchar_ptr
	pha
	txa
	rts
	.endp

	.local text
	.byte 'Hi there!',$9b,'new line'
	.endl

	.endp
	
	run main
