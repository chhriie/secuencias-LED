#include p16f887.inc

; CONFIG1
; __config 0x28D5
 __CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

    
 LIST p=16F887

N EQU 0xE0           
cont1 EQU 0x20       ; Contador
cont2 EQU 0x21       ; Contador
con1 EQU 0x22        ; Contador 
con2 EQU 0x23        ; Contador 
var1 EQU 0x24        ; Variable 1
var2 EQU 0x25        ; Variable 2
var3 EQU 0x26        ; Variable 3

    ORG 0x00           ; Inicio de programa
    GOTO INICIO        ; Salta a la etiqueta INICIO
    
INICIO
    BCF STATUS, RP1    ; Limpia el bit RP1 del registro de estatus
    BSF STATUS, RP0    ; Setea el bit RP0 del registro de estatus
    MOVLW 0x71         ; Carga W con 0x71
    MOVWF OSCCON       ; Escribe W al registro OSCCON para configurar el oscilador interno
    MOVLW 0x10         ; Carga W con 0x10
    MOVWF TRISA        
    CLRF TRISD         ; Configura el puerto D como salida
    BSF STATUS, RP1    
    CLRF ANSEL         ; Limpia el registro ANSEL
    BCF STATUS, RP0   
    BCF STATUS, RP1
    
SECUENCIA1
    MOVLW 0x80         ; Carga W con 0x80
    MOVWF var1         ; Guarda W en var1
    MOVLW 0x40         ; Carga W con 0x40
    MOVWF var2         ; Guarda W en var2
    MOVLW 0x04         ; Carga W con 0x04
    MOVWF con1         ; Guarda W en con1
    CLRF PORTD         ; Limpia el puerto D
    
LOOP1
    MOVF var1,0        ; Mueve el contenido de var1 a W
    IORWF var2, 0      ; OR lógico entre var2 y W
    MOVWF PORTD        ; Mueve W al puerto D
    CALL DELAY         ; Llama a DELAY
    
LOOP2
    RRF var1           ; Rota a la derecha var1
    RRF var1,1         ; Rota a la derecha var1
    RRF var2           ; Rota a la derecha var2
    RRF var2,1         ; Rota a la derecha var2
    DECFSZ con1,1      ; Decrementa con1, salta si es cero
    GOTO LOOP1         ; Salta a LOOP1 si con1 no es cero
    GOTO SECUENCIA2    ; Salta a SECUENCIA2
    
SECUENCIA2
    MOVLW 0x02         ; Carga W con 0x02
    MOVWF var1         ; Guarda W en var1
    MOVLW 0x01         ; Carga W con 0x01
    MOVWF var2         ; Guarda W en var2
    MOVLW 0x04         ; Carga W con 0x04
    MOVWF con2         ; Guarda W en con2
    CLRF PORTD         ; Limpia el puerto D
    
LOOP3
    MOVF var1, 0       ; Mueve el contenido de var1 a W
    IORWF var2, 0      ; OR lógico entre var2 y W
    MOVWF PORTD        ; Mueve W al puerto D
    CALL DELAY         ; Llama a DELAY
  
LOOP4
    RLF var1           ; Rota a la izquierda var1
    RLF var1,1         ; Rota a la izquierda var1
    RLF var2           ; Rota a la izquierda var2
    RLF var2,1         ; Rota a la izquierda var2
    DECFSZ con2,1      ; Decrementa con2, salta si es cero
    GOTO LOOP3         ; Salta a LOOP3 si con2 no es cero
    BCF STATUS,0       ; Limpia el bit de cero del registro de estatus
    GOTO SECUENCIA1    ; Salta a SECUENCIA1
   
DELAY
    CALL RETARDO       
    CALL RETARDO     
    CALL RETARDO      
    CALL RETARDO       
    CALL RETARDO       
    CALL RETARDO       
    RETURN             
    
RETARDO
    MOVLW N            ; Carga W con N
    MOVWF cont1        ; Guarda W en cont1
    
REP_1
    MOVLW N            ; Carga W con N
    MOVWF cont2        ; Guarda W en cont2
    
REP_2
    DECFSZ cont2,1     ; Decrementa cont2, salta si es cero
    GOTO REP_2         ; Salta a REP_2 si cont2 no es cero
    DECFSZ cont1,1     ; Decrementa cont1, salta si es cero
    GOTO REP_1         ; Salta a REP_1 si cont1 no es cero
    RETURN             ; Retorna

    END            ; Fin del código


