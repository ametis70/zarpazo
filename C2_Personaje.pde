class Personaje {  //<>//
  // Datos
  int salud, saludMaxima, combo, damage, damageActual;

  boolean golpeando;
  String proximaAnimacion, golpeRecibido;

  // Nombre del personaje. Se utiliza para referenciar al personaje.
  String personaje;
  boolean jugador;

  // Se pasa el objeto del nivel por referencia para poder dañar al jugador
  Nivel nivel;

  // Función para infligir daño al enemigo
  void infligirDamage(Personaje personaje, String golpeDado) {
    if (this.personaje == "zarpazo") {
      damage = damageActual + int((combo * 1.6));
      personaje.salud -= damageActual + int((combo * 1.6));
      personaje.proximaAnimacion = "golpeado";
      personaje.golpeRecibido = golpeDado;
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

  PImage[] normal;
  PImage[] gancho;
  int sprites;

  boolean golpeoDerecha, golpeandoDerecha, direccionAdelante, terminoAnimacion, perfect;
  int frameInicial;
  int spriteActual;

  int guanteRandom;
  Ease easeGuantes;


  //Constructor
  Jugador(String personaje, Nivel nivel) {
    this.nivel = nivel;

    this.personaje = personaje;

    if (personaje == "zarpazo")
      salud = saludMaxima = 5000;
    else
      salud = saludMaxima = 4000; 

    combo = damage = damageActual = 0;
    jugador = true;
    puntos = 0;

    sprites = 5;
    normal = new PImage[sprites];
    gancho = new PImage[sprites];

    for (int i = 0; i < sprites; i++) {
      normal[i] = loadImage("data/imagenes/personajes/zarpazo/normal/" + i + ".png");
      gancho[i] = loadImage("data/imagenes/personajes/zarpazo/gancho/" + i + ".png");
    }

    terminoAnimacion = golpeoDerecha = direccionAdelante = true;
    spriteActual = 0;

    easeGuantes = new Ease();
  }

  void dibujar() {
    pushMatrix();
    pushStyle();
    imageMode(CENTER);
    animacion();

    if (!perfect)
      image(normal[spriteActual], width/2, height - 200, 1200, 800);
    else image(gancho[spriteActual], width/2, height - 200, 1200, 800);

    popStyle();
    popMatrix();
  }


  void animacion() {
    if (golpeando && terminoAnimacion) {
      frameInicial = frameCount;
      terminoAnimacion = false;

      guanteRandom = int(random(2));

      if (guanteRandom == 0) 
        golpeoDerecha = true;
      else
        golpeoDerecha = false;
    }

    if (!terminoAnimacion && golpeoDerecha) {
      //println("frame: " + (frameCount - frameInicial));

      if (spriteActual == 0 && !direccionAdelante && (frameCount - frameInicial) % 3 == 0) {
        direccionAdelante = true;
        terminoAnimacion = true;
        golpeoDerecha = false;
        perfect = false;
        golpeando = false;
        //println("termino golpe izquierda");
      }

      if (spriteActual > 0 && !direccionAdelante) {
        if ((frameCount - frameInicial) % 3 == 0) { 
          spriteActual--; 
          //println(spriteActual);
        }
      }

      if (spriteActual == 2 && direccionAdelante && (frameCount - frameInicial) % 3 == 0) {
        direccionAdelante = false;   

        if (perfect)
          infligirDamage(nivel.enemigo, "izquierdaGancho");
        else
          infligirDamage(nivel.enemigo, "izquierda");
          //println("cambia dirección");

      }


      if (spriteActual < 2 && direccionAdelante && !terminoAnimacion) {
        if ((frameCount - frameInicial) % 3 == 0) { 
          spriteActual++;
          //println(spriteActual);
        }
      }
    }

    if (!terminoAnimacion && !golpeoDerecha) {
      //println("frame: " + (frameCount - frameInicial));
      if (!golpeandoDerecha) {
        golpeandoDerecha = true;
        //println("Empezo golpe derecha");
        spriteActual = 3;
        //println(spriteActual);
      } else {

        if (spriteActual == 3 && !direccionAdelante && (frameCount - frameInicial) % 3 == 0) {
          spriteActual = 0;
          //println(spriteActual);
          direccionAdelante = true;
          terminoAnimacion = true;
          golpeoDerecha = true;
          golpeandoDerecha = false;
          perfect = false;
          golpeando = false;

          //println("termino golpe derecha");

        }

        if (spriteActual > 3 && !direccionAdelante) {
          if ((frameCount - frameInicial) % 3 == 0) { 
            spriteActual--; 
            //println(spriteActual);
          }
        }

        if (spriteActual == 4 && direccionAdelante && (frameCount - frameInicial) % 3 == 0) {
          direccionAdelante = false;   

          if (perfect)
            infligirDamage(nivel.enemigo, "derechaGancho");
          else
            infligirDamage(nivel.enemigo, "derecha");

          //println("cambia direccion");
        }


        if (spriteActual < 4 && direccionAdelante && !terminoAnimacion) {
          if ((frameCount - frameInicial) % 3 == 0) { 
            spriteActual++;
            //println(spriteActual);
          }
        }
      }
    }
  }
}

class Enemigo extends Personaje {
  PImage[] pasivo;
  PImage[] golpeando;
  PImage[] golpeado;
  PImage intro, vencido;

  boolean terminoAnimacion;
  int frameInicial;
  int spriteActual;

  String estado;

  boolean terminoP, terminoG;

  //Constructor
  Enemigo(String personaje, Nivel nivel) {
    this.nivel = nivel;
    // Según el personaje, se cargan las diferentes imagenes
    this.personaje = personaje;

    // Se crean las variables temporales para almacenar la cantidad de sprites
    int pasivoCount, golpeandoCount, golpeadoCount;
    pasivoCount = golpeandoCount = golpeadoCount = 0;

    // Variables comunes 
    jugador = false;
    estado = "pasivo";
    combo = damage = damageActual = 0;

    // Se inicializan las variables propias de cada personaje
    switch (personaje) {
    case "cerbero":
      salud = saludMaxima = 6000;

      // Cantidad de imagenes
      pasivoCount = 6;
      golpeandoCount = 6;
      golpeadoCount =  4;
      break;

    case "anubis":
      salud = saludMaxima = 7000;

      // Cantidad de imagenes
      pasivoCount = 5;
      golpeandoCount = 8;
      golpeadoCount = 8;
      break;


    case "xolotl":
      salud = saludMaxima = 9000;

      // Cantidad de imagenes
      pasivoCount = 5;
      golpeandoCount = 8;
      golpeadoCount = 8;
      break;
    }

    // Se cargan las imagenes de intro y ending
    intro = loadImage("/data/imagenes/personajes/" + personaje + "/intro.png");
    vencido = loadImage("/data/imagenes/personajes/" + personaje + "/vencido.png");

    // Se inicializan los tamaños de los arreglos
    pasivo = new PImage[pasivoCount];
    golpeado = new PImage[golpeadoCount];
    golpeando = new PImage[golpeandoCount];

    // Loops para cagar las imagenes
    for (int i = 0; i < pasivo.length; i++) {
      pasivo[i] = loadImage("data/imagenes/personajes/" + personaje + "/pasivo/" + i + ".png");
    }
    for (int i = 0; i < golpeado.length; i++) {
      golpeado[i] = loadImage("data/imagenes/personajes/" + personaje + "/golpeado/" + i + ".png");
    }
    for (int i = 0; i < golpeando.length; i++) {
      golpeando[i] = loadImage("data/imagenes/personajes/" + personaje + "/golpeando/" + i + ".png");
    }

    proximaAnimacion = "";
    estado = "intro";
  }

  void dibujar() {
    pushStyle();
    imageMode(CORNER);
    animacion();

    switch(estado) {
    case "intro":
      image(intro, 0, 0, width, height);
      break;
    case "pasivo":
      image(pasivo[spriteActual], 0, 0, width, height);
      break;
    case "golpeando":
      image(golpeando[spriteActual], 0, 0, width, height);
      break;
    case "golpeado":
      image(golpeado[spriteActual], 0, 0, width, height);
      break;
    case "vencido":
      image(vencido, 0, 0, width, height);
      break;
    }

    popStyle();
  }

  void animacion() {
    if ((proximaAnimacion != "" && terminoAnimacion == true) || proximaAnimacion == "golpeado") {
      frameInicial = frameCount;
      terminoAnimacion = false;
      spriteActual = 0;
      estado = proximaAnimacion;
      proximaAnimacion = "";
    }

    if (estado == "pasivo") {
      if (spriteActual == pasivo.length - 1 && (frameCount - frameInicial) % 7 == 0) {
        terminoAnimacion = true;
        proximaAnimacion = "pasivo";
      }

      if ((frameCount - frameInicial) % 7 == 0 && terminoAnimacion == false)
        spriteActual++;
    }

    if (estado == "golpeando") {
      //println("frame: " + (frameCount - frameInicial));

      if (spriteActual == golpeando.length - 1 && (frameCount - frameInicial) % 7 == 0) {
        terminoAnimacion = true;
        proximaAnimacion = "pasivo";
      }

      if ((frameCount - frameInicial) % 7 == 0 && terminoAnimacion == false && spriteActual < golpeando.length -1 )
        spriteActual++;

      if (frameCount - frameInicial == 7 * 4) {
        nivel.fallar = 30;
        infligirDamage(nivel.jugador, null);
      }
    }

    if (estado == "golpeado") {
      switch (golpeRecibido) {
      case "izquierda":
        spriteActual = 1;
        break;
      case "derecha":
        spriteActual = 0;
        break;
      case "izquierdaGancho":
        spriteActual = 3;
        break;
      case "derechaGancho":
        spriteActual = 2;
        break;
      }
      if ((frameCount - frameInicial) % 16 == 15 && !terminoAnimacion && salud > 0) {
        terminoAnimacion = true;
        golpeRecibido = "";
        proximaAnimacion = "pasivo";
      }
    }
  }
}