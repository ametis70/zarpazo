class Nivel {
  // Objeto para el sistema de pelea, cortina, enemigo, jugador y sus respectivas barras de vida
  SistemaPelea combat;
  Enemigo enemigo;
  Jugador jugador;
  BarraVida barraJugador, barraEnemigo;
  Cortina cortina;
  Animation cerbero;

  // Imagen de fondo para el nivel
  PImage background;

  // Variables para la la preparación
  PImage preparado, listo, ya, imagenActiva;
  boolean preparadoListo, listoListo, todoListo;
  int tamImagen, alpha;

  boolean termino;
  boolean musica;

  // Constructor
  Nivel(String background, String gato, int gatoHP, String perro, int perroHP) {
    combat = new SistemaPelea(185, 80, 999, 110);

    jugador = new Jugador(gatoHP, gato);
    enemigo = new Enemigo(perroHP, perro, 583, 768);

    cerbero = new Animation("cerbero", 5, 8);

    // Imagenes de preparación
    preparado = loadImage("data/imagenes/ui/preparacion/preparado.png");
    listo = loadImage("data/imagenes/ui/preparacion/listo.png");
    ya = loadImage("data/imagenes/ui/preparacion/ya.png");

    tamImagen = 300;
    alpha = 300;

    imagenActiva = preparado;
    preparadoListo = true;

    musica = true;

    termino = true;

    barraJugador = new BarraVida(jugador, 45, 50, 95, height-100);
    barraEnemigo = new BarraVida(enemigo, width-45, 100, width-95, height-50);

    this.background = loadImage("data/imagenes/niveles/" + background + ".png");

    cortina = new Cortina(255);
  }

  void dibujar() {
    if (musica) {
      bone.loop();
      musica = false;
    }
    cortina.fadeIn();
    imageMode(CORNER);
    image(background, 0, 0, 1366, 768);

    cerbero.dibujar(width / 2, height / 2 + 100, 420.8, 557.6);
    if (todoListo==true) {
      combat.pelea(this);
      combat.reiniciar();
      //combat.debugging();
      textoInterfaz();
    }

    // Se dibuja la Mira y el cuadrado
    combat.mira.dibujar();
    fill(0, 0, 0, 50);
    noStroke();
    rectMode(CORNER);
    rect(combat.posX, combat.posY, combat.ancho, combat.alto);

    barraJugador.dibujar(jugador, enemigo);
    barraEnemigo.dibujar(enemigo, jugador);

    cortina.dibujar();

    if (cortina.listo == true)
      preparacion(); // Si la pelota anterior no está activa

    cortina.fadeOut("gameover");

    if ( termino && (jugador.salud <= 0 || enemigo.salud <= 0)) {
      bone.pause();
      finish.trigger();
      cortina.activar("out");
      termino = false;
    }
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

  void preparacion() {
    pushStyle();

    imageMode(CENTER);
    tint(255, alpha);
    image(imagenActiva, width/2, height/2, tamImagen, tamImagen*0.4);
    tamImagen+=10;
    alpha-=7;

    popStyle();

    if (alpha<=0 && preparadoListo== true) {
      alpha=200;
      tamImagen=300;
      imagenActiva=listo;
      preparadoListo=false;
      listoListo=true;
    }
    if (alpha<=0 && listoListo== true) {
      alpha=200;
      tamImagen=300;
      imagenActiva=ya;
      listoListo=false;
      todoListo=true;
    }
    if (alpha<=0 && todoListo== true) {
      listoListo=false;
    }
  }
}