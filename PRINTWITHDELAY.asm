; Original program by David Lowry 2022
; Description: Prints the string stored in MSG with a delay between each character. Useful for dramatic effect.

MSG: DB 'Hello World',0 ; Message can be any length as long as it is null-terminated

PUTCHR EQU 0BE62H ; ROM routine that prints a single character, stored in A

PRINTDELAY:
        LD DE,0         ; DE is the address the character is printed at
        LD HL,MSG       ; HL now points to the first character in MSG
PRINT:  LD A,(HL)       ; A now contains the data that HL points to
        PUSH HL         ; Push the address stored in HL to the stack
        CALL PUTCHR     ; Call the ROM routine for printing the ASCII character stored in A at the screen coordinates stored in DE
                        ; Note: D and E are Y and X respectively, not X and Y.
        POP HL          ; Pop HL off of the stack. PUTCHR overwrites HL so pushing it to the stack before we call it, then popping it
                        ; right after ensures we don't lose our location in the MSG string.
        CALL DELAY      ; Delay function basically executes meaningless code thousands of times to "pause" the system for a fraction of a second
        INC E           ; Remember E is the X coordinate that the character will be printed to. If we don't increment it, then the next
                        ; character will print in the same spot that the last one did and overwrite it.
        INC HL          ; HL now points to the next character in MSG
        XOR A           ; Reset the A register, equivalent to LD A,0 but with a slight speed advantage. If we don't do this, the function repeats forever
        LD B,(HL)       ; On the Zilog Z80 you can't do a comparison with respect to the HL, H or L registers. So, we load the value into B so we can
                        ; perform a comparison.
        CP B            ; "Compare B," In this case, we use this to compare B to the value of 0. If it is equal to zero, the Zero flag will be set.
        JP NZ,PRINT     ; Jump to "PRINT" if B is not zero flag is not set. This and the line above it are equal to IF(B != 0) THEN GOTO PRINT
        RET             ; Function is now finished, return.
        
; Execute meaningless code thousands of times to pause the system.
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
