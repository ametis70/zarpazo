// Funciones y variables de configuración(llamar desde setup)

// Tipografía
PFont fuenteJuego,
      fuenteDebugging;

void cargarFuentes() {
  textAlign(CENTER, CENTER);
  fuenteJuego = createFont("Open Sans", 25);
  fuenteDebugging = createFont("Arial", 12);
}

// Imagenes
PImage startScreen, 
       escenario2, 
       xolotl;   

void cargarImagenes() {
  startScreen = loadImage("StartScreen.jpg");
  escenario2 = loadImage("Escenario2.jpg");
  xolotl = loadImage("Xolotl.png");
}

// Configuración inicial

void inicializacion() {

  colorMode(HSB, 360, 100, 100);   // Cambiamos el color a HSB para manejar más fácil las teclas
  rectMode(CENTER);                // La barrita se dibuja desde el centro
  strokeWeight(5);                 // Grosor de lineas
  noStroke();                      // No se dibujan las lineas para nada, todavía
}

void iniciarPelea() {
 if(!peleando){ 
   combat = new SistemaPelea(3); 
 }
 peleando = true;
}