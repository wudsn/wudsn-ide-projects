//	WUDSN IDE example KickAss source file for C64

.pc = $0801 "Basic Upstart"
:BasicUpstart(start) // 10 sys$0810

.pc =$0810 "Program"

start:
	inc $d020
	inc $d021
	jmp start