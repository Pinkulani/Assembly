.global _start

_start:
;Adress Directive for Microcontroller
include reg51.inc
Start equ P3.2
Stop equ P3.3
EnR equ P3.6
EnL equ P3.7
DP equ P2.0

Main: MOV R1, #0
      MOV R0, #0
      CLR EnR
      CLR EnL
Begin: JNB Start, Begin
Go:    CALL Wait
       CALL Count
       JNB Stop, Go
       CALL Output
       JMP $

Wait: MOV R7, #10
ML:   DJNZ R7, ML
      RET

Count:    CJNE R0, #9, R0Done
          INC R1
          MOV R0, #0
          JMP, Done
R0Done:   INC R0
Done:     RET

Output: MOV DPTR, #Segment
Loop:   MOV A, R0
        MOVC A, @A+DPTR
        CLR EnL
        MOV P2, A
        SETB EnR
        MOV A, R1
        MOVC A, @A+DPTR
        CLR EnR
        MOV P2, A
        SETB DP
        SETB EnL
        LJMP Loop
        RET

Segment:
    DB 01111110b, 00010010b, 10111100b, 10110110b, 11010010b, 11100110b, 11101110b, 00110010b
    DB 11111110b, 11110110b, 11111011b, 11001111b, 01101101b, 10011111b, 11101101b, 11101001b