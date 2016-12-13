# Zarpazo 
 
![Logo](http://i.imgur.com/crCGdXB.jpg)

El club Bolsa de Gatos es el escenario de la final de un torneo de boxeo clandestino.Todo se vuelve aún más violento cuando la mafia irrumpe y lo sabotea.
¡Elegí a tu luchador y recuperá el trofeo en Zarpazo!

### Sobre el proyecto
![Stand](http://i.imgur.com/ntq7lG2.jpg)

Este es un videojuego que se realizó utilizando [Processing](https://processing.org/) y [Arduino](https://arduino.cc) para la décima muestra de fin de año de Taller de Diseño Multimedial 1 de la [Universidad Nacional de La Plata](http://www.unlp.edu.ar).

La temática de los videojuegos de este año fueron probervios, y él que fue asignado a nuestro grupo fue "Es una bolsa de gatos". 

Parte de la consigna era que los videojuegos debían poseer una interacción no convencional, que se resolvió utilizando microswitches que eran presionados por bolsas que el jugador debe golpear.

Acá se puede ver un vídeo del juego en acción: [link a YouTube](https://www.youtube.com/watch?v=CN1-HlIt3Nw).

### El Staff ([Versión en wallpaper](http://i.imgur.com/HdKqGTs.png))

![Staff](http://i.imgur.com/2hGjJP6.jpg)

* Diseño
	* Álvaro Tomás Perez Dominguez
	* Julián Ramos
	* Manuel Alcolea

* Arte
	* Gastón Rodríguez
	* Leonel Rodríguez
	* Pilar Vales

* Arquigrafía
	* Camila Navarro
	* Feliciano Aguiar
	* Matias Arias

* Programación
	* Ian Mancini
	* Santiago Reartes

### Consideraciones finales 

En caso de que se descargue el código fuente del juego, hay que descargar primero la librería Minim desde el IDE de Processing para poder compilarlo([ver imágen](http://i.imgur.com/saRb8e3.png)).

Los controles para jugar con el teclado son la A para el azul, la S para el verde y la D para el rojo.

El juego está diseñado para que solo funcione en una resolución de 1366x768. En caso de que se modficara esto, habría que cambiar muchas posisciones y tamaños absolutos.

En el PCB(o el esquemático) de KiCad, los pines del conector que van a tierra y 5V están mal conectados, por lo que hay que cambiarlos antes de imprimir una placa.

Por cuestiones de tiempo y falta de conocimientos cuando se lanzó el trabajo práctico, gran parte del código del juego está desorganizado y desopotimizado, y hay varios bugs que quedaron sin resolver, pero ahora que la muestra ya pasó, todo eso probablemente quede así.
