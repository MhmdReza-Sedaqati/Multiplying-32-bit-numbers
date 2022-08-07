DATA SEGMENT  
    
    A DW 3618H
      DW 540AH 
      
    B DW 0A5CH
      DW 0800H  
      
    RESULT DW 0,0,0,0 
    
DATA ENDS



STACK_SEG SEGMENT STACK 
    
    DW 100 DUP(0)
    TOP_STACK LABEL WORD 
    
STACK_SEG ENDS    
              
              


CODE SEGMENT
    
    ASSUME DS:DATA , CS:CODE 
    
    MOV AX,DATA
    MOV DS,AX
    
    MOV AX,STACK_SEG
    
    
    MOV SP,OFFSET TOP_STACK
    
    
    MAIN:
        PUSH AX
        CALL MULTIPLY
        POP AX
        NOP
        
    
    MULTIPLY PROC NEAR:
        
        PUSHF
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH BP
        MOV BP,SP
        MOV AX,[BP+12]
        
        MOV AX,A
        MUL B
        MOV RESULT,AX
        MOV RESULT+2,DX

        MOV AX,A+2
        MUL B
        ADD RESULT+2,AX
        ADC RESULT+4,DX
        ADC RESULT+6,0

        MOV AX,A
        MUL B+2
        ADD RESULT+2,AX
        ADC RESULT+4,DX
        ADC RESULT+6,0

        MOV AX,A+2
        MUL B+2
        ADD RESULT+4,AX
        ADC RESULT+6,DX
        
        POP BP
        POP CX
        POP BX
        POP AX
        POPF 
        
    MULTIPLY ENDP
    
CODE ENDS                      