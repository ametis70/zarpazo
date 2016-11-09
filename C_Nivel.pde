class Nivel {

  int etapaActual;
  boolean peleando = false;
  boolean pan = true;


  Nivel() {
  }

  void nivel(PImage escenario, PImage enemigoNombre, int tamX, int tamY) {
    escenario.resize(displayWidth, displayHeight);
    enemigoNombre.resize(tamX, tamY);
    image(escenario, 0, 0);
    imageMode(CENTER);
    image(enemigoNombre, width/2+random(-1, 1), height/2+50+random(-1, 1));
    // background(0);

    if (peleando == false) {
      iniciarPelea();
    }
    combat.pelea();
    combat.turno();
    combat.debugging();


    barraVidaJugador.dibujar( player, CORNER, color(0, 0, 0), color(0, 100, 100), 50, 25 );
    barraVidaEnemigo.dibujar( enemigo, CORNERS, color(0, 0, 0), color(270, 100, 100), width-50, 25);
  }
}