
	org $2000

start	mwa #dl $230		;Set Display List pointer
	jmp *

	.local dl
	.byte $70,$70,$70	;3x8 empty scanlines
	.byte $70,$70,$70
	.byte $70,$70,$70
	.byte $47,a(sm)
	.byte $70
	.byte $06
	.byte $70
	.byte $02
	.byte $41,a(dl)		;Wait VBL, jump DL
	.endl

	.local sm
	.byte "    HELLO WORLD     "
	.byte "   a display list   "
	.byte "A very long text line with a lot of text"	
	.endl

	run start
