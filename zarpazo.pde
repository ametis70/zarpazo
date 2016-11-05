int pantallaJuegoActiva = 0;
boolean peleando = false;
SistemaPelea combat;

float velocidad= 3;

float velocidadInicial = velocidad;

float accel = 1.00009;

boolean nuevoTurno = false;

void setup() {

  //size(1366, 768);
  fullScreen();

  //-------------------------------------------------------------------------------------------------------------------------------------

  // Tipografía 
  inicializarFuentes();

  // Imagenes

  cargarImagenes();

  // Arduino

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
    Escenario2.resize(displayWidth, displayHeight);
    image(Escenario2, 0, 0);
    imageMode(CENTER);
    Xolotl.resize(600, 0);
    image(Xolotl, width/2+random(-1, 1), height/2+50+random(-1, 1));
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