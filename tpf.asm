.data
tablero: .asciz "___________________________________________________|\n                                                   |\n    *** EL JUEGO DEL AHORCADO - Grupo 6 ***        |\n___________________________________________________|\n                                                   |\n                                                   |\n          +------------+                           |\n          |            |                           |\n          |                                        |\n          |                                        |\n          |                                        |\n          |                                        |\n          |                                        |\n          |                                        |\n          |                                        |\n +-------------------------------------------+     |\n |                                           |     |\n |   t                                       |     |\n |                                           |     |\n +-------------------------------------------+     |\n___________________________________________________|\n                                                   |\n     vidas:7                                       |\n___________________________________________________|\n"


longitudTablero = . - tablero
cls: .asciz "\x1b[H\x1b[2J" /*una manera de borrar la pantalla usando ansi escape codes*/
lencls = .-cls
nombre: .asciz "Ingrese su nombre:\n"
longitud = .-nombre
letraMsj: .asciz "Ingrese una letra:\n"
longitudLetraMsj = .-letraMsj
letraIngresada: .asciz "  "
archivoRanking: .asciz "/home/orga2021/occ1g6/tpf/ranking.txt"
archivoPalabras: .asciz "/home/orga2021/occ1g6/tpf/palabras.txt"
prompt: .asciz "Ingrese las palabras con las que los usuarios jugaran al ahorcado: \n"
promptend= .-prompt
victoriaMensaje: .asciz "O~~      O~~         O~~~~          O~~     O~~          O~~        O~~     O~~     O~~~     O~~\n O~~    O~~        O~~    O~~       O~~     O~~          O~~        O~~     O~~     O~ O~~   O~~\n  O~~ O~~        O~~        O~~     O~~     O~~          O~~   O~   O~~     O~~     O~~ O~~  O~~\n    O~~          O~~        O~~     O~~     O~~          O~~  O~~   O~~     O~~     O~~  O~~ O~~\n    O~~          O~~        O~~     O~~     O~~          O~~ O~ O~~ O~~     O~~     O~~   O~ O~~\n    O~~            O~~     O~~      O~~     O~~          O~ O~    O~~~~     O~~     O~~    O~ ~~\n    O~~              O~~~~            O~~~~~             O~~        O~~     O~~     O~~      O~~\n"
victoriaMensajeLen = . - victoriaMensaje
palabraSorteada: .asciz "                    "
palabraSorteadaLong = .-palabraSorteada
numeroMensaje: .asciz "Ingrese un número entre 0 y 9. \n"
numeroMensajeLen = . - numeroMensaje
numeroIngresadoInt: .int 0
numeroIngresadoASCII: .asciz "   "
disparoMensaje: .asciz "Te quedaste sin vidas pero aún podes salvar al ahorcado disparando a la soga.\n"
disparoMensajeLen = . - disparoMensaje
xMensaje: .asciz "Ingrese una coordenada X.\n"
xMensajeLen = . - xMensaje
xIngresadoInt: .int 0
xIngresadoASCII: .asciz "   "
yMensaje: .asciz "Ingrese una coordenada Y.\n"
yMensajeLen = . - yMensaje
yIngresadoInt: .int 0
yIngresadoASCII: .asciz "   "
ultimosJugadores: .asciz "Últimos jugadores:\n"
ultimosJugadoresLen = . - ultimosJugadores
acertadoMensaje: .asciz "¡Felicidades! ¡Acertaste el disparo!\n"
acertadoMensajeLen = . - acertadoMensaje
gameOverMensaje: .asciz "   O~~~~         O~       O~~       O~~O~~~~~~~~         O~~~~     O~~         O~~O~~~~~~~~O~~~~~~~    \n O~    O~~      O~ ~~     O~ O~~   O~~~O~~             O~~    O~~   O~~       O~~ O~~      O~~    O~~  \nO~~            O~  O~~    O~~ O~~ O O~~O~~           O~~        O~~  O~~     O~~  O~~      O~~    O~~  \nO~~           O~~   O~~   O~~  O~~  O~~O~~~~~~       O~~        O~~   O~~   O~~   O~~~~~~  O~ O~~      \nO~~   O~~~~  O~~~~~~ O~~  O~~   O~  O~~O~~           O~~        O~~    O~~ O~~    O~~      O~~  O~~    \n O~~    O~  O~~       O~~ O~~       O~~O~~             O~~     O~~      O~~~~     O~~      O~~    O~~  \n  O~~~~~   O~~         O~~O~~       O~~O~~~~~~~~         O~~~~           O~~      O~~~~~~~~O~~      O~~\n"
gameOverLen = . - gameOverMensaje
reinicioMensaje: .asciz "Presione ENTER para jugar otra vez o ESPACIO seguido de ENTER para salir. \n"
reinicioMensajeLen = . - reinicioMensaje
enterOEspacio: .space 100
buffer: .space 100
bufferNombre: .space 100 
bufferPalabras: .space 100 /*es conveniente reservar bastante*/


.text

pedirNombre:
.fnstart
    mov r7, #4
    ldr r1, =nombre
    mov r2, #longitud
    mov r0, #1
    swi 0
    bx lr
.fnend

pedirLetra:
.fnstart
    mov r7, #4
    ldr r1, =letraMsj
    mov r2, #longitudLetraMsj
    mov r0, #1
    swi 0
    bx lr
.fnend

ingresarLetra:
.fnstart
    mov r7, #3 /* syscall 3 read */
    mov r0, #0 /* stdin (keyboard) */
    ldr r1, =letraIngresada /* address of buffer */
    mov r2, #2 /* maximum length of input */
    swi 0
    /* El valor de retorno (n�mero de bytes le�dos) se almacena en r0 */
    bx lr
.fnend

pedirNumero:
.fnstart
    mov r7, #4
    ldr r1, =numeroMensaje
    mov r2, #numeroMensajeLen
    mov r0, #1
    swi 0
    bx lr
.fnend

ingresarNumero:
.fnstart
    mov r7, #3 /* syscall 3 read */
    mov r0, #0 /* stdin (keyboard) */
    ldr r1, =numeroIngresadoASCII /* address of buffer */
    mov r2, #2 /* maximum length of input */
    swi 0
    /* El valor de retorno (n�mero de bytes le�dos) se almacena en r0 */
    bx lr
.fnend

ingresarNombre:
.fnstart
    mov r7, #3 /* syscall 3 read */
    mov r0, #0 /* stdin (keyboard) */
    ldr r1, =bufferNombre /* address of buffer */
    mov r2, #20 /* maximum length of input */
    swi 0
    /* El valor de retorno (n�mero de bytes le�dos) se almacena en r0 */
    bx lr
.fnend

abrirRanking:
.fnstart
    /* OPEN (CREATE) FILE */
    mov r7, #5  /* syscall 5 open (create) */
    ldr r0, =archivoRanking
    mov r1, #0x42
    mov r2, #384  /* permisos 600 en octal */
    swi 0
    /* El valor de retorno (file descriptor) se almacena en r0 */
    bx lr
.fnend

abrirPalabras:
.fnstart
    /* OPEN (CREATE) FILE */
    mov r7, #5  /* syscall 5 open (create) */
    ldr r0, =archivoPalabras
    mov r1, #0x42
    mov r2, #384  /* permisos 600 en octal */
    swi 0
    /* El valor de retorno (file descriptor) se almacena en r0 */
    bx lr
.fnend

agregarPuntaje:
    .fnstart

    ldr r0, =tablero
    ldrb r0, [r0, #1177]
    ldr r1, =bufferNombre
    mov r3, #' '

    buscarEnter:
    ldrb r2, [r1]
    cmp r2, #'\n'
    beq reemplazarEnter //reemplaza el \n por espacio y agrega el puntaje
    add r1, #1
    b buscarEnter

    reemplazarEnter:
    strb r3, [r1]

    add r1, #1
    strb r0, [r1] // agrega el puntaje (la cant de vidas)
    
    mov r3, #'\n' //coloca un enter luego del puntaje
    add r1, #1
    strb r3, [r1]

    bx lr

    .fnend

grabarRanking:
.fnstart
    push {lr}
    bl agregarPuntaje
    bl abrirRanking
    mov r4, r0 // guardamos el file descriptor en r4

    ldr r1, =buffer
    ldr r0, =bufferNombre

    mov r3, #3 //cant de enters por defecto
    recorrerRanking:
    ldrb r2, [r1]
    cmp r2, #0
    beq escribirAlFinal
    add r1, #1
    b recorrerRanking

    escribirAlFinal:
    ldrb r2, [r1]
    ldrb r3, [r0]
    cmp r3, #0
    beq grabar
    strb r3, [r1]
    add r0, #1
    add r1, #1
    b escribirAlFinal

    grabar:

    /* Escribo en el archivo abierto */
    mov r7, #4 /* syscall 4 write */
    mov r0, r4 /* file descriptor */
    ldr r1, =buffer /* address of buffer */
    mov r2, #90 /* cantidad de bytes le�dos */
    swi 0

    //cerrarRanking
    mov r0, r4		// pongo en r0 descriptor
    mov r7, #6		// Cierra archivo abierto
    swi 0

    pop {lr}
    bx lr
.fnend

sortearPalabra:
.fnstart

    ldr r3, =bufferPalabras
    ldr r4, =palabraSorteada

    mov r9, #0 //contador de enters
    mov r6, #0 //contador de caracteres de la palabra sorteada

    ldr r8, =numeroIngresadoASCII //numero usado para el sorteo
    ldr r2, =numeroIngresadoInt
    ldrb r8, [r8]
    sub r8, #'0'

    str r8, [r2]

    recorrerPalabras:

    cmp r9, r8 //si el contador de enter es igual al numero ingresado
    beq guardarPalabraSorteada

    ldrb r5,[r3] //r5 es el caracter actual
    add r3, #1 //le sumo 1 a la direccion de memoria de palabras
    cmp r5, #'\n'
    beq contarEnter

    b recorrerPalabras
    contarEnter:
    add r9, #1
    b recorrerPalabras

    guardarPalabraSorteada:
    ldrb r5,[r3] //r5 es el caracter actual
    cmp r5, #'\n'
    beq rellenar

    add r3, #1 //le sumo 1 a la direccion de memoria de palabras
    strb r5, [r4]
    add r4, #1 //le sumo 1 a la direccion de memoria de palabraSorteada
    add r6, #1
    b guardarPalabraSorteada

    cantMaxima:
    mov r8, #10
    b recorrerPalabras

    rellenar:
    add r4, #1
    ldrb r5,[r4] //r5 es el caracter actual
    cmp r5, #0
    beq salirSortear

    mov r5, #' '
    strb r5, [r4]
    b rellenar


    salirSortear:
    bx lr

.fnend

dibujarTablero:
.fnstart

    mov r7, #4
    ldr r1, =tablero
    mov r2, #longitudTablero
    mov r0, #1
    swi 0

    bx lr
.fnend

clearScreen:
    .fnstart
    mov r7, #4
    ldr r1, =cls
    mov r2, #lencls
    mov r0, #1
    swi 0

    bx lr 
    .fnend

dibujarGuiones:
    .fnstart
    ldr r0, =tablero
    mov r3, #906
    add r0, r3 //donde queremos empezar a escribir los guiones es el caracter 907
    
    dibujarUnGuion:
    cmp r6, #0
    beq salirDibujarGuiones

    mov r2, #'_'
    strb r2, [r0]
    add r0, #2 //sumamos 2 a la direccion de memoria para dibujar un guion y dejar un espacio en el medio
    sub r6, #1
    b dibujarUnGuion
    
    salirDibujarGuiones:
    mov r7, #4
    ldr r1, =tablero
    mov r2, #longitudTablero
    mov r0, #1
    swi 0

    bx lr 
    .fnend

verificar:
    .fnstart
    push {lr}

    bl clearScreen

    ldr r3, =letraIngresada
    ldrb r3, [r3]
    ldr r1, =palabraSorteada
    ldr r0, =tablero
    mov r2, #906
    add r0, r2

    mov r5, #0 //si r5=0 al final de la verificacion la letra es incorrecta


    //chequear si ingreso una letra u otro caracter
    verificarLetra:
    ldrb r4, [r1]
    cmp r4, #' '
    beq finPalabra

    cmp r4, r3 //si el primer caracter de la palabra sorteada coincide con la letra ingresada
    beq reemplazarGuion

    add r0, #2
    add r1, #1
    b verificarLetra


    reemplazarGuion:
    strb r3, [r0]//ok
    add r0, #2
    add r1, #1
    add r5, #1
    b verificarLetra

    finPalabra:
    cmp r5, #0
    beq letraIncorrecta
    b salirVerificar

    letraIncorrecta: //restar vida y dibujar ahorcado
    bl restarVida
    bl dibujarAhorcado

    salirVerificar:

    bl dibujarTablero

    pop {lr} 

    bx lr 
    .fnend

dibujarAhorcado:
    .fnstart
    push {r0,r1,lr}
    ldr r0,=tablero            
	ldrb r1 ,[r0,#1177]		// caracter que indica el numero de vidas

	cmp r1,#54 //caracter 6 en ascii
	beq cabeza
	
	cmp r1,#53
	beq brazoIzq
	
	cmp r1,#52
	beq pecho
	
	cmp r1,#51
	beq brazoDer
	
	cmp r1,#50
	beq abdomen
	
	cmp r1,#49
	beq piernaIzq
	
	cmp r1,#48
	beq piernaDer

    cmp r1, #48
    blt salirADisparo

    salirADisparo:
    mov r1, #48 //setea vidas en cero para que no muestre '/'
    strb r1, [r0,#1177]
    b disparo

    cabeza:
    mov r1, #'O'
    strb r1,[r0,#447]	
    b salirDibujarAhorcado

    brazoIzq:
    mov r1, #'/'
    strb r1,[r0,#499]	
    b salirDibujarAhorcado

    pecho:
    mov r1, #'|'
    strb r1,[r0,#500]	
    b salirDibujarAhorcado

    brazoDer:
    mov r1, #0x5c // por alguna razon al ingresar '\' muestra otro caracter
    strb r1,[r0,#501]	
    b salirDibujarAhorcado

    abdomen:
    mov r1, #'|'
    strb r1,[r0,#553]	
    b salirDibujarAhorcado

    piernaIzq:
    mov r1, #'/'
    strb r1,[r0,#605]	
    b salirDibujarAhorcado

    piernaDer:
    mov r1, #0x5c
    strb r1,[r0,#607]	
    b salirDibujarAhorcado

    salirDibujarAhorcado:
    pop {r0,r1,lr}
    bx lr

    .fnend

restarVida:
    .fnstart
    push {r0, r1, r2, lr}
    ldr r0, =tablero
    mov r1, #1177
    add r0, r1
    ldrb r2, [r0]
    sub r2, #1
    strb r2, [r0]
    pop {r0, r1, r2, lr}
    bx lr
    .fnend

informarResultado:
    .fnstart
    ldr r0, =tablero
    mov r1, #906
    add r0, r1
    mov r3, r10
    mov r4, #0 //contador de ciclos
    recorrerGuiones:
    add r4, #1
    ldrb r2, [r0]
    cmp r2, #'_'
    beq salirInformarResultado

    cmp r3, r4 //si la cantidad de letras de la palabra sorteada y la cant de lugares sin guiones son iguales, ganaste
    beq ganaste

    add r0, #2
    b recorrerGuiones

    salirInformarResultado:
    bx lr
    .fnend

mensajeDisparo:
    .fnstart
    mov r7, #4
    ldr r1, =disparoMensaje
    mov r2, #disparoMensajeLen
    mov r0, #1
    swi 0
    bx lr
    .fnend

pedirCoordenadaX:
    .fnstart
    mov r7, #4
    ldr r1, =xMensaje
    mov r2, #xMensajeLen
    mov r0, #1
    swi 0
    bx lr
    .fnend

pedirCoordenadaY:
    .fnstart
    mov r7, #4
    ldr r1, =yMensaje
    mov r2, #yMensajeLen
    mov r0, #1
    swi 0
    bx lr
    .fnend

ingresarCoordenadaX:
    .fnstart
    mov r7, #3 /* syscall 3 read */
    mov r0, #0 /* stdin (keyboard) */
    ldr r1, =xIngresadoASCII /* address of buffer */
    mov r2, #3 /* maximum length of input */
    swi 0
    /* El valor de retorno (n�mero de bytes le�dos) se almacena en r0 */

    //Conversion de ascii a número

    ldr r2, =xIngresadoASCII
    ldr r3, =xIngresadoInt
    add r4, r2, #1 
    ldrb r2, [r2]
    ldrb r4, [r4]
    mov r6, #10

    cmp r4, #'\n' //si hay un segundo caracter convierte los dos digitos
    beq convertirUnDigitoX

    convertirDosDigitosX:
    sub r2, #'0'
    mul r5, r2, r6

    sub r4, #'0'
    add r5, r4
    str r5, [r3]
    b salirX

    convertirUnDigitoX:
    sub r2, #'0'
    str r2, [r3]

    salirX:
    bx lr
    .fnend

ingresarCoordenadaY:
    .fnstart
    mov r7, #3 /* syscall 3 read */
    mov r0, #0 /* stdin (keyboard) */
    ldr r1, =yIngresadoASCII /* address of buffer */
    mov r2, #3 /* maximum length of input */
    swi 0
    /* El valor de retorno (n�mero de bytes le�dos) se almacena en r0 */

    //Conversion de ascii a número

    ldr r2, =yIngresadoASCII
    ldr r3, =yIngresadoInt
    add r4, r2, #1 
    ldrb r2, [r2]
    ldrb r4, [r4]
    mov r6, #10

    cmp r4, #'\n' //si hay un segundo caracter convierte los dos digitos
    beq convertirUnDigitoY

    convertirDosDigitosY:
    sub r2, #'0'
    mul r5, r2, r6

    sub r4, #'0'
    add r5, r4
    str r5, [r3]
    b salirY

    convertirUnDigitoY:
    sub r2, #'0'
    str r2, [r3]

    salirY:
    bx lr
    .fnend

mostrarDisparo:
    .fnstart
    ldr r0, = tablero
    ldr r1, =xIngresadoInt
    ldr r1, [r1]
    ldr r2, =yIngresadoInt
    ldr r2, [r2]
    mov r3, #'x' //el caracter dibujado que representa el impacto del disparo
    mov r4, #53 //cantidad de elementos por fila

    mul r5, r4, r2 //multiplica fila * cant de elementos
    add r0, r5 //desplazo el puntero esa cantidad de caracteres

    add r0, r1 //desplazo la cantidad de columnas correspondientes
    strb r3, [r0]

    mov r7, #4
    ldr r1, =tablero
    mov r2, #longitudTablero
    mov r0, #1
    swi 0

    bx lr
    .fnend

pantallaGanaste:
    .fnstart
    push {lr}

    bl clearScreen

    mov r7, #4
    ldr r1, =victoriaMensaje
    mov r2, #victoriaMensajeLen
    mov r0, #1
    swi 0

    pop {lr}
    bx lr
    .fnend

leerRanking:
    .fnstart

    mov r7, #3 /* syscall 3 read */
    ldr r1, =buffer /* address of buffer */
    mov r2, #100 /* maximum length of input */
    swi 0
    /* El valor de retorno (n�mero de bytes le�dos) se almacena en r0 */
    bx lr
    .fnend

leerPalabras:
    .fnstart

    mov r7, #3 /* syscall 3 read */
    ldr r1, =bufferPalabras /* address of buffer */
    mov r2, #100 /* maximum length of input */
    swi 0
    /* El valor de retorno (n�mero de bytes le�dos) se almacena en r0 */

    cerrarPalabras:
    mov r0, r5		// pongo en r0 descriptor
    mov r7, #6		// Cierra archivo abierto
    swi 0
    bx lr
    .fnend

mostrarRanking:
    .fnstart
    mov r7, #4
    ldr r1, =buffer
    mov r2, #100
    mov r0, #1
    swi 0

    //cerrarRanking
    mov r0, r4		// pongo en r0 descriptor
    mov r7, #6		// Cierra archivo abierto
    swi 0
    bx lr
    .fnend

mostrarUltimosJugadores:
    .fnstart
    mov r7, #4
    ldr r1, =ultimosJugadores
    mov r2, #ultimosJugadoresLen
    mov r0, #1
    swi 0
    bx lr
    .fnend

acertaste:
    .fnstart
    push {lr}

    mov r7, #4
    ldr r1, =acertadoMensaje
    mov r2, #acertadoMensajeLen
    mov r0, #1
    swi 0

    pop {lr}
    bx lr
    .fnend

gameOver:
    .fnstart
    push {lr}

    mov r7, #4
    ldr r1, =gameOverMensaje
    mov r2, #gameOverLen
    mov r0, #1
    swi 0

    pop {lr}
    bx lr
    .fnend

jugarDeNuevo:
    .fnstart
    mov r7, #4
    ldr r1, =reinicioMensaje
    mov r2, #reinicioMensajeLen
    mov r0, #1
    swi 0

    mov r7, #3 /* syscall 3 read */
    mov r0, #0 /* stdin (keyboard) */
    ldr r1, =enterOEspacio /* address of buffer */
    mov r2, #1 /* maximum length of input */
    swi 0

    bx lr
    .fnend

verificarDisparo:
    .fnstart
    ldr r0, =tablero
    ldrb r1, [r0, #394]
    cmp r1, #'x'
    beq disparoAcertado
    b perdiste
    bx lr
    .fnend

verificarReinicio:
    .fnstart
    ldr r1, =enterOEspacio
    ldrb r1, [r1]
    cmp r1, #'\n'
    beq reinicio
    cmp r1, #' '
    beq fin
    b verificarReinicio
    .fnend

resetearTablero:
    .fnstart
    ldr r0, =tablero
    ldr r4, =palabraSorteada

    mov r1, #'|'
    strb r1, [r0, #394] //borramos el disparo de la soga si es que acertó

    mov r1, #' '
    strb r1, [r0, #447] //borramos el dibujo del ahorcado
    strb r1, [r0, #499]
    strb r1, [r0, #500]
    strb r1, [r0, #501]
    strb r1, [r0, #553]
    strb r1, [r0, #605]
    strb r1, [r0, #607]

    //borra letras adivinadas del juego anterior
    mov r2, #20 //cant de letras a borrar
    mov r3, #906
    borrarLetras: 
    strb r1, [r0, r3]
    add r3, #2
    sub r2, #1
    cmp r2, #0
    bne borrarLetras

    mov r1, #'7' //reseteamos vidas
    strb r1, [r0, #1177]

    b inicioJuego
    
    .fnend

.global main
main:
    inicioJuego:
        bl abrirRanking

        mov r4, r0 // guardamos el file descriptor en r4

        bl leerRanking
        bl clearScreen
        bl mostrarUltimosJugadores
        bl mostrarRanking

        bl pedirNombre
        bl ingresarNombre

        bl abrirPalabras
        mov r5, r0 // guardamos el file descriptor en r4
        bl leerPalabras

        mov r5, r0 // guarda cantidad de bytes le�dos en r5

        bl pedirNumero
        bl ingresarNumero
        bl sortearPalabra

        mov r10, r6 //guardo la cantidad de caracteres de la palabra sorteada en r10

        bl dibujarGuiones

    cicloJuego:

        bl pedirLetra
        bl ingresarLetra
        bl verificar
        bl informarResultado

        b cicloJuego
    
    ganaste:
        bl pantallaGanaste
        bl grabarRanking
        bl jugarDeNuevo
        bl verificarReinicio

    disparo:
        bl mensajeDisparo
        bl pedirCoordenadaX
        bl ingresarCoordenadaX
        bl pedirCoordenadaY
        bl ingresarCoordenadaY
        bl mostrarDisparo //las coordenadas correctas son X=23,Y=7
        bl verificarDisparo

    disparoAcertado:
        bl acertaste
        bl grabarRanking
        bl jugarDeNuevo
        bl verificarReinicio

    perdiste:
        bl gameOver
        bl grabarRanking
        bl jugarDeNuevo
        bl verificarReinicio

    reinicio:
        bl resetearTablero


fin:
    mov r7, #1
    swi 0
