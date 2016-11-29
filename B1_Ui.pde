// Diferentes clases para elementos de la interfaz de pelea

// Clase para contener a todos los elementos de la interfaz
class Ui {
  // Objetos de la interfaz
  BarraVida barraJugador, barraEnemigo;
  TextoPreparacion textoPreparacion;
  Mira mira;


  // Se crean objetos para pasar por valor los objetos de jugador y enemigo del nivel
  Jugador jugador;
  Enemigo enemigo;
  SistemaPelea combat;

  // Constructor
  Ui(Jugador jugador, Enemigo enemigo, SistemaPelea combat) {
    this.jugador = jugador;
    this.enemigo = enemigo;
    this.combat = combat;

    barraJugador = new BarraVida(jugador);
    barraEnemigo = new BarraVida(enemigo);

    mira = new Mira(width/2, combat.posY + combat.alto / 2, 7, 100);
    textoPreparacion = new TextoPreparacion();
  }

  // Métodos
  void dibujar() {
    if (textoPreparacion.iniciarPelea == false)
      textoPreparacion.dibujar();
    else {
      // Se dibujan los elementos que están contenidos en objetos
      barraJugador.dibujar(jugador, enemigo);
      barraEnemigo.dibujar(enemigo, jugador);
      mira.dibujar();
      textoInterfaz();

      // Se dibuja el cuadrado que "contiene" a la barra del sistema de pelea
      fill(0, 0, 0, 50);
      noStroke();
      rectMode(CORNER);
      rect(combat.posX, combat.posY, combat.ancho, combat.alto);
    }
  }

  // Texto del la interfaz
  void textoInterfaz() { 
    textFont(fuenteNeon);
    textSize(40);
    fill(0, 0, 100);
    textAlign(LEFT, TOP);
    if ( jugador.combo != 0) {
      text("x" + jugador.combo, combat.posX, combat.posY + combat.alto + 25);
    }
    //textAlign(RIGHT, TOP);
    //if ( enemigo.combo != 0) {
    //  text("x" + enemigo.combo, combat.posX + combat.ancho, combat.posY + combat.alto + 25);
    //}
    //textAlign(CENTER, CENTER);
    //if (resultado != null) {
    //  if (resultado == "¡Perfecto!")
    //    fill(161, 100, 100);
    //  if (resultado == "¡Excelente!")
    //    fill(90, 100, 100);
    //  if (resultado == "¡Bien!")
    //    fill(55, 100, 50);
    //  if (resultado == "Puede ser mejor...")
    //    fill(28, 100, 100);
    //  if (resultado == "¡Bolsa equivocada!")
    //    fill(28, 100, 100);
    //  if (resultado == "¡No golpeaste ninguna bolsa!")
    //    fill(28, 100, 100);

    //  text(resultado, width/2, 50);
    //}
  }
}

class TextoPreparacion {
  // Variables para la la preparación
  PImage ready, fight, imagenActiva;
  int contador;
  int tam, alpha;

  boolean iniciarPelea;

  TextoPreparacion() {
    // Imagenes de preparación
    ready = loadImage("data/imagenes/ui/preparacion/listo.png");
    fight = loadImage("data/imagenes/ui/preparacion/pelea.png");

    tam = 878 / 2;
    alpha = 255;

    iniciarPelea = false;
    contador = 2;
  }

  void dibujar() {
    pushStyle();

    imageMode(CENTER);
    tint(255, alpha);

    if (imagenActiva != null)
      image(imagenActiva, width/2, height/2, tam, tam);

    tam += 10; 
    alpha-=4;

    popStyle();

    if (alpha <= 0 && contador == 2) {
      imagenActiva = ready;
      alpha=255;
      tam = 878 / 2;
      contador--;
    }

    if (alpha <= 0 && contador == 1) {
      alpha=255;
      tam = 878 / 2;
      imagenActiva = fight;
      contador--;
    }
    if (alpha <= 0 && contador == 0) {
      imagenActiva = null;
      iniciarPelea = true;
    }
  }
}

// Mira utilizada en el sistema pelea en conjunto con Pelota
class Mira {
  // Datos 
  float posX, posY; 
  int tamX, tamY; 
  PImage miraGris, miraRoja, miraAzul, miraVerde;
  String colorcito;

  // Constructor
  Mira(float posX, float posY, int tamX, int tamY) {
    this.posX = posX;
    this.posY = posY;

    this.tamX = tamX;
    this.tamY = tamY;

    miraGris = loadImage ("data/imagenes/ui/mira/mira-gris.png");
    miraRoja = loadImage ("data/imagenes/ui/mira/mira-roja.png");
    miraVerde = loadImage ("data/imagenes/ui/mira/mira-verde.png");
    miraAzul = loadImage ("data/imagenes/ui/mira/mira-azul.png");

    colorcito = "";
  }

  // Función para dibujar la mira 
  void dibujar() {
    pushStyle();

    /* Mira viejeta
     ellipseMode(CENTER);
     noFill();
     strokeWeight(6);
     stroke(0, 0, 100);
     ellipse(posX, posY, tamY, tamY);
     */

    imageMode(CENTER);
    if (colorcito == "azul") 
      image (miraAzul, posX, posY, tamY, tamY);
    if (colorcito == "verde")
      image (miraVerde, posX, posY, tamY, tamY);
    if (colorcito == "rojo")
      image (miraRoja, posX, posY, tamY, tamY);
    if (colorcito == "gris") 
      image (miraGris, posX, posY, tamY, tamY);

    popStyle();
  }

  void cambiarColor(Pelota i) {
    if (i.tipo == 0) 
      colorcito = "azul";
    if (i.tipo == 1) 
      colorcito = "verde";
    if (i.tipo == 2) 
      colorcito = "rojo";
  }
}
// Barras para indicar la cantidad de vida de cada personaje
class BarraVida {
  // Datos
  float posX1, posY1, posX2, posY2, damageClip;  
  PImage fondo, relleno, icono, damage; 
  boolean enemigo;

  // Constructor 
  BarraVida(Personaje personaje) {
    if (personaje.jugador)
      enemigo = false;
    else
      enemigo = true;

    if (enemigo) {
      posX1 = width - 25;
      posY2 = height - 68;
      posY1 = posY2 - 632;
      posX2 = posX1 - 166;
    } else {
      posX1 = 25;
      posX2 = posX1 + 166;
      posY1 = 68;
      posY2 = posY1 + 632;
    }

    if (enemigo) {
      relleno = loadImage("data/imagenes/ui/barras/enemigo-lleno.png");
      damage = loadImage("data/imagenes/ui/barras/enemigo-golpeado.png");
      fondo = loadImage("data/imagenes/ui/barras/enemigo-fondo.png");
      icono = loadImage("data/imagenes/ui/iconos/" + personaje.personaje + ".png");
    }
    if (personaje.personaje == "zarpazo") { 
      relleno = loadImage("data/imagenes/ui/barras/zarpazo-lleno.png");
      damage = loadImage("data/imagenes/ui/barras/zarpazo-golpeado.png");
      fondo = loadImage("data/imagenes/ui/barras/jugador-fondo.png");
      icono = loadImage("data/imagenes/ui/iconos/zarpazo.png");
    } 
    if (personaje.personaje == "baast") {
      relleno = loadImage("data/imagenes/ui/barras/baast-lleno.png");
      damage = loadImage("data/imagenes/ui/barras/baast-golpeado.png");
      fondo = loadImage("data/imagenes/ui/barras/jugador-fondo.png");
      icono = loadImage("data/imagenes/ui/iconos/baast.png");
    }
  }

  // Método para dibujar la barra
  void dibujar(Personaje personaje, Personaje contrario) {
    imageMode(CORNERS);

    // Barra vacia
    image(fondo, posX1, posY1, posX2, posY2);

    // Se guarda la posición del primer golpe del combo para la barra de daño
    if (contrario.combo == 0) {
      if (enemigo)
        damageClip = map(personaje.salud, 0, personaje.saludMaxima, posY1, posY2);   
      else 
      damageClip = map(personaje.salud, personaje.saludMaxima, 0, posY1, posY2);
    }

    if (enemigo)
      clip(posX1, posY1, posX2, damageClip);   
    else 
    clip(posX1, damageClip, posX2, posY2);

    image(damage, posX1, posY1, posX2, posY2);

    noClip();


    // Si es enemigo, el clip es de abajo para arriba. Si es jugador, al revés
    if (enemigo)
      clip(posX1, posY1, posX2, map(personaje.salud, 0, personaje.saludMaxima, posY1, posY2));   
    else 
    clip(posX1, map(personaje.salud, 0, personaje.saludMaxima, posY2, posY1), posX2, posY2);

    // Barra con vida
    image(relleno, posX1, posY1, posX2, posY2);

    noClip();

    // Se dibuja el icono
    imageMode(CENTER);
    if (!enemigo)
      image(icono, (posX2 + posX1) / 2, posY2 - 75, 85, 85);
    else 
    image(icono, (posX2 + posX1) /2, posY1 + 75, 85, 85);
  }
}