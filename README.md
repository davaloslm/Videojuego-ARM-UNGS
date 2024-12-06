# Videojuego _Ahorcado_

![image](https://github.com/user-attachments/assets/2365424f-f985-4d5c-ba23-38857a584ec1)


En este trabajo se van a desarrollar y poner en práctica los conceptos de arquitectura ARM que se ven durante la segunda parte de la materia después del primer parcial. En particular se presta atención a los siguientes conceptos:
- Datos almacenados en registros, pila, memoria
- Modos de direccionamiento
- Llamada a procedimientos del usuario e interrupciones del sistema
Estos puntos se ponen en práctica en el contexto de un juego de consola o terminal. Este contexto también permitirá implementar algunos conceptos vistos durante la primera parte de la materia, por ejemplo:
- Codificación de caracteres ASCII
- Conversión entre bases Decimal -> Binario, Binario -> Decimal
- Operaciones en Complemento A2

## 📋Consigna

**1ra Parte: El Ahorcado**

En esta parte se pide implementar la lógica básica del juego del ahorcado, que es la siguiente: Implementar el juego para varias personas. Al comienzo del juego el programa solicita por teclado el nombre del jugador y luego muestra el ranking de jugadores. Este ranking de los últimos tres jugadores está grabado en un archivo llamado ranking.txt.
Las posibles palabras para adivinar están guardadas en un archivo palabras.txt. El programa debe elegir a azar la palabra a adivinar en cada jugada, se elige una distinta.Se van registrando los intentos realizados. Cada error agrega una parte del dibujo del ahorcado. Para actualizar la parte gráfica del juego contamos con una matriz donde se va dibujando el ahorcado, se informa el número de intentos restantes y si el juego terminó o no.

**2da Parte: La Puntería**

En caso de perder (el ahorcado quedó completo) puede salvar al ahorcado con su buena puntería! Esta parte consiste en ofrecer al jugador la posibilidad de hacer un disparo y cortar la cuerda del ahorcado: El jugador debe ingresar las coordenadas (x, y) de su disparo donde x e y indican la fila y la columna donde quiere el usuario que impacte su disparo. Si la coordenada ingresada coincide con la coordenada de la cuerda que sostiene el cuello del muñequito entonces ganó.

## 📋Subrutinas

Para lograr el desarrollo del juego, hemos implementado diferentes subrutinas:
1. pedirNombre: Muestra el mensaje “Ingrese su nombre:” usando la syscall 4.
2. pedirLetra: Muestra el mensaje “Ingrese una letra:” usando la syscall 4.
3. pedirNumero: Muestra el mensaje “Ingrese un número entre 0 y 9:” usando la syscall 4.
4. ingresarLetra: Lee una letra del teclado y la almacena en letraIngresada, usando la syscall 3.
5. ingresarNombre: Lee el nombre del usuario del teclado, usando la syscall read 3, y lo almacena en bufferNombre.
6. ingresarNumero: Lee el número que el usuario ingresa por teclado, usando la syscall read 3, y lo almacena en numeroIngresadoASCII.
7. abrirRanking: Abre el archivo ranking.txt usando la syscall 5.
8. abrirPalabras: Abre el archivo palabras.txt usando la syscall 5.
9. agregarPuntaje: Toma del tablero el carácter que indica la cantidad de vidas, y posteriormente las agrega al nombre del jugador.
10. grabarRanking: Recorre el ranking de los jugadores, guardado en buffer, y, posteriormente, escribe el nombre del último jugador con su correspondiente puntaje al final del buffer. Por último, escribe el contenido del buffer en el archivo ranking.txt.
11. sortearPalabra: Selecciona una palabra de bufferPalabras basada en un número del 0 al 9 ingresado por el usuario.
12. dibujarTablero: Muestra el tablero del juego usando la syscall write.
13. clearScreen: Limpia la pantalla usando la syscall write con códigos de escape ANSI.
14. dibujarGuiones: Dibuja una cantidad de guiones en el tablero igual a la cantidad de letras de la palabra sorteada.
15. Verificar: Verifica si la letra ingresada coincide con cada que cada una de las letras de la palabra sorteada y actualiza el tablero.
16. dibujarAhorcado: Dibuja las partes del ahorcado según el número de vidas restantes.
17. restarVida: Reduce el número de vidas en 1, en el caso de que el jugador no acierte la letra.
18. informarResultado: Verifica si el jugador ha ganado el juego o si quedan guiones en el tablero.
19. mensajeDisparo: Imprime el mensaje que explica que es posible ingresar coordenadas de un disparo para salvar al ahorcado.
20. pedirCoordenadax y pedirCoordenadaY: Imprime el mensaje para ingresar la coordenada X y para ingresar la coordenada Y.
21. ingresarCoordenadaX e ingresarCoordenadaY: Lee la coordenada X e Y del teclado y la convierte de ASCII a entero.
22. mostrarDisparo: Toma el tablero como una matriz y realiza el cálculo para mostrar el disparo en el tablero.
23. pantallaGanaste: Muestra la pantalla de victoria.
24. leerRanking: Lee el contenido del archivo de ranking y lo guarda en un buffer.
25. leerPalabras: Lee el contenido del archivo de palabras y lo guarda en bufferPalabras.
26. mostrarRanking: Muestra el contenido del buffer de ranking, es decir, el listado de jugadores.
27. mostrarUltimosJugadores: Imprime el mensaje "Últimos jugadores:".
28. acertaste: Imprime el mensaje de acierto del disparo.
29. gameOver: Imprime pantalla de Game Over.
30. jugarDeNuevo: Imprime el mensaje para jugar de nuevo, se indica que en caso de querer seguir jugando debe ingresar enter, y en caso de querer terminar el juego debe ingresar espacio.
31. verificarReinicio: Verifica si el usuario quiere reiniciar el juego o salir.
32. verificarDisparo: Verifica si el disparo ha acertado, es decir, si se dibuja una x sobre la soga que sostiene al ahorcado.
33. resetearTablero: Resetea el tablero a su estado inicial. En el caso de que se juegue por segunda vez, se reemplazan por espacios los caracteres que dibujan al ahorcado, los caracteres de los guiones y las palabras acertadas anteriormente. Las vidas se restablecen a 7.


## 💻☕Equipo de desarrollo

|Nombre|Contacto|
|----|----|
|  Bermejo, Lucía | [GitHub](https://github.com/LuBermejo) | 
|  Dávalos, Leonardo | [GitHub](https://github.com/davaloslm), [LinkedIn](https://linkedin.com/in/leonardo-davalos) | 


