SistemaPelea combat;
Nivel nivel;
Menu menu;
//BarraVida barraVidaJugador;
//BarraVida barraVidaEnemigo;
BarraVida barra1, barra2;
Cinematica cinematica;


void setup() {

  size(1366, 768, P2D);
  //fullScreen(P2D);

  nivel = new Nivel();
  menu = new Menu();
  //barraVidaJugador = new BarraVida();
  //barraVidaEnemigo = new BarraVida();
  cinematica = new Cinematica("data/imagenes/cinematica1.jpg", 0, 0, 1280, 904);
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

  shapeMode(CENTER);

  //-------------------------------------------------------------------------------------------------------------------------------------
  if (nivel.etapaActual==0) {
    menu.TitleScreen();
  } 

  //-------------------------------------------------------------------------------------------------------------------------------------
  if (keyPressed && nivel.etapaActual == 0) {
    background(0);
    /*por ahora, esta lleva a la "Etapa" 2, que sería el nivel 1. El sistema de pelea, al perder el jugador, hace que se sume 2 a la variable "etapaActual".
     La variable nivel.etapaActual en los valores pares, lleva a los niveles y, en las impares, al menu y a las cinemáticas.
     */
    nivel.etapaActual=1;
  }

  //-------------------------------------------------------------------------------------------------------------------------------------
  
  // Prueba, todo esto hay que moverlo a su propia clase(¿hacer funciones globales en el archivo de las cinemáticas?)
  
  if (nivel.etapaActual == 1) {
    background(360);
    cinematica.dibujar();
    if (cinematica.movimiento == 0) {  
      cinematica.target(500, 500);
      cinematica.easePos(0.05);
    }
    if (cinematica.movimiento == 1) {
      cinematica.target(0, 600);
      cinematica.easePos(0.05);
    }
    if (cinematica.movimiento == 2) {
      cinematica.target(500, 0);
      cinematica.easePos(0.05);
    }
    if (cinematica.movimiento == 3) {
      cinematica.target(0, 0);
      cinematica.easePos(0.05);
    }
    if (cinematica.movimiento == 4) {
      cinematica.target(1920, 1356);
      cinematica.easeTam(0.05);
    }
    if (cinematica.movimiento == 5) {
      cinematica.target(-500, -500);
      cinematica.easePos(0.05);
    }
  }

  //-------------------------------------------------------------------------------------------------------------------------------------

  imageMode(CORNER);
  if (nivel.etapaActual==2) {
    background(0);
    // shape(Cerbero, width/2, height/2, 400, 0);
    nivel.nivel(Escenario, Cerbero, 550, 0);
  }

  //-------------------------------------------------------------------------------------------------------------------------------------
  if (nivel.etapaActual == 3) {
    //esta y la siguiente cinemática todavía no existen
    //cinematica2.Dibujar(Cinematica2, 0, -300, 3600, 0);
  }

  //-------------------------------------------------------------------------------------------------------------------------------------

  imageMode(CORNER);
  if (nivel.etapaActual==4) {
    background(0);
    nivel.nivel(Escenario2, Anubis, 550, 0);
  }

  //-------------------------------------------------------------------------------------------------------------------------------------
  if (nivel.etapaActual == 5) {
    //cinematica3.Dibujar(Cinematica3, 0, -300, 3600, 0);
  }

  //-------------------------------------------------------------------------------------------------------------------------------------

  imageMode(CORNER);
  if (nivel.etapaActual==6) {
    background(0);
    nivel.nivel(Escenario3, Xolotl, 800, 0);
  }
}