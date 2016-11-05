class Niveles {
int nivelActual;
boolean peleando = false;


  Niveles(){
    
  }
 
  void TitleScreen(){
    startScreen.resize(displayWidth, displayHeight);
    image(startScreen, 0, 0);
    text("Presione cualquier tecla para empezar", width/2, height-100);
  }
  
  void nivelUno(){
    Escenario2.resize(displayWidth, displayHeight);
    image(Escenario2, 0, 0);
    imageMode(CENTER);
    Xolotl.resize(600, 0);
    image(Xolotl, width/2+random(-1,1), height/2+50+random(-1,1));
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