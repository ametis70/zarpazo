class Personaje { //<>//
  // Datos
  int salud, saludMaxima, combo, damage, damageActual, tamX, tamY;

  boolean golpeando;

  // Nombre del personaje. Se utiliza para referenciar al personaje.
  String personaje;
  boolean jugador;

  // "nivel" creado solo para referenciar

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
  Ease easeGuantes;


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

    easeGuantes = new Ease();
  }

  void dibujar() {

    float direccionAzar = random(1);

    pushMatrix();
    pushStyle();
    imageMode(CENTER);
    animacion();
    //println(spriteActual)

    /*
    println("x" + xoff);
     println("y" +yoff);
     
     if (direccionAzar<0.2) {
     xoff = random(-5, 5);
     yoff = random(-10, 10);
     } else if (direccionAzar < 0.4) {
     xoff = random(0, 10);
     yoff = random(-5, 5);
     } else if (direccionAzar<0.6) {
     xoff = random(-2, 12);
     yoff = random(-2, 2);
     } else if (direccionAzar<0.8) {
     xoff = random(-3, 3);
     yoff = random(-1, 1);
     }
     
     constrain (xoff, -13, 13);
     constrain (yoff, -13, 13);
     ruidoX = noise (xoff);
     ruidoY = noise (yoff);
     translate(ruidoX*50, ruidoY*50);
     */

/*
    guantesX+=5;
    guantesY-=5;
    if (guantesY <= height-250) {
      guantesY+=15;
    }
    */


    image(guantes[spriteActual], guantesX, guantesY, 1200, 800);
    //   easeGuantes.inicializar(guantesX, guantesY, 1200, 800);

    //    easeGuantes.target(guantesX+ruidoX * 50, guantesY+ruidoY * 50);
    //   easeGuantes.easePos(0.05);

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
  PImage derrotado;
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

    switch (personaje) {
    case "cerbero":
      salud = saludMaxima = 7000;
      tamX = 583;
      tamY = 768;

      // Cantidad de imagenes
      pasivoCount = 5;
      golpeandoCount = 8;

    case "anubis":
      salud = saludMaxima = 8500;
      tamX = 583;
      tamY = 768;

      // Cantidad de imagenes
      pasivoCount = 5;
      golpeandoCount = 8;
    }



    pasivo = new PImage[pasivoCount];
    golpeando = new PImage[golpeandoCount];
    derrotado = loadImage ("data/imagenes/personajes/" + personaje + "/derrotado/derrotado.png");

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

    switch (estado) {
    case "pasivo":
      pasivo(); 
      imageMode(CENTER);
      image(pasivo[frame], posX, posY, tamX, tamY);
      break;

    case "golpeando":
      golpeando();
      imageMode(CENTER);
      image(golpeando[frame], posX, posY, tamX, tamY);
      break;


    case "derrotado":
      imageMode(CENTER);
      image(derrotado, posX, posY, tamX, tamY);
      break;
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