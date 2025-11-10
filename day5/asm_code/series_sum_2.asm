LXI H, 0000H   ; Initialize the 16-bit sum (HL) to 0
      LDA 2050H      ; Load N into the Accumulator
      MOV B, A       ; Use B as the main loop counter (counts N times)
      MVI C, 01H     ; Use C as the 'current term' (starts at 1)

LOOP:
      MOV A, C       ; Move current term 'C' into A to check it
      RAR            ; Rotate right. The least significant bit (LSB)
                     ; moves into the Carry Flag.
                     ; If LSB=1 (odd), Carry Flag (CY) is SET (1).
                     ; If LSB=0 (even), Carry Flag (CY) is RESET (0).

      JC ADD_TERM    ; Jump if Carry is set (i.e., C is ODD)

;--- IF NUMBER IS EVEN (SUBTRACT) ---
SUB_TERM:
      MOV E, C       ; Load C into E
      MVI D, 00H     ; Set D = 0. Now DE = 000C (16-bit version of C)
      
      ; Perform 16-bit subtraction: HL = HL - DE
      MOV A, L       ; Get low byte of sum
      SUB E          ; Subtract low byte of term (A = L - E)
      MOV L, A       ; Store new low byte of sum
      MOV A, H       ; Get high byte of sum
      SBB D          ; Subtract high byte WITH BORROW (A = H - D - Borrow)
      MOV H, A       ; Store new high byte of sum
      
      JMP NEXT_ITER  ; Jump to the next iteration

;--- IF NUMBER IS ODD (ADD) ---
ADD_TERM:
      MOV E, C       ; Load C into E
      MVI D, 00H     ; Set D = 0. Now DE = 000C
      
      ; Perform 16-bit addition: HL = HL + DE
      DAD D          ; DAD D adds DE to HL and stores in HL
      
NEXT_ITER:
      INR C          ; Increment the current term (C = C + 1)
      DCR B          ; Decrement the loop counter
      JNZ LOOP       ; If counter is not zero, loop again

;--- STORE THE RESULT ---
DONE:
      SHLD 2051H     ; Store HL pair at 2051H (L) and 2052H (H)
      HLT            ; Halt the program