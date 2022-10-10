; Adapted from http://z80-heaven.wikidot.com/math#toc18 to run on the Sharp PC-G830.
; Description: Divides the value stored in HL by the value stored in C
; Destroys: A, BC, HL registers

HLDIVC: 
    LD B,16
    XOR A
D0: ADD HL,HL
    RLA
    CP C
    JR C, D1
    INC L
    SUB C
D1: DJNZ D0
    RET
