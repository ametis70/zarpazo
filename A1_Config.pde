// Librerías
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
  finish, 
  punch;

AudioPlayer 
  discomedusae, 
  aceshigh, 
  constancy, 
  ontheground, 
  enigma, 
  deadlyroulette, 
  plaint, 
  reunited, 
  takeachance,
  privateeye;

void cargarSonidos() {
  minim = new Minim(this);

  comun = minim.loadSample( "data/sonidos/comun.wav", 512);
  perfect = minim.loadSample( "data/sonidos/perfect.wav", 512);
  golpeEnemigo = minim.loadSample( "data/sonidos/enemigo.wav", 512);
  select = minim.loadSample( "data/sonidos/select.wav", 512);
  finish = minim.loadSample( "data/sonidos/finish.wav", 512);
  punch = minim.loadSample( "data/sonidos/punch.wav", 512);

  aceshigh = minim.loadFile( "data/musica/aceshigh.mp3", 2048);
  discomedusae = minim.loadFile( "data/musica/discomedusae.mp3", 2048);
  constancy = minim.loadFile( "data/musica/constancy.mp3", 2048);
  ontheground = minim.loadFile( "data/musica/ontheground.mp3", 2048);
  enigma = minim.loadFile( "data/musica/enigma.mp3", 2048);
  deadlyroulette = minim.loadFile( "data/musica/deadlyroulette.mp3", 2048);

  plaint = minim.loadFile( "data/musica/plaint.mp3", 2048);
  reunited = minim.loadFile( "data/musica/reunited.mp3", 2048);
  takeachance = minim.loadFile( "data/musica/takeachance.mp3", 2048);
  privateeye = minim.loadFile( "data/musica/privateeye.mp3", 2048);
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