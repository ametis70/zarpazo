class SistemaPelea {
  float velocidad;
  float velocidadInicial;
  float accel;
  boolean nuevoTurno;

  Mira mira;          // Objeto para la mira
  Pelota[] pelotas;   // Array para almacenar pelotas

  int posX, posY, ancho, alto;

  // Variables sistema de pelea
  int pelotasActual, pelotasInicial, cantidad, multiplicador;    

  SistemaPelea(int posX, int posY, int ancho, int alto) {

    // Inicialización de barra
    mira = new Mira(width/2, posY + alto / 2, 7, 80);

    this.posX = posX;
    this.posY = posY;
    this.alto = alto;
    this.ancho = ancho;

    // La cantidade de pelotas máximas se determina por el ancho de la barra del sistema de pelea
    cantidad = abs(ceil((posX - ancho) / 70));
    // println(cantidad); // Debugging

    pelotas = new Pelota[cantidad]; 

    // Inicialización de pelotas(máximas)
    for (int i = 0; i < pelotas.length; i++) {
      pelotas[i] = new Pelota(posX + ancho + 100 * i + random(10, 45), posY + alto / 2, int(random(4)));
    }

    velocidad = 3;
    velocidadInicial = velocidad;
    accel = 1.00009;
    nuevoTurno = false;
  }

  void pelea(Nivel nivel) {
    // Se clippean las pelotas para que no salgan del cuadrado(ver nivel)
    imageMode(CORNER);
    clip(posX, posY, ancho, alto);
    // Ciclo for para dibujar, mover, activar en colisión y detectar los golpes en las pelotas
    for (int i = 0; i < pelotas.length; i++) {
      pelotas[i].dibujar();
      pelotas[i].mover(nivel.jugador);
      if (pelotas[0] != pelotas[i]) {
        if (pelotas[i - 1].activa == false)
          pelotas[i].activar(mira); // Si la pelota anterior no está activa
      } else pelotas[0].activar(mira);

      pelotas[i].golpear(nivel.enemigo, nivel.jugador, mira, nivel);
    }
    noClip();
  }

  // Funciones para volver las pelotas a la posición que deberían estar
  void reiniciar() {
    if (pelotas[0].posX <= (posX - 100)) {
      destruir(0);
    }
  }

  void destruir(int posEnArray) {
    for (int i = posEnArray; i < pelotas.length - 1; i++) {
      pelotas[i] = pelotas[i+1];
    }

    pelotas[pelotas.length-1] = null;
    agregarPelota();
  }

  void agregarPelota() {
    boolean listo = false;
    int i = 0;

    while (!listo) {
      if (i > pelotas.length-1)
        listo = true;
      else if (pelotas[i] == null) {
        if (i == 0) pelotas[i] = new Pelota(posX + ancho + 100 + random(10, 45), posY + alto / 2, int(random(4)));
        else {
          pelotas[i] = new Pelota(posX + ancho + 100 + random(10,45), posY + alto / 2, int(random(4)));
        }

        listo = true;
      }
      i++;
    }
  }
}