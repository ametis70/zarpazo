// Liberías
import controlP5.*;
ControlP5 cp5;

import ddf.minim.*;
Minim minim;


// c5p(Interfaz)
void c5p() {
  cp5 = new ControlP5(this);
}

// Sonido

AudioSample 
  comun, 
  perfect, 
  golpeEnemigo, 
  select, 
  finish;

AudioPlayer 
  way, 
  bone;

void cargarSonidos() {
  minim = new Minim(this);

  comun = minim.loadSample( "data/sonidos/comun.wav", 512);
  perfect = minim.loadSample( "data/sonidos/perfect.wav", 512);
  golpeEnemigo = minim.loadSample( "data/sonidos/enemigo.wav", 512);
  select = minim.loadSample( "data/sonidos/select.wav", 512);
  finish = minim.loadSample( "data/sonidos/finish.wav", 512);

  bone = minim.loadFile( "data/musica/bone.mp3", 2048);
  way = minim.loadFile( "data/musica/way.mp3", 2048);
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
PImage 
  circuloRojo, 
  circuloVerde, 
  circuloAzul, 
  circuloNaranja, 
  circuloGris;

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
}

boolean golpe() {
  if (keyPressed || microswitch() != 0) {
    return true;
  } else return false;
}

String colorGolpe() {
  String colorcito = "";
  if (key == 'a' || key == 'A' || microswitch(1) == 1)
    colorcito = "rojo";
  if (key == 's' || key == 'S' || microswitch(2) == 1)
    colorcito = "azul";
  if (key == 'd' || key == 'D' || microswitch(3) == 1)
    colorcito = "naranja";
  if (key == 'f' || key == 'F' || microswitch(4)== 1)
    colorcito = "verde";

  return colorcito;
}