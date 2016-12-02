class Nivel {
  // Objeto para el sistema de pelea, cortina, enemigo, jugador y sus respectivas barras de vida
  SistemaPelea combat;
  Enemigo enemigo;
  Jugador jugador;
  Ui ui; 

  Cortina cortina;

  // Imagen de fondo para el nivel
  PImage background, damage;

  boolean termino;
  int fallar;  
 


  // Constructor
  Nivel(String background, String gato, String perro) {
    combat = new SistemaPelea(this, 185, 80, 999, 110);
    jugador = new Jugador(gato);
    enemigo = new Enemigo(perro);

    ui = new Ui(jugador, enemigo, combat);

    termino = true;

    this.background = loadImage("data/imagenes/niveles/" + background + ".png");
    damage = loadImage("data/imagenes/ui/damage.png");

    cortina = new Cortina(255);
    fallar = 0;
  }

  void dibujar() {
    cortina.fadeIn();
    imageMode(CORNER);

    pushMatrix();
    if (fallar > 0 ) {

      translate(random(-2, 2), random(-2, 2));
      fallar--;
    }
    image(background, 0, 0, width, height);
    enemigo.dibujar(width / 2, height / 2 + 100, 420.8, 557.6);
    jugador.dibujar();
    popMatrix();

    if (fallar > 0) {
      pushStyle();
      imageMode(CORNER);
      tint(255, map(fallar, 0, 30, 0, 255));
      image(damage, 0, 0, width, height);
      popStyle();
    }

    if (cortina.listo)
      if (ui.textoPreparacion.iniciarPelea) {
        combat.pelea();
        combat.reiniciar();
      }

    ui.dibujar();

    cortina.dibujar();

    cortina.fadeOut("gameover");

    if ( termino && (jugador.salud <= 0 || enemigo.salud <= 0)) {
      cortina.activar("out");
      termino = false;
    }
  }
}