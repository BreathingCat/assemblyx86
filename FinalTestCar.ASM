; This is a basic template file for writing 48K Spectrum code.

AppFilename             equ "NewFile"                   ; What we're called (for file generation)

AppFirst                equ $8000                       ; First byte of code (uncontended memory)

                        zeusemulate "48K","ULA+"        ; Set the model and enable ULA+


; Start planting code here. (When generating a tape file we start saving from here)

                        org AppFirst                    ; Start of application
                        jp AppEntry

MitadSuperior           equ $4000                       ; Direccion en memoria de las filas 0 a 7 de la pantalla
MitadMedia              equ $4800                       ; Direccion en memoria de las filas 8 a 15 de la pantalla
MitadInferior           equ $5000                       ; Direccion en memoria de las filas 16 a 21 de la pantalla

NumFila                 defb 0                          ; Fila en la que se imprimira el caracter
NumColumna              defb 0                          ; Columna en la que se imprimira el caracter

DirTercio               defw $0000                      ; Direccion base en la memoria del tercio de pantalla
OffsetFila              defb $0                         ;
DirBaseCaracter         defw $0000                      ; Direccion base en la memoria de pantalla del caracter

posColumnaCoche         defb 15
posFilaCoche            defb 20

NMovimientos            defb 156

DirCaracterUsr          defw 0                          ; Direccion de memoria en la que se guardara el caracter a pintar, definido
                                                        ; previamente por el usuario
NumMovimientos          defb 0

ColumnaTrofeo           defb 30
FilaTrofeo              defb 1

TiempoEspera            defb $24

InicioTextoFin          defb 11
InicioTextoInicio       defb 13

Coche                   defb $00,$3C,$7E,$66,$3C,$66,$7E,$00
Linea                   defb $00,$00,$18,$18,$18,$18,$18,$00
Cesped                  defb $00,$22,$20,$34,$02,$50,$10,$00
Calavera                defb $3C,$42,$A5,$A5,$81,$42,$24,$3C
Negro                   defb $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
Blanco                  defb $00,$00,$00,$00,$00,$00,$00,$00
Trofeo                  defb $00,$FF,$7E,$FF,$BD,$7E,$18,$3C

LetraG                  defb $00,$7E,$40,$4E,$42,$42,$7E,$00
LetraA                  defb $00,$3C,$42,$42,$7E,$42,$42,$00
LetraM                  defb $00,$42,$66,$5A,$42,$42,$42,$00
LetraE                  defb $00,$7E,$40,$40,$7C,$40,$7E,$00
LetraO                  defb $00,$3C,$42,$42,$42,$42,$3C,$00
LetraV                  defb $00,$42,$42,$24,$24,$18,$18,$00
LetraR                  defb $00,$7C,$42,$42,$7C,$48,$44,$00
LetraExc                defb $00,$54,$54,$54,$54,$00,$54,$00
LetraS                  defb $00,$3E,$40,$3C,$02,$02,$7C,$00
LetraT                  defb $00,$7E,$10,$10,$10,$10,$10,$00

Movimientos             defb 9,9,9,8,8,8,7,7,7,6,6,6
Movimientos1            defb 7,7,7,8,8,8,9,9,9,10,10,10
Movimientos2            defb 9,9,9,8,8,8,9,9,9,8,8,8
Movimientos3            defb 9,9,9,10,10,10,11,11,11,10,10,10
Movimientos4            defb 11,11,11,10,10,10,9,9,9,10,10,10
Movimientos5            defb 9,9,9,8,8,8,7,7,7,8,8,8
Movimientos6            defb 7,7,7,6,6,6,7,7,7,8,8,8
Movimientos7            defb 7,7,7,6,6,6,5,5,5,6,6,6
Movimientos8            defb 7,7,7,8,8,8,9,9,9,8,8,8
Movimientos9            defb 9,9,9,10,10,10,11,11,11,10,10,10
Movimientos10           defb 11,11,11,12,12,12,13,13,13,12,12,12
Movimientos11           defb 11,11,11,12,12,12,13,13,13,12,12,12
Movimientos12           defb 13,13,13,12,12,12,11,11,11,10,10,10
Movimientos13           defb 9,9,9,8,8,8,7,7,7,6,6,6
Movimientos14           defb 7,7,7,8,8,8,9,9,9,10,10,10
InicioMovimientos       equ $

; MAIN -----------------------------------------------------------------------------------------------------------------------------------------

AppEntry:               call iniciarPantalla            ; Se pinta la pantalla entera de cesped, sin pintar la carretera aun

                        ld a, 155                       ; 156 movimientos que se repetiran en bucle
                        ld (NumMovimientos), a
                        ld iy, InicioMovimientos        ; Se inicia con un puntero al inicio de los movimientos
                        dec iy

                        //call pintarPantalla

                        ; START!!!
                        ld a, $0C
                        ld (NumFila), a

                        ; S
                        ld a, (InicioTextoInicio)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoInicio), a

                        call direccionCaracter
                        ld hl, LetraS
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; T
                        ld a, (InicioTextoInicio)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoInicio), a

                        call direccionCaracter
                        ld hl, LetraT
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; A
                        ld a, (InicioTextoInicio)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoInicio), a

                        call direccionCaracter
                        ld hl, LetraA
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; R
                        ld a, (InicioTextoInicio)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoInicio), a

                        call direccionCaracter
                        ld hl, LetraR
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; T
                        ld a, (InicioTextoInicio)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoInicio), a

                        call direccionCaracter
                        ld hl, LetraT
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; !!
                        ld a, (InicioTextoInicio)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoInicio), a

                        call direccionCaracter
                        ld hl, LetraExc
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        // Espera de start
                        ld a, $FF
                        ld b, a
StartCuenta             halt
                        djnz StartCuenta


BucleJuego:             ; Primero realizamos la comprobacion de por donde vamos pintando la carretera

                        ld a, (NumMovimientos)          ; Se carga el numero de movimientos en el acumulador
                        cp $00                          ; Si el contador ha llegado a 0 se debera resetear, para comenzar de nuevo el bucle de la carretera
                        call z resetContador

                        call pintarPantalla

                        ld a, (NumMovimientos)
                        dec a
                        ld (NumMovimientos), a
                        dec iy

                        call Teclado                    ; Se lee lo introducido por el teclado y se actualizan las posiciones del coche
                        call Choque                     ; Si el coche no se ha chocado, lo pinta en su nueva posicion. Si se ha chocado,
                                                        ; pintara una calavera en la posicion respectiva

                        call Delay                      ; Delay 20 ms

                        jp BucleJuego

Stop                    halt
                        jp Stop

; PUNTUACIONES CON TROFEOS, VELOCIDAD Y RESET DE CONTADOR

resetContador:          ld a, 155                        ; 156 movimientos que se repetiran en bucle
                        ld (NumMovimientos), a
                        ld iy, InicioMovimientos         ; Se inicia con un puntero al inicio de los movimientos
                        dec iy

                        ld a, (TiempoEspera)
                        cp $03
                        call nz AumentarVelocidad

                        ld a, (FilaTrofeo)
                        cp $17
                        call c AniadirTrofeo

                        ret

AumentarVelocidad       ld a, (TiempoEspera)
                        dec a
                        dec a
                        dec a
                        ld (TiempoEspera), a
                        ret

AniadirTrofeo           ld a, (FilaTrofeo)
                        ld (NumFila), a
                        inc a
                        ld (FilaTrofeo), a

                        ld a, (ColumnaTrofeo)
                        ld (NumColumna), a

                        call direccionCaracter
                        ld hl, Trofeo
                        ld (DirCaracterUsr), hl

                        call PaintChar
                        ret


; PINTAR PANTALLA -------------------------------------------------------------------------------------------------------------------------------

pintarPantalla:         ; En el registro iy se encuentra el puntero a donde se tiene que iniciar el pintado de pantalla
                        ; La pantalla consta de 24 filas
                        ; El numero de columnas de cada fila constara de el numero almacenado en el registro iy

                        ld a, 24                        ; El bucle se ejecutará 24 veces, una por cada fila
                        ld b, a

                        ld a, 23                          ; Empezaremos por la fila 0
                        ld (NumFila), a

                        push iy
                        pop ix                          ; Se guarda en el registro ix el puntero

BuclePintarCarretera    push bc
                        ld a, (ix)
                        and $0F                         ; El numero de movimientos esta almacenado en el primer byte, el 2 no nos importa
                        ld (NumColumna), a              ; Fila n, columna del registro ix
                        push ix

                        // Cesped
                        call PintarBlanco

                        // Caracter negro
                        call IncrementarColumna
                        call PintarNegro

                        call IncrementarColumna
                        call PintarNegro

                        // Blanco
                        call IncrementarColumna
                        call PintarBlanco

                        call IncrementarColumna
                        call PintarBlanco

                        call IncrementarColumna
                        call PintarBlanco

                        call IncrementarColumna
                        call PintarLinea

                        call IncrementarColumna
                        call PintarBlanco

                        call IncrementarColumna
                        call PintarBlanco

                        call IncrementarColumna
                        call PintarBlanco

                        //Negro

                        call IncrementarColumna
                        call PintarNegro

                        call IncrementarColumna
                        call PintarNegro

                        // Cesped
                        call IncrementarColumna
                        call PintarBlanco

                        // Siguiente fila
                        ld a, (NumFila)
                        dec a
                        ld (NumFila), a

                        // Se decrementa el puntero a la siguiente fila
                        pop ix
                        dec ix

                        pop bc
                        djnz BuclePintarCarretera

                        ret

IncrementarColumna      ld a, (NumColumna)
                        inc a
                        ld (NumColumna), a

                        ret

PintarNegro             call direccionCaracter
                        ld hl, Negro
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ret

PintarBlanco            call direccionCaracter
                        ld hl, Blanco
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ret

PintarCesped            call direccionCaracter
                        ld hl, Cesped
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ret

PintarLinea             call direccionCaracter
                        ld hl, Linea
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ret

; INICIAR PANTALLA -------------------------------------------------------------------------------------------------------------------------------

iniciarPantalla         ld a, 24
                        ld b, a

BucleFilas              push bc
                        ld a, 0
                        ld (NumColumna), a

                        ld a, 32
                        ld b, a

BucleColumnas           push bc
                        call direccionCaracter
                        ld hl, Blanco
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ld a, (NumColumna)
                        inc a
                        ld (NumColumna), a

                        pop bc
                        djnz BucleColumnas

                        ld a, (NumFila)
                        inc a
                        ld (NumFila), a

                        pop bc
                        djnz BucleFilas

                        ret

; CHOQUE -----------------------------------------------------------------------------------------------------------------------------------------

Choque                  ld a, (posColumnaCoche)         ; Se guarda en NumColumna la posicion del coche
                        ld (NumColumna), a

                        ld a, (posFilaCoche)            ; Se guarda en NumFila la posicion del coche
                        ld (NumFila), a

                        call direccionCaracter          ; Se calcula su nueva direccion en la pantalla

                        ; Una vez tengamos su direccion de memoria de pantalla, podemos calcular si esta es carretera ($00) u otra cosa

                        ld hl, (DirBaseCaracter)        ; Se guarda en el registro hl la nueva direccion de pantalla del coche
                        ld a, (hl)                      ; Se guardan en el acumulador los primeros bytes de la nueva direccion

                        cp $00                          ; Se compara
                        jp nz Chocado                   ; Si no son blancos significa que es negro. El juego finaliza

                        ; Si no ha chocado hay que pintar el coche en la nueva direccion

                        ld hl, Coche
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ret

                        ; Si se ha chocado pintara una calavera en la fila debajo del choque

Chocado                 ld a, (posFilaCoche)
                        ld (NumFila), a

                        ld a, (posColumnaCoche)
                        ld (NumColumna), a

                        call direccionCaracter

                        ld hl, Calavera
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; GAME OVER!!!

                        ld a, $0C
                        ld (NumFila), a

                        ; G
                        ld a, (InicioTextoFin)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoFin), a

                        call direccionCaracter
                        ld hl, LetraG
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; A
                        ld a, (InicioTextoFin)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoFin), a

                        call direccionCaracter
                        ld hl, LetraA
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; M
                        ld a, (InicioTextoFin)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoFin), a

                        call direccionCaracter
                        ld hl, LetraM
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; E
                        ld a, (InicioTextoFin)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoFin), a

                        call direccionCaracter
                        ld hl, LetraE
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; Blanco
                        ld a, (InicioTextoFin)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoFin), a

                        call direccionCaracter
                        ld hl, Blanco
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; O
                        ld a, (InicioTextoFin)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoFin), a

                        call direccionCaracter
                        ld hl, LetraO
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; V
                        ld a, (InicioTextoFin)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoFin), a

                        call direccionCaracter
                        ld hl, LetraV
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; E
                        ld a, (InicioTextoFin)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoFin), a

                        call direccionCaracter
                        ld hl, LetraE
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; R
                        ld a, (InicioTextoFin)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoFin), a

                        call direccionCaracter
                        ld hl, LetraR
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        ; !!
                        ld a, (InicioTextoFin)
                        ld (NumColumna), a
                        inc a
                        ld (InicioTextoFin), a

                        call direccionCaracter
                        ld hl, LetraExc
                        ld (DirCaracterUsr), hl

                        call PaintChar

                        jp Stop

; TECLADO ----------------------------------------------------------------------------------------------------------------------------------------

Teclado:                ld bc, $DFFE                    ; Se carga el estado del puerto $DFFE en el registro bc
                                                        ; pero solo nos interesa el estado de los 4 primeros bytes

                        in a, (c)                       ; Se carga el estado del puerto en el acumulador
                        rra                             ; Se mueve un bit a la derecha. Si el ultimo era un 1 se activara el flag de carry (nc) "P"

                        push af                         ; Se guarda el registro del acumulador
                        call nc, moverCaracterDerecha   ; Si el primer bit del registro era un 1 significa que se estaba pulsando la P en el teclado
                        pop af                          ; Se recupera el estado del registro af

                        rra                             ; "O"
                        rra                             ; "I"

                        push af                         ; Se guarda el registro del acumulador
                        call nc, moverCaracterIzquierda ; Si el 3 bit del registro era un 1 significa que se estaba pulsando la I en el teclado
                        pop af                          ; Se recupera el estado del registro af

                        ret

moverCaracterDerecha    ld a, (posColumnaCoche)         ; Se carga en el acumulador la posicion de la columna del coche
                        inc a                           ; Se incrementa (derecha)
                        ld (posColumnaCoche), a
                        ret                             ;

moverCaracterIzquierda  ld a, (posColumnaCoche)           ; Se carga en el acumulador la posicion de la columna del coche
                        dec a                           ; Se decrementa (izquierda)
                        ld (posColumnaCoche), a
                        ret                             ;

; FUNCION CALCULAR DIRECCION DE CARACTER RESPECTO A FILAS Y COLUMNAS -----------------------------------------------------------------------------

direccionCaracter       call calcularDireccion          ; Se calcula en que tercio pertenece el caracter y se guarda en DirTercio
                        call calcularFila               ; Se calcula el offset de la fila
                        call calcularByteDireccion      ; Se calcula la direccion final del caracter
                        ret                             ; Se devuelve el control a basic

; ENTORNO CALCULAR DIRECCION TERCIO --------------------------------------------------------------------------------------------------------------

calcularDireccion:      ; Calcula la direccion de pantalla en la que tiene que imprimir el usuario
                        ; Solo halla en cual tercio de pantalla se encuentra el caracter

                        ld a, (NumFila)                 ; Se carga en el acumulador la fila en la que se quiere imprimir el caracter
                        cp 16                           ; Si es mayor que 16 estara en el tercio inferior
                        jp nc tercioInferior

                        cp 8                            ; Si es mayor que 8 estara en el tercio medio
                        jp nc tercioMedio

                        ; Si no ha saltado a ninguno de los anteriores significa que esta en el tercio superior

tercioSuperior          ld hl, MitadSuperior            ; Se carga en el registro hl la direccion del tercio superior de pantalla
                        ld (DirTercio), hl              ; Se guarda en DirTercio la direccion del tercio superior
                        ret                             ; Se devuelve el control a basic

tercioMedio             ld hl, MitadMedia               ; Se carga en el registro hl la direccion del tercio medio de pantalla
                        ld (DirTercio), hl              ; Se guarda en DirTercio la direccion del tercio mitad
                        ret                             ; Se devuelve el control a basic

tercioInferior          ld hl, MitadInferior            ; Se carga en el registro hl la direccion del tercio inferior de pantalla
                        ld (DirTercio), hl              ; Se guarda en DirTercio la direccion del tercio inferior
                        ret                             ; Se devuelve el control a basic

; ENTORNO CALCULAR FILA CARACTER -----------------------------------------------------------------------------------------------------------------

calcularFila:           ; Para calcular el offset de fila, primero deberemos calcular cuantas filas esta dentro de su tercio. Esto se puede calcular
                        ; tomando los ultimos 3 bits del numero de fila en la que queremos colocar, multiplicarlo por $20 (sumatorio por cada fila)
                        ; y sumarlo a la direccion base de cada tercio.

                        xor a                           ; or exclusivo a si mismo, para ponerlo a 0
                        ld (OffsetFila), a              ; De momento el offset es 0
                        ld a, (NumFila)                 ; Se vuelve a cargar el numero de fila en el acumulador

                        and a, $07                      ; Nos quedamos con los ultimos 3 bits
                        ret z                           ; Si el acumulador es 0, no hace falta sumar nada

                        ld b, a                         ; Se carga en el registro b el numero de veces que se tiene que sumar $20, contador
                        xor a                           ; or exclusivo a si mismo, para ponerlo a 0, se utilizara como suma

BucleSumaFila           add $20                         ; Se suma a la siguiente fila
                        djnz BucleSumaFila              ; Se sumara hasta que el registro en b este a 0

                        ; Una vez se haya terminado de sumar, en el acumulador se encuentra el offset de la fila, que luego se sumara a la direccion
                        ; base de el tercio de pantalla correspondiente

                        ld (OffsetFila), a              ; Se guarda el contenido en offsetFila
                        ret                             ; Se devuelve el control a basic

; ENTORNO CALCULAR DIRECCION DEL BYTE ------------------------------------------------------------------------------------------------------------

calcularByteDireccion:  ; Aqui se calculara la direccion final del caracter, tomando en cuenta el offset de su fila y su columna, mas su tercio,
                        ; y se almacenara finalmente en el registro DirBaseCaracter

                        ld hl, (DirTercio)              ; Se carga en el registro hl la direccion al tercio en el que pertenece
                        ld de, (OffsetFila)             ; Se carga en de el offset de fila en de, aunque esta almacenado solamente en e
                        ld d, 0                         ; Puede que d sea basura. Lo igualamos a 0, por si acaso

                        add hl, de                      ; Se suma la direccion del tercio al offset de su fila. Hallamos la direccion final de la fila

                        ld de, (NumColumna)             ; Se carga en el registro de el numero de columna en el que se quiere pintar el caracter
                        add hl, de                      ; Se suma a la fila el numero de posiciones hacia la derecha en la que se quiere pintar el caracter
                        ld (DirBaseCaracter), hl        ; Se guarda la direccion final almacenada en hl en DirBaseCaracter

                        ret                             ; Se devuelve el control a basic

; ENTORNO PINTAR CARACTER ------------------------------------------------------------------------------------------------------------------------

PaintChar:              ; Funcion que pinta el caracter almacenado en DirCaracterUsr en la direccion almacenada en DirBaseCaracter

                        ld hl,(DirBaseCaracter)         ; Se carga en el registro hl la direccion en donde se quiere imprimir el caracter
                        ld ix,(DirCaracterUsr)          ; Se carga en ix la definicion del caracter que se quiere pintar

                        ld b,8                          ; Son 8 filas que pintar

Otrasfilas              ld a, (ix)                      ; Se carga en el acumulador su definicion de memoria
                        ld (hl), a                      ; Se guarda en la direccion correspondiente

                        ld de,$100                      ; Cada fila del caracter se va sumando $100
                        add hl, de                      ; Se suma $100 para la siguiente fila del caracter
                        inc ix                          ; Se suma 1 a la direccion de memoria base de la siguiente fila

                        djnz Otrasfilas                 ; Se vuelve a la siguiente fila
                        ret                             ; Se devuelve el control a basic

; DELAY DE 20 CENTISEC --------------------------------------------------------------------------------------------------------------------------

Delay:                  ld a, (TiempoEspera)
                        ld b, a
Espera                  halt
                        djnz Espera
                        ret

; -----------------------------------------------------------------------------------------------------------------------------------------------

; Stop planting code after this. (When generating a tape file we save bytes below here)
AppLast                 equ *-1                         ; The last used byte's address

; Generate some useful debugging commands

; FIN ENTORNO CALCULAR DIRECCION DEL BYTE --------------------------------------------------------------------------------------------------------

; Setup the emulation registers, so Zeus can emulate this code correctly

Zeus_PC                 equ AppEntry                            ; Tell the emulator where to start
Zeus_SP                 equ $FF40                               ; Tell the emulator where to put the stack

; These generate some output files

                        ; Generate a SZX file
                        output_szx AppFilename+".szx",$0000,AppEntry    ; The szx file

                        ; If we want a fancy loader we need to load a loading screen
;                        import_bin AppFilename+".scr",$4000            ; Load a loading screen

                        ; Now, also generate a tzx file using the loader
                        output_tzx AppFilename+".tzx",AppFilename,"",AppFirst,AppLast-AppFirst,1,AppEntry ; A tzx file using the loader


