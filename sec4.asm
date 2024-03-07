#include "p16f887.inc"

; CONFIG1
; __config 0x3FFF
 __CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF
 
    LIST p=16F887
 
N EQU 0xE0
cont EQU 0x20
cont1 EQU 0x21
cont2 EQU 0x22
cont3 EQU 0x23
var1 EQU 0x24
var2 EQU 0x25
var3 EQU 0x26
var4 EQU 0x27
 
    ORG 0x00
    GOTO INICIO
   
INICIO
    BCF STATUS,RP0  
    BCF STATUS,RP1  
    CLRF PORTA	    
    CLRF PORTD	    
    BSF STATUS, RP0 
    CLRF TRISA
    CLRF TRISD
    BSF STATUS,RP1
    CLRF ANSELH
    BCF STATUS,RP0
    BCF STATUS,RP1

VARIABLES	    ;define los valores iniciales de cont, cont3, var1, var2, var3
    BCF STATUS,0
    MOVLW 0x80
    MOVWF var1	    ;var1=0x80
    MOVLW 0x20	    
    MOVWF var2	    ;var1=0x20
    MOVLW 0x02
    MOVWF var3	    ;var1=0x02
    MOVLW 0x6
    MOVWF cont	    ;cont=0x06
    MOVLW 0x8
    MOVWF cont3	    ;cont3=0x06
 
LOOP1
    CLRF var4
    MOVFW var1
    IORWF var4,1    ;var4 = OR var1
    MOVFW var2
    IORWF var4,1    ;var4 = OR var2
    MOVFW var3
    IORWF var4,0    ;var4 = OR var3
    MOVWF PORTD	    ;mover var4 a PORTD
    CALL DELAY	    ;llamada a RETARDO
    DECFSZ cont     ;decrementar contador, si cont=0 salta la siguiente línea
    GOTO LOOP2	    ; ir a LOOP2
    CLRF var2	    ; limpiar var2, ocuerre si cont=0
   
LOOP2
    BCF STATUS,0
    RRF var1	    ;mover var1 1 bit a la derecha
    RRF var2	    ;mover var2 1 bit a la derecha
    RLF var3	    ;mover var3 1 bit a la izquierda
    CALL DELAY	    ;llamada a RETARDO
    DECFSZ cont3    ;decrementar contador, si cont3=0 salta la siguiente línea
    goto LOOP1	    ;ir a LOOP1
    goto VARIABLES  ;ir a VARIABLES, ocurre su cont3=0
   
DELAY
    CALL RETARDO
    CALL RETARDO
    CALL RETARDO
    CALL RETARDO
    CALL RETARDO
    RETURN
   
RETARDO
    MOVLW N
    MOVWF cont1
   
REP_1
    MOVLW N
    MOVWF cont2
   
REP_2
    DECFSZ cont2,1
    GOTO REP_2
    DECFSZ cont1,1
    GOTO REP_1
    RETURN
   
    END


