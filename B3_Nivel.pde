class Nivel {
  // Objeto para el sistema de pelea, enemigo, jugador y sus respectivas barras de vida
  SistemaPelea combat;
  Enemigo enemigo;
  Jugador jugador;
  BarraVida barra1, barra2;

  // Imagen de fondo para el nivel
  PImage background;

  // Constructor
  Nivel(String background, String gato, int gatoHP, String perro, int perroHP) {
    combat = new SistemaPelea(185, 80, 999, 110);

    jugador = new Jugador(gatoHP, gato);
    enemigo = new Enemigo(perroHP, perro, 500, 500);

    barra1 = new BarraVida("zarpazo", "jugador");
    barra2 = new BarraVida("perro", "enemigo");
    barra1 = new BarraVida("zarpazo", "jugador", false);
    barra2 = new BarraVida("perro", "enemigo", true);

    this.background = loadImage(background);
  }

  void dibujar() {
    background.resize(displayWidth, displayHeight);
    imageMode(CORNER);
    image(background, 0, 0);

    enemigo.dibujar();

    combat.pelea(this);
    combat.turno(this);
    combat.preparacion();
    //combat.debugging();
    textoInterfaz();


    barra1.dibujar(45, 50, 95, height-100, jugador.salud, jugador.saludMaxima);
    barra2.dibujar(width-45, 100, width-95, height-50, jugador.salud, jugador.saludMaxima);
    //barraVidaJugador.dibujar( jugador, CORNER, color(0, 0, 0), color(0, 100, 100), 50, 25 );
    //barraVidaEnemigo.dibujar( enemigo, CORNERS, color(0, 0, 0), color(270, 100, 100), width-50, 25);
  }

  // ¿Mover a clase UI?
  // Texto del la interfaz
  void textoInterfaz() { 
    textFont(fuenteNeon);
    textSize(40);
    fill(0, 0, 100);
    textAlign(LEFT, TOP);
    if ( jugador.combo != 0) {
      text("x" + jugador.combo, combat.posX, combat.posY + combat.alto + 25);
    }
    textAlign(RIGHT, TOP);
    if ( enemigo.combo != 0) {
      text("x" + enemigo.combo, combat.posX + combat.ancho, combat.posY + combat.alto + 25);
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
    }

    if (jugador.salud < 0) {
      pushStyle();
      fill(0, 100, 100);
      text("PERDISTE", width / 2, 100);
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