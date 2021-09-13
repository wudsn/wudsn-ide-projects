
	org $2000

start	mwa #dl $230		;Set Display List pointer

loop	lda 20
	and #3			;0,1,2,3,0,..
	eor #3			;3,2,1,0,3,...
	sta $d404		;Set horizontal soft scroll position

	lda 20
	and #3			;0,1,2,3,0,..
	bne skip_inc		;Only increment on "0"
	inc dl.lms+1		;Increment low byte of LMS address
skip_inc
	lda 20			;Incremented every 50th of a second by VBI
wait	cmp 20
	beq wait

	jmp loop

	.local dl
	.byte $70,$70,$70	;3x8 empty scanlines
	.byte $70,$70,$70
	.byte $70,$70,$70
	.byte $47,a(sm)
	.byte $70
	.byte $06
	.byte $70
	.byte $02
	.byte $70
lms	.byte $52,a(scroller)
	.byte $41,a(dl)		;Wait VBL, jump DL
	.endl

	.local sm
	.byte "    HELLO WORLD     "
	.byte "   a display list   "
	.byte "A very long text line with a lot of text "	
	.endl

	.align $100
	.local scroller
	.byte "                                        "
	.byte "A very long scroll text line with a lot of scroll text  "
	.byte "A very long scroll text line with a lot of scroll text  "
	.byte "A very long scroll text line with a lot of scroll text  "
	.byte "                                        "
	.endl

	run start
