// Librerías
import ddf.minim.*;
Minim minim;

// Sonido

AudioSample 
  golpeCerbero,
  golpeAnubis,
  golpeXolotl, 
  select, 
  finish, 
  punch, 
  gameover;

AudioPlayer 
  musicaMenuPrincipal, 
  musicaSeleccion, 
  musicaCallejon, 
  musicaMansion, 
  musicaOficina, 
  musicaCineMansion, 
  musicaFinal, 
  musicaCineOficina, 
  musicaGameOver;

void cargarSonidos() {
  minim = new Minim(this);

  golpeCerbero = minim.loadSample( "data/sonidos/cerbero.wav", 512);
  golpeXolotl = minim.loadSample( "data/sonidos/xolotl.wav", 512);
  golpeAnubis = minim.loadSample( "data/sonidos/anubis.wav", 512);
  select = minim.loadSample( "data/sonidos/select.wav", 512);
  finish = minim.loadSample( "data/sonidos/punchecho.wav", 512);
  punch = minim.loadSample( "data/sonidos/punch.wav", 512);
  gameover = minim.loadSample( "data/sonidos/gameover.wav", 512);

  musicaSeleccion = minim.loadFile( "data/musica/aceshigh.mp3", 2048);
  musicaMenuPrincipal = minim.loadFile( "data/musica/discomedusae.mp3", 2048);
  musicaCallejon = minim.loadFile( "data/musica/retrofutureclean.mp3", 2048);
  musicaMansion = minim.loadFile( "data/musica/enigma.mp3", 2048);
  musicaOficina = minim.loadFile( "data/musica/clashdefiant.mp3", 2048);
  musicaCineMansion = minim.loadFile( "data/musica/unansweredquestions.mp3", 2048);
  musicaFinal = minim.loadFile( "data/musica/takeachance.mp3", 2048);
  musicaCineOficina = minim.loadFile( "data/musica/privateeye.mp3", 2048);
  musicaGameOver = minim.loadFile( "data/musica/gonebeyond.mp3", 2048);
}


// Funcion global para pausar todos los sonidos que estén cargados
void pausarMusica() {  
  musicaMenuPrincipal.pause();
  musicaSeleccion.pause();
  musicaCallejon.pause();
  musicaMansion.pause();
  musicaOficina.pause();
  musicaCineMansion.pause();
  musicaFinal.pause();
  musicaCineOficina.pause();
  musicaGameOver.pause();
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
  fuenteNeon = createFont("data/fuentes/Neon.ttf", 90);
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
