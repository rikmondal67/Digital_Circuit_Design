; 3+9+27+...

LDA 2050H      ; Load N
      MOV B, A       ; Use B as the loop counter
      
      LXI H, 0001H   ; Start HL at 1. (It will be multiplied by 3
                     ; to get 3 *before* the first store)
                     
      LXI D, 2000H   ; Use DE as memory pointer to store data

; --- PART 1: GENERATE AND STORE 16-BIT TERMS ---
LOOP_GEN:
      ; --- Calculate HL = HL * 3 ---
      MOV C, L       ; Save current HL in BC (temp)
      MOV B, H
      DAD H          ; HL = HL + HL (HL * 2)
      DAD B          ; HL = (HL * 2) + (original HL)
      ; --- HL now holds the next term ---

      MOV A, L       ; Store the low-byte of the term
      STAX D
      INX D
      MOV A, H       ; Store the high-byte of the term
      STAX D
      INX D
      
      DCR B          ; Decrement counter
      JNZ LOOP_GEN   ; Loop N times

; --- PART 2: SUM THE 16-BIT TERMS ---
      LDA 2050H      ; Reload N
      MOV B, A       ; Use B as loop counter again
      LXI D, 2000H   ; Reset memory pointer to start
      LXI H, 0000H   ; Initialize 16-bit sum (HL) to 0

LOOP_SUM:
      LDAX D         ; Get low-byte of term from [DE]
      MOV C, A       ; Store it in C
      INX D
      LDAX D         ; Get high-byte of term from [DE+1]
      MOV B, A       ; Store it in B
      INX D          ; (Now DE holds the 16-bit term)

      DAD B          ; Add the term (BC) to the sum (HL)
      
      DCR B          ; Decrement counter
      JNZ LOOP_SUM   ; Loop N times

; --- PART 3: STORE THE FINAL 16-BIT SUM ---
      SHLD 2060H     ; Store HL (the sum) at 2060H and 2061H
      HLT