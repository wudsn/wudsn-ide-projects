
	org $2000

start	mwa #dl $230		;Set Display List pointer

loop	inc dl.lms+1		;Increment low byte of LMS address
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
lms	.byte $42,a(scroller)
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
