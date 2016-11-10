// Funciones y variables de configuración(llamar desde setup)

// Tipografía
PFont fuenteJuego, 
  fuenteDebugging, 
  fuenteMenu, 
  fuenteNeon;

void cargarFuentes() {
  fill(255);
  textAlign(CENTER, CENTER);
  fuenteJuego = createFont("data/fuentes/OpenSans-Bold.ttf", 25);
  fuenteMenu = createFont("data/fuentes/neonize.ttf", 30);
  fuenteDebugging = createFont("Arial", 16);
  fuenteNeon = createFont("data/fuentes/neon.ttf", 30);
}

// Imagenes
PImage startScreen, 
  Escenario, 
  Escenario2, 
  Escenario3, 
  Cerbero, 
  Anubis, 
  Xolotl, 
  cinematica1,
  circuloRojo, 
  circuloVerde, 
  circuloAzul, 
  circuloAmarillo,
  circuloGris;




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
  cinematica1 = loadImage("data/imagenes/cinematica1.jpg");
  Cerbero = loadImage("data/imagenes/Cerbero.png");
  Anubis = loadImage("data/imagenes/Anubis.png");
  Xolotl = loadImage("data/imagenes/Xolotl.png");
  circuloRojo = loadImage("data/imagenes/pelotas/1.png");
  circuloVerde = loadImage("data/imagenes/pelotas/2.png");
  circuloAzul = loadImage("data/imagenes/pelotas/3.png");
  circuloAmarillo = loadImage("data/imagenes/pelotas/4.png");
  circuloGris = loadImage("data/imagenes/pelotas/5.png");


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
    combat = new SistemaPelea(185, 80, 999, 110);
  }

  nivel.peleando = true;
}