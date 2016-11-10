class SistemaPelea {

  float velocidad;
  float velocidadInicial;
  float accel;
  boolean nuevoTurno;

  Barra bar;                          // Objeto para la barra
  Pelota[] pelotas;   // Array para almacenar pelotas

  // Objeto para jugador y enemigo
  Enemigo enemigo;
  Jugador jugador;

  int posX, posY, ancho, alto;

  // Variables sistema de pelea
  int pelotasActual, pelotasInicial, cantidad, multiplicador;    

  SistemaPelea(int posX, int posY, int ancho, int alto) {

    // Se inicializan los objetos del jugador y el enemigo
    jugador = new Jugador(450, "Zarpazo");
    enemigo = new Enemigo(450, "Xolotl");

    barra1 = new BarraVida("zarpazo", "jugador");
    barra2 = new BarraVida("perro", "enemigo");
    barra1 = new BarraVida("zarpazo", "jugador", false);
    barra2 = new BarraVida("perro", "enemigo", true);


    // Inicialización de barra
    bar = new Barra(width/2, posY + alto / 2, 7, 80);

    this.posX = posX;
    this.posY = posY;
    this.alto = alto;
    this.ancho = ancho;

    cantidad = abs(ceil((posX - ancho) / 80));
    println(cantidad);

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

  void pelea() {
    textAlign(LEFT, TOP);

    imageMode(CORNER);
    clip(posX, posY, ancho, alto);
    fill(0, 0, 0, 50);
    rectMode(CORNER);
    rect(posX, posY, ancho, alto);
    // Ciclo for para dibujar, mover, activar en colisión y detectar los golpes en las pelotas
    for (int i = 0; i < pelotas.length; i++) {
      pelotas[i].dibujar();
      pelotas[i].mover(jugador);
      pelotas[i].activar(bar);
      pelotas[i].golpear(enemigo, jugador, bar);
    }
    // Se dibuja la barra
    bar.dibujar();
    noClip();

    //barraVidaJugador.dibujar( jugador, CORNER, color(0, 0, 0), color(0, 100, 100), 50, 25 );
    //barraVidaEnemigo.dibujar( enemigo, CORNERS, color(0, 0, 0), color(270, 100, 100), width-50, 25);
    barra1.dibujar(45, 50, 95, height-100, jugador.salud, jugador.saludMaxima);
    barra2.dibujar(width-45, 100, width-95, height-50, jugador.salud, jugador.saludMaxima);
  }

  void turno() {
    // Código para los "turnos". Se ejecuta cuando la ultima pelota sale de la pantalla.
    if (pelotas[pelotas.length -1 ].posX <= (posX - 100)) {
      for (int i = 0; i < pelotas.length; i++) {
        pelotas[i].cambiarTipo();                     // Se cambia el tipo de pelota
        pelotas[i].restablecer();                     // Se reinicia el estado para que puedan ser activadas nuevamente
        pelotas[i].posX=(width + 100 * i + i * int(random(10, 25)));   // Se reinicia la posicion de las pelotas
      }

      // Si el combo es mayor a pelotasActual y pelotasActual es menor a la cantidad máxima de pelotas posible, se incrementa la cantidad de pelotas en uno.
      if (jugador.combo >= pelotasActual && pelotasActual < pelotas.length)
        pelotasActual++;

      // Si hay combo break se resetea la cantidad ed pelotas
      if ( jugador.combo < pelotasActual) 
        pelotasActual = 3;

      // Se calculan los daños 
      jugador.infligirDamage(enemigo);
      enemigo.infligirDamage(jugador);

      if ( jugador.salud <= 0) { 
        nivel.etapaActual = 0;
        nivel.peleando = false;
      }
      if ( enemigo.salud <= 0) { 
        nivel.etapaActual+=2;
        nivel.peleando = false;
      }
    }
  }

  // Teto del la interfaz

  void textoInterfaz() { 
    textFont(fuenteNeon);
    textSize(40);
    fill(0, 0, 100);
    textAlign(LEFT, TOP);
    if ( jugador.combo != 0) {
      text("x" + jugador.combo, posX, posY + alto + 25);
    }
    textAlign(RIGHT, TOP);
    if ( enemigo.combo != 0) {
      text("x" + enemigo.combo, posX + ancho, posY + alto + 25);
    }
    textAlign(CENTER, CENTER);
    if (resultado != null) {
      if (resultado == "¡Perfecto!")
        fill(161, 100, 100);
      if (resultado == "¡Excelente!")
        fill(90, 100, 100);
      if (resultado == "¡Bien!")
        fill(55, 100, 50);
      if (resultado == "Puede ser mejor...")
        fill(28, 100, 100);
      if (resultado == "¡Bolsa equivocada!")
        fill(28, 100, 100);
      if (resultado == "¡No golpeaste ninguna bolsa!")
        fill(28, 100, 100);

      text(resultado, width/2, 50);
    }
  }

  // Onscreen debugging

  void debugging() {  
    textFont(fuenteDebugging);

    if (enemigo.salud < 0) {
      fill(90, 100, 100);
      inicializarFuentes();
      text("GANASTE", width / 2, 100);
      nivel.etapaActual+=2;
      nivel.peleando = false;
    }

    if (jugador.salud < 0) {
      pushStyle();
      fill(0, 100, 100);
      text("PERDISTE", width / 2, 100);
      nivel.etapaActual = 0;
      nivel.peleando = false;
      popStyle();
    }

    // Texto de controles
    fill(0 * 90, 100, 100);
    text("A - Rojo", 25, 100);
    fill(1 * 90, 100, 100);
    text("S - Verde", 25, 130);
    fill(2 * 90, 100, 100);
    text("D - Azul", 25, 160);
    fill(3 * 90, 100, 100);
    text("F - Violeta", 25, 190);

    // Texto informativo
    fill(0, 0, 100);
    text("Ultimo Golpe: " + resultado, 25, height-(height/3));
    text("Daño infligido en el ultimo turno: " + jugador.damage +  " - Daño recibido en el ultimo turno: " + enemigo.damage, 25, height-(height/3)+30);
    text("Combo jugador: " + jugador.combo, 25, height-(height/3)+60);
    text("Combo enemigo: " + enemigo.combo, 25, height-(height/3)+90);
    text("HP Jugador: " + jugador.salud, 25, height-(height/3)+120);  
    text("HP Enemigo: " + enemigo.salud, 25, height-(height/3)+150);
  }
}