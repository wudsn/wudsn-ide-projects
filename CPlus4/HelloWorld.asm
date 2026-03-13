//	WUDSN IDE example KickAss source file for Commodore Plus/4

.pc = $1001 "Basic Upstart"
:BasicUpstart(start) // 10 sys$0810

.pc =$1010 "Program"

start:        ldx #0
loop:         lda mytext,x
              jsr $FFD2
              inx
              cpx #11
              bne loop
              brk

mytext: .text "HELLO WORLD"
