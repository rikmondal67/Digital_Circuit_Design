;3+6+9+12+15

MVI C,09H;
MOV D,C;
LXI H,2000H;
LOOP:ADI 03H;
INX H;
MOV M,A;
DCR C;
JNZ LOOP;
MOV C, D       ; Reload the counter
      LXI H, 2000H   ; Point HL to the first number
      LXI D, 0000H   ; *** FIX: Initialize 16-bit sum (DE) to 0 ***

SUM:
      MOV A, M       ; Get number from memory [HL]
      
      ; --- Add the 8-bit number (A) to the 16-bit sum (DE) ---
      ADD E          ; Add A to the low-byte (E). Carry is set if it overflows.
      MOV E, A       ; Store the new low-byte sum in E.
      
      MOV A, D       ; Get the high-byte (D).
      ACI 00H        ; Add 0 to the high-byte *with* the Carry.
                     ; (This adds 1 to D if the ADD E had an overflow).
      MOV D, A       ; Store the new high-byte sum in D.
    
      
      INX H         
      DCR C          
      JNZ SUM        


      MOV H, D       
      MOV L, E       
      
      SHLD 2050H     
      HLT