;	WUDSN IDE example MADS source file for Apple II binary file format (".b")
;
;	Find more information on Apple II coding and APIs in the
;	Apple Assembly Line at http://www.txbobsc.com/aal
;	Apple II References athttps://ia700602.us.archive.org/19/items/applerefjan78/appleIIrefjan78_text.pdf
;
;	@com.wudsn.ide.asm.hardware=APPLE2

	crout = $fd8e
	cout = $fded

	opt h-f+

	org $c00-4		;After the screen memory
	.word main
	.word .len main

	.proc main
	jsr crout		;Print newline
	ldx #$00
loop	lda text,x		
	beq done		;Zero termination found?
	jsr cout		;Print character
	inx
	bne loop
done	jsr crout		;Print newline
	jmp $03d0		;Return to DOS

text	.by +$80 'Hello, Nick, Brendan and Sean!',13
	.by +$80 'Thanks for your support, JAC! (B)'
	.byte 0
	.endp