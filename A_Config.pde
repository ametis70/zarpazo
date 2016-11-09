// Funciones y variables de configuración(llamar desde setup)

// Tipografía
PFont fuenteJuego, 
  fuenteDebugging, 
  fuenteMenu;

void cargarFuentes() {
  fill(255);
  textAlign(CENTER, CENTER);
  fuenteJuego = createFont("data/fuentes/OpenSans-Bold.ttf", 25);
  fuenteMenu = createFont("data/fuentes/neonize.ttf", 30);
  fuenteDebugging = createFont("Arial", 16);
}

// Imagenes
PImage startScreen, 
  Escenario, 
  Escenario2, 
  Escenario3, 
  Cerbero, 
  Anubis, 
  Xolotl, 
  Cinematica1;

//PShape Cerbero, Xolotl, Rottweiler;


void inicializarFuentes() {
  cargarFuentes();
  textFont(fuenteJuego);
  textAlign(CENTER, CENTER);
}

void cargarImagenes() {
  startScreen = loadImage("data/imagenes/StartScreen.png");
  Escenario = loadImage("data/imagenes/Escenario.jpg");
  Escenario2 = loadImage("data/imagenes/Escenario2.jpg");
  Escenario3 = loadImage("data/imagenes/Escenario3.jpg");
  Cinematica1 = loadImage("data/imagenes/Cinematica1.jpg");
  Cerbero = loadImage("data/imagenes/Cerbero.png");
  Anubis = loadImage("data/imagenes/Anubis.png");
  Xolotl = loadImage("data/imagenes/Xolotl.png");

  //  Cerbero = loadShape("data/imagenes/Cerbero.svg");
  // Xolotl = loadShape("data/imagenes/Xolotl.svg");
  // Rottweiler = loadShape("data/imagenes/Rottweiler.svg");
}

// Configuración inicial

void inicializacion() {

  colorMode(HSB, 360, 100, 100);   // Cambiamos el color a HSB para manejar más fácil las teclas
  rectMode(CENTER);                // La barra se dibuja desde el centro
  strokeWeight(5);                 // Grosor de lineas
  noStroke();                      // No se dibujan las lineas para nada, todavía
}


// Mover a clase

void iniciarPelea() {
  if (!nivel.peleando) { 
    combat = new SistemaPelea(3);
  }

  nivel.peleando = true;
}