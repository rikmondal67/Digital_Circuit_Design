;2+4+8+16...
LDA 2050H      ; Load N (number of terms)
      MOV C, A       ; Use C as the loop counter
      LXI H, 0001H   ; Use HL as the term generator. Start at 1.
      LXI D, 2000H   ; Use DE as memory pointer to store data.

; --- PART 1: GENERATE AND STORE 16-BIT TERMS ---
LOOP_GEN:
      DAD H          ; HL = HL + HL (This doubles the term: 1->2, 2->4, 4->8)
      
      MOV A, L       ; Store the low-byte of the term
      STAX D
      INX D
      MOV A, H       ; Store the high-byte of the term
      STAX D
      ; INX D
      
      DCR C          ; Decrement counter
      JNZ LOOP_GEN   ; Loop N times

; --- PART 2: SUM THE 16-BIT TERMS ---
      LDA 2050H      ; Reload N
      MOV C, A       ; Use C as loop counter again
      LXI D, 2000H   ; Reset memory pointer to start
      LXI H, 0000H   ; Initialize 16-bit sum (HL) to 0

LOOP_SUM:
      LDAX D         ; Get low-byte of term from [DE]
      MOV E, A       ; Store it in E
      INX D
      LDAX D         ; Get high-byte of term from [DE+1]
      MOV D, A       ; Store it in D
      INX D          ; (Now DE holds the 16-bit term)

      DAD D          ; Add the term (DE) to the sum (HL)
      
      DCR C          ; Decrement counter
      JNZ LOOP_SUM   ; Loop N times

; --- PART 3: STORE THE FINAL 16-BIT SUM ---
      SHLD 2060H     ; Store HL (the sum) at 2060H and 2061H
      HLT