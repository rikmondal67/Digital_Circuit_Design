;code to check if the number is even or not
LDA 2000H ;taking the value from the adress 2000h
LXI H,2001H ;store in the adress 2001 if even=>1 else 0
MVI C,00H
RAR
JNC EVEN
INR C
EVEN: MOV M,C
HLT