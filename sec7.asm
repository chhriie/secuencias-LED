; PIC16F887 Configuration Bit Settings

; Assembly source line config statements

#include "p16f887.inc"

; CONFIG1
; __config 0x20D5
 __CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

    LIST p=16F887

; Creación de las variables
N EQU 0xE0
cont1 EQU 0x20
cont2 EQU 0x21
con1 EQU 0x22
con2 EQU 0x23
var1 EQU 0x24
var2 EQU 0X25

    ORG 0x00
    GOTO INICIO

INICIO
    BCF STATUS,RP1
    BSF STATUS,RP0
    MOVLW 0x71
    MOVWF OSCCON
    MOVLW 0x10
    MOVWF TRISA
    CLRF TRISD
    BSF STATUS,RP1
    CLRF ANSEL
    BCF STATUS,RP0
    BCF STATUS,RP1
   
SECUENCIAA
    MOVLW 0x04 ;SECUENCIAA define los valores iniciales de con1, con2, var1, var2
    MOVWF con1
    MOVLW 0x04
    MOVWF con2
    MOVLW 0x80
    MOVWF var1
    MOVLW 0x01
    MOVWF var2
    CLRF PORTD ;y limpia PORTD.
   
SECUENCIA1
    MOVF var1,0 ; SECUENCIA1 realiza la operación OR entre var1 y var2
    IORWF var2,0
    MOVWF PORTD ; se mueve el resultado del registro W al registro PORTD
    CALL DELAY
   
LOOP1
    RRF var1 ; var1 es rotado un bit a la derecha
    BSF var1,7 ; bit 7 de var1 es 1
    RLF var2 ; var2 es rotado un bit a la izquierda
    BSF var2,0 ; bit 0 de var2 es 1
    DECFSZ con1,1 ; se decrementa con1 y se mueve el resultado a con1
    GOTO SECUENCIA1 ; regresa a SECUENCIA1 en caso de que con1 sea diferente de cero (0)
    GOTO NEXT ; Va a NEXT cuando con1 sea cero
   
NEXT
    ; Se cambian los valores de var1 y var2 para las siguientes cuatro secuencias
    MOVLW 0x08 ; se mueve 0x08 al registro W
    MOVWF var1 ; se mueve el valor del registro W a var1
    MOVLW 0x10 ; se mueve 0x80 al registro W
    MOVWF var2 ; se mueve el valor del registro W a var2

SECUENCIA2
    MOVF var1,0 ; SECUENCIA2 realiza la operación OR entre las variables var1 y var2
    IORWF var2,0
    MOVWF PORTD ; se mueve SECUENCIA1 realiza la operación OR entre var1 y var2
    CALL DELAY ; llamado a retardo
   
LOOP2
    RRF var1 ; var1 es rotado un bit a la derecha
    BSF var1,3 ; bit 3 de var1 será 1
    RLF var2 ; var2 es rotado un bit a la izquierda
    BSF var2,4 ; bit 4 de var2 será 1
    DECFSZ con2,1 ; se decrementa con2 y se mueve el resultado a con2
    GOTO SECUENCIA2 ; se irá a SECUENCIA2 cuando con2 sea diferente de cero
    GOTO SECUENCIAA ; se irá a SECUENCIAA cuando con2 sea cero
   
DELAY
    CALL RETARDO
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
    end