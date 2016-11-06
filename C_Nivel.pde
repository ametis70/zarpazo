class Nivel {

  int nivelActual;
  boolean peleando = false;
  boolean pan = true;


  Nivel() {
  }

  void nivel(PImage escenario, PImage enemigoNombre) {
    escenario.resize(displayWidth, displayHeight);
    image(escenario, 0, 0);
    imageMode(CENTER);
    enemigoNombre.resize(600, 0);
    image(enemigoNombre, width/2+random(-1, 1), height/2+50+random(-1, 1));
    // background(0);

    if (peleando == false) {
      iniciarPelea();
    }
    combat.pelea();
    combat.turno();
    combat.debugging();
    player.dibujarBarraJugador();
    enemigo.dibujarBarraEnemigo();
  }
}