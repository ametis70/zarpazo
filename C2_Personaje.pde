class Personaje { //<>//
  // Datos
  int salud, saludMaxima, combo, damage, damageActual, tamX, tamY;

  boolean golpeando;

  // Nombre del personaje. Se utiliza para referenciar al personaje.
  String personaje;
  boolean jugador;

  // Función para infligir daño al enemigo
  void infligirDamage(Personaje personaje) {
    if (this.personaje == "zarpazo") {
      damage = damageActual + int((combo * 1.6));
      personaje.salud -= damageActual + int((combo * 1.6));
      golpeando = true;
    } else if (this.personaje == "baast") {
      damage = damageActual + int((combo * 1.2));
      personaje.salud -= damageActual + int((combo * 1.2));
    } else {
      damage = damageActual + int((combo * 1.4));
      personaje.salud -= damageActual + int((combo * 1.4));
    }
  }
  void comboBreak() {
    if (combo == 0) {
      damageActual = 0;
    }
  }
}


class Jugador extends Personaje {
  // Variable para almacenar la cantidad de puntos
  int puntos;

  PImage[] guantes;
  int sprites;

  boolean golpeoDerecha, golpeandoDerecha, direccionAdelante, terminoAnimacion;
  int frameInicial;
  int spriteActual;
  int guantesX, guantesY;
  float xoff, yoff;
  float ruido;
  float ruidoX, ruidoY;

  //Constructor
  Jugador(String personaje) {
    this.personaje = personaje;

    if (personaje == "zarpazo")
      salud = saludMaxima = 5000;
    else
      salud = saludMaxima = 4000; 

    combo = damage = damageActual = 0;
    jugador = true;
    puntos = 0;

    sprites = 5;
    guantes = new PImage[sprites];


    for (int i = 0; i < sprites; i++) {
      guantes[i] = loadImage("data/imagenes/personajes/zarpazo/" + i + ".png");
    }
    terminoAnimacion = golpeoDerecha = direccionAdelante = true;
    spriteActual = 0;

    guantesX = width/2;
    guantesY = height - 200;
    xoff = 0.0;
  }

  void dibujar() {
    pushMatrix();
    pushStyle();
    imageMode(CENTER);
    animacion();
    //println(spriteActual)
    xoff += 0.1;
    yoff *= 0.1;
    ruidoX = noise (xoff);
    ruidoY = noise (yoff);
    translate(ruido * 50, ruidoX * 50);
    image(guantes[spriteActual], guantesX, guantesY, 1200, 800);
    popStyle();
    popMatrix();
  }

  void animacion() {
    if (golpeando && terminoAnimacion) {
      frameInicial = frameCount;
      terminoAnimacion = false;
    }

    if (!terminoAnimacion && golpeoDerecha) {
      println("frame: " + (frameCount - frameInicial));

      if (spriteActual == 0 && !direccionAdelante && (frameCount - frameInicial) % 3 == 0) {
        direccionAdelante = true;
        terminoAnimacion = true;
        golpeoDerecha = false;
        golpeando = false;
        println("termino golpe izquierda");
      }

      if (spriteActual > 0 && !direccionAdelante) {
        if ((frameCount - frameInicial) % 3 == 0) { 
          spriteActual--; 
          println(spriteActual);
        }
      }

      if (spriteActual == 2 && direccionAdelante && (frameCount - frameInicial) % 3 == 0) {
        direccionAdelante = false;   
        println("cambia direccion");
      }


      if (spriteActual < 2 && direccionAdelante && !terminoAnimacion) {
        if ((frameCount - frameInicial) % 3 == 0) { 
          spriteActual++;
          println(spriteActual);
        }
      }
    }

    if (!terminoAnimacion && !golpeoDerecha) {
      println("frame: " + (frameCount - frameInicial));
      if (!golpeandoDerecha) {
        golpeandoDerecha = true;
        println("Empezo golpe derecha");
        spriteActual = 3;
        println(spriteActual);
      } else {

        if (spriteActual == 3 && !direccionAdelante && (frameCount - frameInicial) % 3 == 0) {
          spriteActual = 0;
          println(spriteActual);
          direccionAdelante = true;
          terminoAnimacion = true;
          golpeoDerecha = true;
          golpeandoDerecha = false;
          golpeando = false;
          println("termino golpe izquierda");
        }

        if (spriteActual > 3 && !direccionAdelante) {
          if ((frameCount - frameInicial) % 3 == 0) { 
            spriteActual--; 
            println(spriteActual);
          }
        }

        if (spriteActual == 4 && direccionAdelante && (frameCount - frameInicial) % 3 == 0) {
          direccionAdelante = false;   
          println("cambia direccion");
        }


        if (spriteActual < 4 && direccionAdelante && !terminoAnimacion) {
          if ((frameCount - frameInicial) % 3 == 0) { 
            spriteActual++;
            println(spriteActual);
          }
        }
      }
    }
  }
}

class Enemigo extends Personaje {
  PImage[] pasivo;
  PImage[] golpeando;
  int pasivoCount;
  int golpeandoCount;
  int frame, millis;

  String estado;

  boolean terminoP, terminoG;

  //Constructor
  Enemigo(String personaje) {
    // Según el personaje, se cargan las diferentes imagenes
    this.personaje = personaje;

    // Variables comunes 
    jugador = false;
    estado = "pasivo";
    combo = damage = damageActual = 0;

    // Variables para cerbero
    if (personaje == "cerbero") {
      salud = saludMaxima = 7000;
      tamX = 583;
      tamY = 768;

      // Cantidad de imagenes
      pasivoCount = 5;
      golpeandoCount = 8;
    }

    pasivo = new PImage[pasivoCount];
    golpeando = new PImage[golpeandoCount];

    // Estados para los sprites
    frame = 0;
    terminoP = true;
    terminoG = true;

    // Loops para cargar los diferentes sprites
    for (int i = 0; i < pasivoCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = "data/imagenes/personajes/" + personaje + "/pasivo/"+ i + ".png";
      pasivo[i] = loadImage(filename);
    }
    for (int i = 0; i < golpeandoCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = "data/imagenes/personajes/" + personaje + "/golpeando/" + i + ".png";
      golpeando[i] = loadImage(filename);
    }
  }

  // Métodos
  void dibujar(float posX, float posY, float tamX, float tamY) {
    if (estado == "pasivo") {
      pasivo(); 
      imageMode(CENTER);
      image(pasivo[frame], posX, posY, tamX, tamY);
    }
    if (estado == "golpeando") {
      golpeando();
      imageMode(CENTER);
      image(golpeando[frame], posX, posY, tamX, tamY);
    }
  }

  void pasivo() {
    if (terminoP) {
      millis = millis();
      terminoP = false;
    }    
    if (!terminoP) {
      if (millis() <  millis + 100) frame = 0;
      if (millis() >  millis + 100 && millis() < millis + 200) frame = 1;
      if (millis() >  millis + 200 && millis() < millis + 300) frame = 2;
      if (millis() >  millis + 300 && millis() < millis + 400) frame = 3;
      if (millis() >  millis + 400 && millis() < millis + 500) frame = 4;
      if (millis() >  millis + 500 && millis() < millis + 600) frame = 3;
      if (millis() >  millis + 600 && millis() < millis + 700) frame = 2;
      if (millis() > millis + 700) terminoP = true;
    }
  }
  void golpeando() {
    if (terminoG) {
      millis = millis();
      terminoG = false;
    }    
    if (terminoG == false) {
      if (millis() <  millis + 50) frame = 0;
      if (millis() >  millis + 50 && millis() < millis + 100) frame = 1;
      if (millis() >  millis + 100 && millis() < millis + 150) frame = 2;
      if (millis() >  millis + 150 && millis() < millis + 200) frame = 3;
      if (millis() >  millis + 250 && millis() < millis + 300) frame = 4;
      if (millis() >  millis + 350 && millis() < millis + 400) frame = 5;
      if (millis() >  millis + 450 && millis() < millis + 500) frame = 6;
      if (millis() >  millis + 550 && millis() < millis + 600) frame = 7;

      if (millis() > millis + 600) {
        terminoP = true;
        estado = "pasivo";
      }
    }
  }
}