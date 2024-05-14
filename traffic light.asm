#start=Traffic_Lights.exe#  ;Open traffic light
.Model Small
.Stack 100
.Data
    S1 DW 0000_0011_0000_1100B
    s2 DW 0000_0010_1000_1010B
    s3 DW 0000_1000_0110_0001B
    s4 DW 0000_0100_0101_0001B 
    
        ;FEDC_BA98_7654_3210 Green_Yellow_Red
    
    ALL_RED EQU 0000_0010_0100_1001B;Set cho truong hop dau la toan do
    PORT EQU 4;Cong ra la cong so 4    
         
    ;WAIT 1s     
    WAIT_1_SEC_CX EQU 0Fh
    WAIT_1_SEC_DX EQU 4240h
    
    ;WAIT 3s
    WAIT_3_SEC_CX EQU 2Dh
    WAIT_3_SEC_DX EQU 0C6C0h
            
    ;WAIT 10s        
    WAIT_10_SEC_CX EQU 98h
    WAIT_10_SEC_DX EQU 9680h
    
.Code
    waitMacro MACRO t1,t2
        MOV CX,t1
        MOV DX,t2
        MOV AH, 86H
        INT 15H
    ENDM
    
Main Proc
    MOV AX,@Data
    MOV DS,AX
          
    ;Khoi tao truong hop dau tien cac den mau do       
    MOV AX,ALL_RED
    OUT PORT,AX
    waitMacro WAIT_3_SEC_CX,WAIT_3_SEC_DX ;Sau 3s chuyen den s1  
    
    Start:
        LEA SI,S1
        MOV AX,[SI]
        OUT PORT,AX
         
        waitMacro WAIT_10_SEC_CX,WAIT_10_SEC_DX;Chay s1 trong 10s sau do chuyen sang s2
        LEA SI,S2
        MOV AX,[SI]
        OUT PORT,AX
        
        waitMacro WAIT_1_SEC_CX,WAIT_1_SEC_DX;Chay s2 trong 1s sau do chuyen sang s3
        LEA SI,S3
        MOV AX,[SI]
        OUT PORT,AX
            
        waitMacro WAIT_10_SEC_CX,WAIT_10_SEC_DX; Chay s3 trong 10s chuyen sang s4
        LEA SI,S4
        MOV AX,[SI]
        OUT PORT,AX 
        
        waitMacro WAIT_1_SEC_CX,WAIT_1_SEC_DX ;Chay s4 trong 1s jump len start 
        JMP Start
        
        MOV AH,4CH
        INT 21H
MAIN Endp
END MAIN