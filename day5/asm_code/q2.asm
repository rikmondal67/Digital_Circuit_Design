; code to clear memory

MVI C,0EH;
LXI H,2000H;



LOOP:CALL CLEAR
DCR C
JNZ LOOP

HLT

CLEAR:MVI M,00H;
INX H;
RET





	
	