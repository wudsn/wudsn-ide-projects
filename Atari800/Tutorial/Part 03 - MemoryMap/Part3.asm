;
;	$00-$7f	zeropage for OS
;	$80-$ff zeropage for you

;	$100-$1ff CPU stack

;	$200-$2ff OS vector, registers
;	$300-$3ff OS vector, registers

;	$400-$5ff OS buffers

;	$600-$6ff Page 6, object code in BASIC

;	$700-$1fff Disk Operating System

;	$2000-RAMTOP Your code

;	$8000-$9fff Cartrige 8k/low 16k
;	$a000-$bfff Cartrige 8k/High 16k/BASIC

;	$c000-$cfff OS part 1
;	$cc00-$cfff OS character set, international

;	$e000-$ffff OS part 2
;	$e000-$e3ff OS character set, standard

	org $2000

address = $cc00

sm_ptr	= $58	;88, SAVMSC

	.proc main
	ldy #0
loop	lda address,y
	sta (sm_ptr),y
	iny
	bne loop

	jmp main
	.endp
	
	run main
