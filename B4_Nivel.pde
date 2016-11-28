class Nivel {
  // Objeto para el sistema de pelea, cortina, enemigo, jugador y sus respectivas barras de vida
  SistemaPelea combat;
  Enemigo enemigo;
  Jugador jugador;
  Ui ui; 

  Cortina cortina;

  // Imagen de fondo para el nivel
  PImage background;

  boolean termino;

  // Constructor
  Nivel(String background, String gato, String perro) {
    combat = new SistemaPelea(this, 185, 80, 999, 110);
    jugador = new Jugador(gato);
    enemigo = new Enemigo(perro);

    ui = new Ui(jugador, enemigo, combat);

    termino = true;

    this.background = loadImage("data/imagenes/niveles/" + background + ".png");

    cortina = new Cortina(255);
  }

  void dibujar() {
    cortina.fadeIn();
    imageMode(CORNER);
    image(background, 0, 0, width, height);

    enemigo.dibujar(width / 2, height / 2 + 100, 420.8, 557.6);

    cortina.dibujar();

    if (cortina.listo)
      if (ui.textoPreparacion.iniciarPelea) {
        combat.pelea();
        combat.reiniciar();
      }

    ui.dibujar();
 
    cortina.fadeOut("gameover");

    if ( termino && (jugador.salud <= 0 || enemigo.salud <= 0)) {
      cortina.activar("out");
      termino = false;
    }
  }
}