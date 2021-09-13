
	org $2000

sm_ptr	= $58	;88, SAVMSC

	.proc main
	ldy #0
loop	tya
	sta (sm_ptr),y
	iny
	bne loop

stop	jmp stop
	.endp
	
	run main
