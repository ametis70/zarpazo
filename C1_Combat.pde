class SistemaPelea {

  // Datos
  Pelota[] pelotas;   // Array para almacenar pelotas

  int pelotasActual, pelotasInicial, cantidad, multiplicador;
  int posX, posY, ancho, alto;
  float velocidad;
  
  // Se crea el objeto para pasar por valor al nivel y poder acceder a los personajes y los elementos de la interfaz
  Nivel nivel;

  SistemaPelea(Nivel nivel, int posX, int posY, int ancho, int alto) {
    
    this.nivel = nivel;

    // Inicialización de barra
    this.posX = posX;
    this.posY = posY;
    this.alto = alto;
    this.ancho = ancho;

    // La cantidad de pelotas máximas se determina por el ancho de la barra del sistema de pelea
    cantidad = abs(ceil((posX - ancho) / 70));
    // println(cantidad); // Debugging

    pelotas = new Pelota[cantidad]; 

    // Inicialización de pelotas(máximas)
    for (int i = 0; i < pelotas.length; i++) {
      if (i == 0)
        //pelotas[i] = new Pelota(posX + ancho + 100 * i + random(10, 45), posY + alto / 2, int(random(3)));
        pelotas[i] = new Pelota(posX + ancho + 100, posY + alto / 2, nivel);
      else
        pelotas[i] = new Pelota(pelotas[i - 1].posX + 100 + random(50), posY + alto / 2, nivel);
    }

    velocidad = 3;
  }

  void pelea() {
    // Se clippean las pelotas para que no salgan del cuadrado(ver nivel)
    imageMode(CORNER);
    clip(posX, posY, ancho, alto);
    // Ciclo for para dibujar, mover, activar en colisión y detectar los golpes en las pelotas
    for (int i = 0; i < pelotas.length; i++) {
      pelotas[i].dibujar();
      pelotas[i].mover(nivel.jugador);
      pelotas[i].activar(); // Si la pelota anterior no está activa
      pelotas[i].golpear(nivel.enemigo, nivel.jugador, nivel);
    }
    noClip();
    // Este for solo se encarga de dibujar las particulas( que quedan fuera del clip y se superponen a las siguientes pelotas en el array)
    for (int i = 0; i < pelotas.length; i++) {
      if (pelotas[i].golpeada)
        if (pelotas[i].bien())
          pelotas[i].sp.dibujar();
    }
  }

  // Funciones para volver crear una nueva pelota cuando estas se vayan fuera de la barra
  void reiniciar() {
    if (pelotas[0].posX <= (posX - 100)) {
      destruir(0);
    }
  }

  void destruir(int posEnArray) {
    // Se mueven todas las pelotas una posición a la derecha en el arreglo
    for (int i = posEnArray; i < pelotas.length - 1; i++) {
      pelotas[i] = pelotas[i+1];
    }

    // Se desutruye la ultima en el arreglo, y se crea una nueva pelota en esta posición
    pelotas[pelotas.length-1] = null;
    agregarPelota();
  }

  void agregarPelota() {
    for (int i = 0; i < pelotas.length; i++) {
      if (pelotas[i] == null) {
        if (i == 0) // Si la pelota, es la primera, esta se construye en base a la posición de la ultima pelota en el arreglo
          pelotas[i] = new Pelota(pelotas[pelotas.length - 1].posX + 100 + random(50), posY + alto / 2, nivel);
        else        // Si la pelota no es la primera, se construye en base a la anterior en el arreglo
        pelotas[i] = new Pelota(pelotas[i - 1].posX + 100 + random(50), posY + alto / 2, nivel);
      }
    }
  }
}