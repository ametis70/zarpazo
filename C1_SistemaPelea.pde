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
    cantidad = abs(ceil((posX - ancho) / 80));
    // println(cantidad); // Debugging

    pelotas = new Pelota[cantidad]; 

    // Inicialización de pelotas(máximas)
    for (int i = 0; i < pelotas.length; i++) {
      pelotas[i] = new Pelota(ancho + 100 * i + i * int(random(10, 25)), posY + alto / 2, int(random(4)));
    }

    // Cantidad de pelotas que va a haber a la vez(inicial)
    pelotasActual = pelotasInicial = cantidad;

    velocidad = 3;
    velocidadInicial = velocidad;
    accel = 1.00009;
    nuevoTurno = false;
  }

  void pelea(Nivel nivel) {
    textAlign(LEFT, TOP);

	// Se hace un clip y se dibuja un rectangulo negro transparente detrás
    imageMode(CORNER);
    clip(posX, posY, ancho, alto);
    fill(0, 0, 0, 50);
    noStroke();
    rectMode(CORNER);
    rect(posX, posY, ancho, alto);
    // Ciclo for para dibujar, mover, activar en colisión y detectar los golpes en las pelotas
    for (int i = 0; i < pelotas.length; i++) {
      pelotas[i].dibujar();
      pelotas[i].mover(nivel.jugador, this);
      pelotas[i].activar(mira);
      pelotas[i].golpear(nivel.enemigo, nivel.jugador, mira);
    }
    
    // Se dibuja la Mira
    mira.dibujar();
    noClip();
  }

  void turno(Nivel nivel) {
    // Código para los "turnos". Se ejecuta cuando la ultima pelota sale de la pantalla.
    if (pelotas[pelotas.length -1 ].posX <= (posX - 100)) {
      for (int i = 0; i < pelotas.length; i++) {
        pelotas[i].cambiarTipo();                     // Se cambia el tipo de pelota
        pelotas[i].restablecer();                     // Se reinicia el estado para que puedan ser activadas nuevamente
        pelotas[i].posX=(width + 100 * i + i * int(random(10, 25)));   // Se reinicia la posicion de las pelotas
      }

      // Si el combo es mayor a pelotasActual y pelotasActual es menor a la cantidad máxima de pelotas posible, se incrementa la cantidad de pelotas en uno.
      if (nivel.jugador.combo >= pelotasActual && pelotasActual < pelotas.length)
        pelotasActual++;

      // Si hay combo break se resetea la cantidad ed pelotas
      if ( nivel.jugador.combo < pelotasActual) 
        pelotasActual = 3;

      // Se calculan los daños 
      nivel.jugador.infligirDamage(nivel.enemigo);
      nivel.enemigo.infligirDamage(nivel.jugador);

      //if (jugador.salud <= 0) { 
      //  nivel.etapaActual = 0;
      //  nivel.peleando = false;
      //}
      //if ( enemigo.salud <= 0) { 
      //  nivel.etapaActual+=2;
      //  nivel.peleando = false;
      //}
    }
  }
}
