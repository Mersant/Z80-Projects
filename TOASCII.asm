; Original program by David Lowry, 2021
; Description: Converts the number pointed to by HL to an ASCII string stored in NUM. This is useful since the built in ROM routines for the 
; SHARP PC-G830 can't print numbers directly since the numbers must be converted into ASCII characters first. 
; Destroys: Everything

NUM: DS 4

ASCII:
      LD DE,NUM+3
      LD C,10
AS0:  CALL HLDIVC
      OR 030H
      LD (DE),A
      DEC DE
      XOR A
      LD (DE),A
      CP L
      JP NZ,AS0
      RET
      
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
      
