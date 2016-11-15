// Liberías
import controlP5.*;
ControlP5 cp5;


// Libería c5p
void c5p() {
   cp5 = new ControlP5(this);
}


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
PImage escenario2, 
  escenario3, 
  anubis, 
  xolotl, 
  cinematica1, 
  circuloRojo, 
  circuloVerde, 
  circuloAzul, 
  circuloAmarillo, 
  circuloGris;

void inicializarFuentes() {
  cargarFuentes();
  textFont(fuenteJuego);
  textAlign(CENTER, CENTER);
}

void cargarImagenes() {
  escenario2 = loadImage("data/imagenes/niveles/escenario2.jpg");
  escenario3 = loadImage("data/imagenes/niveles/escenario3.jpg");
  cinematica1 = loadImage("data/imagenes/cinematicas/cinematica1.jpg");
  anubis = loadImage("data/imagenes/personajes/anubis.png");
  xolotl = loadImage("data/imagenes/personajes/xolotl.png");
  circuloRojo = loadImage("data/imagenes/ui/pelotas/1.png");
  circuloVerde = loadImage("data/imagenes/ui/pelotas/2.png");
  circuloAzul = loadImage("data/imagenes/ui/pelotas/3.png");
  circuloAmarillo = loadImage("data/imagenes/ui/pelotas/4.png");
  circuloGris = loadImage("data/imagenes/ui/pelotas/5.png");


  // Cerbero = loadShape("data/imagenes/Cerbero.svg");
  // Xolotl = loadShape("data/imagenes/Xolotl.svg");
  // Rottweiler = loadShape("data/imagenes/Rottweiler.svg");
}

// Configuración inicial
void inicializacion() {


  rectMode(CENTER);                // La barra se dibuja desde el centro
  strokeWeight(5);                 // Grosor de lineas
  noStroke();                      // No se dibujan las lineas para nada, todavía
}