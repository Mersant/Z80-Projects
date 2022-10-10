; Original program by David Lowry 2022
; Description: Prints the string stored in MSG with a delay between each character. Useful for dramatic effect.

MSG: DB 'Hello World',0 ; Message can be any length as long as it is null-terminated

PUTCHR EQU 0BE62H ; ROM routine that prints a single character, stored in A

PRINTDELAY:
        LD DE,0
        LD HL,MSG
PRINT:  LD A,(HL)
        PUSH HL
        CALL PUTCHR
        POP HL
        CALL DELAY
        INC E
        INC HL
        XOR A
        LD B,(HL)
        CP B
        JP NZ,PRINT
        RET

DELAY:  PUSH AF
        PUSH BC
        LD BC,00FFFH
DLY0:   BIT 0,A
        BIT 0,A
        AND 0FFH
        DEC BC
        LD A,C
        OR B
        JP NZ,DLY0
        POP BC
        POP AF
        RET
