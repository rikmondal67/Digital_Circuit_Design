;multiplication of two number

MVI B,03H; multiplier
MVI C,02H; multiplicant


MVI A,00H;


MUL:ADD B;
DCR C
JNZ MUL;

STA 2000H
HLT