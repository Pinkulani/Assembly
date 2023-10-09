.global _start

_start:
include reg51.inc
MOV DPTR, #seg
marker: MOV A, P1
        ANL A, #00001111b
        MOVC A, @A+DPTR
        MOV P2, A
        MOV A, P1
        ANL A, #11110000b
        SWAP A
        MOVC A,@A+DPTR
        MOV P0, A
        LJMP marker
    seg: DB 3Fh, 06h, 5Bh, 4Fh
         DB 66h, 6Dh, 7Dh, 07h
         DB 7Fh 6Fh, 0F7h, 0FCh
         DB 0D8h, 0DEh, 0F9h, 0F1h