// Funciones y variables de configuración(llamar desde setup)

// Tipografía
PFont fuenteJuego, 
  fuenteDebugging;

void cargarFuentes() {
  fill(255);
  textAlign(CENTER, CENTER);
  fuenteJuego = createFont("Open Sans", 25);
  fuenteDebugging = createFont("Arial", 16);
}

// Imagenes
PImage startScreen, 
  Escenario2, 
  Xolotl; 

void inicializarFuentes() {
  cargarFuentes();
  textFont(fuenteJuego);
  textAlign(CENTER, CENTER);
}

void cargarImagenes() {
  startScreen = loadImage("StartScreen.jpg");
  Escenario2 = loadImage("Escenario.jpg");
  Xolotl = loadImage("Xolotl.png");
}

// Configuración inicial

void inicializacion() {

  colorMode(HSB, 360, 100, 100);   // Cambiamos el color a HSB para manejar más fácil las teclas
  rectMode(CENTER);                // La barrita se dibuja desde el centro
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