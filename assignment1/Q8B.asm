LHLD 2008H;TEMP ADDR
LHLD 200AH;BASE ADDR

LOOP1:
    MOV A,M;
    LOOP2:
        INX H;
        CMP M;
        JC:SKIP
        MOV A,M;
        SHLD 2008H
    SKIP:
        DCR C;
        JNZ LOOP2;
    LHLD 2008;
    MOV D,M;
    LHLD 200AH;
    MOV E,M;
    MOV M,D;
    LHLD 2008H;
    MOV M,E;
    INX H;
    SHLD 2008H;
    SHLD 200AH;
    DCR B;
    JNZ LOOP1;