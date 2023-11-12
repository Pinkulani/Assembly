.global _start

_start:
;Adress Directive for Microcontroller
include reg51.inc

SI EQU P3.2 ;Switch On/Off Interrupt
SF EQU P3.3 ;Go up in intensity
SB EQU P3.4 ;Go down in intensity
LED EQU P1
On EQU 0h

LJMP Main ;Jump over Interrupt to Main program

;Calling of Interrupt
ORG 0003h ;Adress for Interrupt
    LCALL OnOff
    RETI

;Initiliasation
Main: LCALL Init

;Evaluation of Switch
Start: JNB On, Start
Up:    JNB SF, Down
       JB LED.3, Start ;Reached highest intensity?
       MOV A, LED
       RL A            ;Go up in intensity
       MOV LED, A
       LJMP Wait
Down:  JNB SB, Start
       JB LED.0, Start ;Reached lowest intensity?
       MOV A, LED
       RR A            ;Go down in intensity
       MOV LED, A
Wait: LCALL Wait1s     ;Wait till next input
      LJMP Start

Init: CLR On
      MOV LED, #00h ;Turn off Display
      CLR IE0
      SETB IT0 ;Negative Edge Control
      SETB EX0 ;Enable Interrupt
      SETB EA  ;Enable Intterupt globally
      RET

OnOff: CPL On
       LCALL Wait25ms
       JNB On, CompletelyOff
       MOVE LED, #0001b           ;Start with lowest intensity
       RET
CompletelyOff: MOV LED, #0000b    ;Shut everything off
               RET

:Wait 25ms for debounce of switch
Wait25ms: MOV R3, #50
          Loop1: MOV R4, #250
          Loop2: DJNZ R4, Loop2
          DJNZ R3, Loop1
          RET

Wait1s: RET

END