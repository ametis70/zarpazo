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
      if (personaje.salud > 0)
        punch.trigger();
      else {
        finish.trigger();
        pausarMusica();
      }
    } else if (this.personaje == "baast") {
      damage = damageActual + int((combo * 1.2));
      personaje.salud -= damageActual + int((combo * 1.2));
      personaje.proximaAnimacion = "golpeado";
      personaje.golpeRecibido = golpeDado;
      if (personaje.salud > 0)
        punch.trigger();
      else {
        finish.trigger();
        pausarMusica();
      }
    } else if (this.personaje == "cerbero") {
      damage = damageActual + int((combo * 1.2));
      personaje.salud -= damageActual + int((combo * 1.2));
      golpeCerbero.trigger();
      if (personaje.salud <= 0)
        pausarMusica();
    } else if (this.personaje == "anubis") {
      damage = damageActual + int((combo * 1.4));
      personaje.salud -= damageActual + int((combo * 1.4));
      golpeAnubis.trigger();
      if (personaje.salud <= 0)
        pausarMusica();
    } else if (this.personaje == "xolotl") {
      damage = damageActual + int((combo * 1.2));
      personaje.salud -= damageActual + int((combo * 1.2));
      golpeXolotl.trigger();
      if (personaje.salud <= 0)
        pausarMusica();
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

  boolean golpeoDerecha, golpeandoDerecha, golpeo, direccionAdelante, terminoAnimacion, perfect;
  int frameInicial;
  int spriteActual;


  int guanteRandom;
  Ease easeGuantes;
  boolean direccionAbajo;


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

    normal = new PImage[5];
    gancho = new PImage[7];

    for (int i = 0; i < normal.length; i++) {
      normal[i] = loadImage("data/imagenes/personajes/" + personaje + "/normal/" + i + ".png");
    }
    for (int i = 0; i < gancho.length; i++) {
      gancho[i] = loadImage("data/imagenes/personajes/" + personaje + "/gancho/" + i + ".png");
    }

    terminoAnimacion = golpeoDerecha = direccionAdelante = true;
    spriteActual = 0;

    easeGuantes = new Ease();
    direccionAbajo = true;
  }

  void dibujar() {
    easeGuantes.inicializar(0, 0, 0, 0);

    if (direccionAbajo)
      easeGuantes.target(0, 50);
    else
      easeGuantes.target(0, 0);

    easeGuantes.easePos(0.06);
    if (easeGuantes.listo == false)
      direccionAbajo = !direccionAbajo;


    pushMatrix();
    pushStyle();
    translate(easeGuantes.posX, easeGuantes.posY);
    imageMode(CENTER);
    animacion();
    if (!perfect)
      image(normal[spriteActual], width/2, height - 180, 1366, 768);
    else if (perfect) image(gancho[spriteActual], width/2, height - 180, 1366, 768);

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

    // Se da un golpe con la izquierda
    if (!terminoAnimacion && golpeoDerecha) {
      //println("frame: " + (frameCount - frameInicial));

      // Si se da un golpe perfecto, el golpe es un gancho
      if (perfect) {
        // Si la animación llega al primer frame luego de volver, se reinician los booleanos
        if (spriteActual == 0 && !direccionAdelante && (frameCount - frameInicial) % 5 == 0) {
          direccionAdelante = true;
          terminoAnimacion = true;
          golpeoDerecha = false;
          perfect = false;
          golpeando = false;
          golpeo = false;
          println("termino gancho izquierda");
        }

        // Si se está regresando y todavía no se llegó al primer sprite, se resta uno a spriteActual
        if (spriteActual > 0 && !direccionAdelante) {
          if ((frameCount - frameInicial) % 5 == 0) { 
            spriteActual--; 
            println(spriteActual);
          }
        }


        // Si spriteActual llegó al ultimo frame de la mano, se cambia la dirección
        if (spriteActual == 3 && direccionAdelante && (frameCount - frameInicial) % 5 == 0) {
          direccionAdelante = false;
          println("cambia dirección");
        }

        // Si spriteActual es menor al ultimo frame de la mano, se le suma uno a spriteActual
        if (spriteActual < 3 && direccionAdelante && !terminoAnimacion) {
          if ((frameCount - frameInicial) % 5 == 0) { 
            spriteActual++;
            println(spriteActual);
          }
        }

        // Si se llego al frame en el que se golpea, se hace daño al enemigo
        if (spriteActual == 3 && direccionAdelante && golpeo == false) {
          infligirDamage(nivel.enemigo, "izquierdaGancho");
          golpeo = true;
          println("se da el golpe");
        }
      }

      // Sino se da un golpe normal
      else if (perfect == false) {

        if (spriteActual == 0 && !direccionAdelante && (frameCount - frameInicial) % 5 == 0) {
          direccionAdelante = true;
          terminoAnimacion = true;
          golpeoDerecha = false;
          golpeando = false;
          perfect = false;
          golpeo = false;
          //println("termino golpe izquierda");
        }

        if (spriteActual > 0 && !direccionAdelante) {
          if ((frameCount - frameInicial) % 5 == 0) { 
            spriteActual--; 
            //println(spriteActual);
          }
        }



        if (spriteActual == 2 && direccionAdelante && (frameCount - frameInicial) % 5 == 0) {
          direccionAdelante = false;
        }


        if (spriteActual < 2 && direccionAdelante && !terminoAnimacion) {
          if ((frameCount - frameInicial) % 5 == 0) { 
            spriteActual++;
            //println(spriteActual);
          }
        }

        if (spriteActual == 2 && direccionAdelante && golpeo == false) {
          infligirDamage(nivel.enemigo, "izquierda");

          golpeo = true;
        }
      }
    }

    if (!terminoAnimacion && !golpeoDerecha) {
      if (perfect) {
        //println("frame: " + (frameCount - frameInicial));
        if (!golpeandoDerecha) {
          golpeandoDerecha = true;
          //println("Empezo golpe derecha");
          spriteActual = 4;
          //println(spriteActual);
        } else {

          if (spriteActual == 4 && !direccionAdelante && (frameCount - frameInicial) % 5 == 0) {
            spriteActual = 0;
            //println(spriteActual);
            direccionAdelante = true;
            terminoAnimacion = true;
            golpeoDerecha = true;
            golpeandoDerecha = false;
            perfect = false;
            golpeando = false;
            golpeo = false;

            //println("termino golpe derecha");
          }

          if (spriteActual > 4 && !direccionAdelante) {
            if ((frameCount - frameInicial) % 5 == 0) { 
              spriteActual--; 
              //println(spriteActual);
            }
          }

          if (spriteActual == 6 && direccionAdelante && (frameCount - frameInicial) % 5 == 0) {
            direccionAdelante = false;   
            //println("cambia direccion");
          }


          if (spriteActual < 6 && direccionAdelante && !terminoAnimacion) {
            if ((frameCount - frameInicial) % 5 == 0) { 
              spriteActual++;
              //println(spriteActual);
            }
          }
          if (spriteActual == 6 && direccionAdelante && golpeo == false) {
            infligirDamage(nivel.enemigo, "izquierda");

            golpeo = true;
          }
        }
      } else {
        //println("frame: " + (frameCount - frameInicial));
        if (!golpeandoDerecha) {
          golpeandoDerecha = true;
          //println("Empezo golpe derecha");
          spriteActual = 3;
          //println(spriteActual);
        } else {

          if (spriteActual == 3 && !direccionAdelante && (frameCount - frameInicial) % 5 == 0) {
            spriteActual = 0;
            //println(spriteActual);
            direccionAdelante = true;
            terminoAnimacion = true;
            golpeoDerecha = true;
            golpeandoDerecha = false;
            perfect = false;
            golpeando = false;
            golpeo = false;

            //println("termino golpe derecha");
          }

          if (spriteActual > 3 && !direccionAdelante) {
            if ((frameCount - frameInicial) % 5 == 0) { 
              spriteActual--; 
              //println(spriteActual);
            }
          }

          if (spriteActual == 4 && direccionAdelante && (frameCount - frameInicial) % 5 == 0) {
            direccionAdelante = false;   
            //println("cambia direccion");
          }


          if (spriteActual < 4 && direccionAdelante && !terminoAnimacion) {
            if ((frameCount - frameInicial) % 5 == 0) { 
              spriteActual++;
              //println(spriteActual);
            }
          }
          if (spriteActual == 4 && direccionAdelante && golpeo == false) {
            infligirDamage(nivel.enemigo, "izquierda");

            golpeo = true;
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
      salud = saludMaxima = 4500;

      // Cantidad de imagenes
      pasivoCount = 6;
      golpeandoCount = 6;
      golpeadoCount =  4;
      break;

    case "anubis":
      salud = saludMaxima = 5500;

      // Cantidad de imagenes
      pasivoCount = 7;
      golpeandoCount = 5;
      golpeadoCount =  4;
      break;


    case "xolotl":
      salud = saludMaxima = 7000;

      // Cantidad de imagenes
      pasivoCount = 5;
      golpeandoCount = 9;
      golpeadoCount =  4;
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

      if (frameCount - frameInicial == 7 * 4 && (personaje == "cerbero" || personaje == "xolotl")) {
        nivel.fallar = 30;
        infligirDamage(nivel.jugador, null);
      }

      if (frameCount - frameInicial == 7 * 1 && personaje == "anubis") {
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