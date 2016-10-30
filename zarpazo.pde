int pantallaJuegoActiva = 0;
boolean peleando = false;
SistemaPelea combat;

void setup() {

  size(1280, 720);

  //-------------------------------------------------------------------------------------------------------------------------------------

  // Tipografía 
  cargarFuentes();
  textFont(fuenteJuego);
  textAlign(CENTER, CENTER);

  // Imagenes

  cargarImagenes();

  //-------------------------------------------------------------------------------------------------------------------------------------
  // Se llama a que se declaren las condiciones iniciales necesarias para el sistema de pelea.
  inicializacion();
  //-------------------------------------------------------------------------------------------------------------------------------------
}


void draw() {

  //-------------------------------------------------------------------------------------------------------------------------------------

  if (pantallaJuegoActiva==0) {
    startScreen.resize(displayWidth, displayHeight);
    image(startScreen, 0, 0);
    text("Presione cualquier tecla para empezar", width/2, height-100);
  } 

  //-------------------------------------------------------------------------------------------------------------------------------------

  if (keyPressed && pantallaJuegoActiva == 0) {
    background(0);
    pantallaJuegoActiva=1;
  }


  //-------------------------------------------------------------------------------------------------------------------------------------

  imageMode(CORNER);
  if (pantallaJuegoActiva==1) {
    /* Escenario2.resize(displayWidth, displayHeight);
     image(Escenario2, 0, 0);
     imageMode(CENTER);
     Xolotl.resize(300, 0);
     image(Xolotl, width/2, height/2+150); */
    background(0);
    if (peleando == false) {
      iniciarPelea();
    }
    combat.pelea();
    combat.turno();
    combat.debugging();
  }
}