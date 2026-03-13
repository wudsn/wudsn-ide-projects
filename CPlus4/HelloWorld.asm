//	WUDSN IDE example KickAss source file for Commodore Plus/4
//
//     In the IDE preferences for "Editors/File Associations":
//	- Associate ".asm" with "KICKASS Editor"
//
//     In the IDE preferences for "Assmemblers/C64":
//	- Select "Vice" as "Default Application to Open File".
//	- Configure the path to ...\VICE\bin\xplus4.exe".
//	- Select the "Wait for end of application" checkbox.

.pc = $1001 "Basic Upstart"
:BasicUpstart(start) // 10 sys$1010

.pc =$1010 "Program"

start:        ldx #0
loop:         lda mytext,x
              jsr $FFD2
              inx
              cpx #11
              bne loop
              brk

mytext: .text "HELLO WORLD!"
