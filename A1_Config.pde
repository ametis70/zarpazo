// Librerías
import controlP5.*;
ControlP5 cp5;

import ddf.minim.*;
Minim minim;

// c5p(Interfaz)
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
  fuenteJuego = createFont("data/fuentes/OpenSans-Regular.ttf", 25);
  fuenteMenu = createFont("data/fuentes/neonize.ttf", 30);
  fuenteDebugging = createFont("Arial", 16);
  fuenteNeon = createFont("data/fuentes/neon.ttf", 30);
}

// Imagenes
PImage 
  circuloRojo, 
  circuloVerde, 
  circuloAzul, 
  circuloNaranja, 
  circuloGris,
  background;

void inicializarFuentes() {
  cargarFuentes();
  textFont(fuenteJuego);
  textAlign(CENTER, CENTER);
}

void cargarImagenes() {
  circuloRojo = loadImage("data/imagenes/ui/pelotas/1.png");
  circuloVerde = loadImage("data/imagenes/ui/pelotas/2.png");
  circuloAzul = loadImage("data/imagenes/ui/pelotas/3.png");
  circuloNaranja = loadImage("data/imagenes/ui/pelotas/4.png");
  circuloGris = loadImage("data/imagenes/ui/pelotas/5.png");
  background = loadImage("data/imagenes/menu/background.png");
}

boolean golpe() {
  if ((keyPressed ||
    microswitch()) &&
    (key == 'a' ||
    key == 'A' ||
    key == 's' ||
    key == 'S' ||
    key == 'd' ||
    key == 'D' ||
    microswitch(1) == 1 ||
    microswitch(2) == 1 ||
    microswitch(3) == 1))
    
    return true;
  else
    return false;
}

String colorGolpe() {
  String colorcito = "";
  if (key == 'a' || key == 'A' || microswitch(1) == 1)
    colorcito = "azul";
  if (key == 's' || key == 'S' || microswitch(2) == 1)
    colorcito = "verde";
  if (key == 'd' || key == 'D' || microswitch(3) == 1)
    colorcito = "rojo";
  //if (key == 'f' || key == 'F' || microswitch(4) == 1)
  //  colorcito = "naranja";

  return colorcito;
}