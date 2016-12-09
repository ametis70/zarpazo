class Cinematica {
  // Datos

  // Variables para la posición
  float posX, posY;
  float tamX, tamY;
  float targetX, targetY;

  // Imagenes
  PImage comic;
  PImage[] dialogos;

  // Variables para los dialogos
  int alpha, frameInicial;
  boolean aparecer, mostrando, desaparecer;

  // Booleanos para los fade
  boolean empezo, termino;

  // Obetos para el fade y mover el comic
  Cortina cortina;
  Ease ease;

  // Variables para saltear
  int tiempoInicial;
  boolean millis;

  boolean musica;


  // Constructor
  Cinematica(String comic, float posX, float posY, float tamX, float tamY, int cantidadDialogos) {
    this.posX = targetX = posX;
    this.posY = targetY = posY;
    this.tamX = tamX;
    this.tamY = tamY;
    this.comic = loadImage("data/imagenes/cinematicas/" + comic + "/comic.png");
    termino = false;
    empezo = true;

    aparecer = true;

    dialogos = new PImage[cantidadDialogos];

    for (int i = 0; i < dialogos.length; i++) {
      dialogos[i] = loadImage("data/imagenes/cinematicas/" + comic + "/dialogos/" + i + ".png");
    }

    millis = true;

    cortina = new Cortina(255);
    ease = new Ease();

    musica = true;
  }

  // Métodos
  void dibujar(String proxima) {



    cortina.fadeIn();

    if (cortina.listo == true && empezo) {
      ease.movimiento = 1;
      empezo = false;
    }


    if (juego.etapaActual == "cinematicaMansion") {
      if (musica) {
        reunited.loop();
        musica = false;
      }
    }

    if (juego.etapaActual == "cinematicaOficina") {
      if (musica) {
        privateeye.loop();
        musica = false;
      }
    }
    if (juego.etapaActual == "cinematicaFinal") {
      if (musica) {
        takeachance.loop();
        musica = false;
      }
    }

    // Se dibuja el comic
    background(0, 0, 100);
    image(comic, posX, posY, tamX, tamY);

    mover();

    // Función para hacer aparecer el dialogo de confirmación
    saltear();

    cortina.dibujar();

    if (termino) {
      cortina.activar("out");
      cortina.fadeOut(proxima);
    }
  }

  // Función para saltear la escena
  void saltear() {
    // Si se golpea por primera vez se activa el cuadro de confirmación 
    if (cortina.listo == true && empezo == false && millis == true) {
      if (golpe()) {
        select.trigger();
        tiempoInicial = millis();
        millis = false;
      }
    }

    // Se dibuja el cuadrado y el texto de confirmación
    if (millis == false) {
      textAlign(RIGHT, BOTTOM);
      textFont(fuenteNeon);
      textSize(32);
      fill(0, 100);
      rectMode(CORNER);
      noStroke();
      rect(width - 665, height -50, 665, 50);
      fill(0, 0, 100);
      text("Golpea nuevamente para saltear la escena", width - 10, height - 10);
    }

    // Si no pasaron 3 segundos(pero pasaron mas de 250ms) y se golpea nuevamente, se saltea la escena
    if (golpe() && millis() < tiempoInicial + 3000 && millis() > tiempoInicial + 250 && !termino) {
      select.trigger();
      discomedusae.pause();
      reunited.pause();
      privateeye.pause();
      termino = true;
    }

    // Si pasaron 3 segundos, el cuadrado de confirmación desaparece
    if (millis() > tiempoInicial + 3000) {
      millis = true;
      tiempoInicial = 0;
    }
  }

  // Atajo para hacer el Easing.
  void ease(int movimiento, float targetX, float targetY, String tipo) {
    // Si no se inicializó, se hace esto primero;
    ease.inicializar(posX, posY, tamX, tamY);

    // Se realiza uno u otro movimiento
    if (ease.movimiento == movimiento) {  
      // Se cambia el target
      ease.target(targetX, targetY);

      // Según el tipo, se actualiza la posición o tamaño del ease
      if (tipo == "pos") ease.easePos(0.05);
      if (tipo == "tam") ease.easeTam(0.05);

      // Se actualizan las variables de la cinemática según las del ease
      if (tipo == "pos") { 
        posX = ease.posX; 
        posY = ease.posY;
      }
      if (tipo == "tam") { 
        tamX = ease.tamX; 
        tamY = ease.tamY;
      }
    }
  }

  void dialogo(int dialogo, int frames, float posX, float posY) {

    if (ease.listo == false) {
      if (aparecer) {
        alpha += 15;
        if (alpha >= 255) {
          aparecer = false;
          frameInicial = frameCount;
        }
      }

      pushStyle();
      tint(360, alpha);
      imageMode(CORNER);
      image(dialogos[dialogo], posX, posY);
      popStyle();

      if (aparecer == false && (frameCount - frameInicial) > frames) {
        desaparecer = true;
      }

      if (desaparecer == true) {
        alpha -= 15; 
        if ( alpha <= 0) {
          aparecer = true;
          desaparecer = false;
          ease.movimiento++;
        }
      }
    }
  }



  // Función con un solo parámetro para determinar el movimiento final
  void ease(int movimiento) {
    if (ease.movimiento == movimiento) {
      termino = true;
    }
  }

  // Métodos propios de cada cinemática
  void mover() {
    if (!empezo && !termino) {
      //println(ease.movimiento);  // Debugging

      switch (juego.etapaActual) { 
      case "cinematicaCallejon":
        //movimiento, targetX, targetY, tipo
        ease(1, 3580, 2480, "tam");
        if (ease.movimiento == 1)
          dialogo(0, 200, 243, 194);   //  Izquierda y derecha
        ease(2, -272, -180, "pos");
        if (ease.movimiento == 2 && ease.listo == false)
          ease.movimiento++;
        ease(3, -828, -138, "pos");
        if (ease.movimiento == 3)
          dialogo(1, 200, 400, 40);    // Jugoso atún
        ease(4, -20, -895, "pos");
        if (ease.movimiento == 4)
          dialogo(2, 100, 525, 75);    // Vengar a mi hermano
        ease(5, -210, -1580, "pos");
        if (ease.movimiento == 5 && ease.listo == false)
          ease.movimiento++;
        ease(6, -756, -1420, "pos");
        if (ease.movimiento == 6 && ease.listo == false)
          ease.movimiento++;
        ease(7, -1700, -150, "pos");
        if (ease.movimiento == 7 && ease.listo == false)
          ease.movimiento++;
        ease(8, -2190, -150, "pos");
        if (ease.movimiento == 8 && ease.listo == false)
          ease.movimiento++;
        ease(9, -1490, -1170, "pos");
        if (ease.movimiento == 9)
          dialogo(3, 60, 550, 25);    // La mafia!
        ease(10, -1960, -953, "pos");
        if (ease.movimiento == 10) 
          dialogo(4, 80, 400, 100);   // Nos llevaremos esto
        ease(11, -1960, -953, "pos");
        if (ease.movimiento == 11) 
          dialogo(5, 80, 600, 175);   // ¡Teniamos un trato!
        ease(12, -2150, -1000, "pos");
        if (ease.movimiento == 12 && ease.listo == false)
          ease.movimiento++;
        ease(13, -1535, -1714, "pos");
        if (ease.movimiento == 13) 
          dialogo(6, 80, 350, 300);     // ¡Espera, Baast!
        ease(14, -2180, -1695, "pos");
        if (ease.movimiento == 14 && ease.listo == false)
          ease.movimiento++;
        ease(15);

        break;
      case "cinematicaMansion":
        //movimiento, targetX, targetY, tipo

        ease(1, 2917, 2066.5, "tam");

        if (ease.movimiento == 1 && ease.listo == false )
          ease.movimiento++;

        ease(2, 0, -130, "pos");

        if (ease.movimiento == 2)
          dialogo(0, 80, 439, 60);       //  "Mataste a mi hermano"

        ease(3, 0, -130, "pos");

        if (ease.movimiento == 3)
          dialogo(1, 80, 700, 192);        // "No tuve elección"

        ease(4, 0, -130, "pos");

        if (ease.movimiento == 4)
          dialogo(2, 80, 100, 120);        // "El no tuvo elección"

        ease(5, -880, -380, "pos");

        if (ease.movimiento == 5 && ease.listo == false)
          ease.movimiento++;

        ease(6, -880, -380, "pos");

        if (ease.movimiento == 6)
          dialogo(3, 250, 220, 51);        // "Las peleas están arregladas(...)"

        ease(7, -880, -380, "pos");

        if (ease.movimiento == 7)
          dialogo(4, 150, 220, 51);          // "El se rehusó(...)"

        ease(8, -1550, 0, "pos");

        if (ease.movimiento == 8 )
          dialogo(5, 80, 530, 0);         // "¿Por qué sabotearon(...)?"

        ease(9, -1550, -0, "pos");

        if (ease.movimiento == 9)
          ease.movimiento++;

        ease(10, -1550, -360, "pos");

        if (ease.movimiento == 10)
          dialogo(6, 300, 532, 31);       // "Estas en la misma situación(...)"

        ease(11, -1550, -360, "pos");
        if (ease.movimiento == 11  && ease.listo == false) 
          ease.movimiento++;

        ease(12, 0, -1060, "pos");

        if (ease.movimiento == 12 && ease.listo == false) 
          dialogo(7, 80, 25, 11);     // "Quiero una revancha justa de la pelea"

        ease(13, -140, -1000, "pos");

        if (ease.movimiento == 13)
          dialogo(8, 60, 571, 100);     // "Ya habrá tiempo para eso"

        ease(14, -860, -1240, "pos");

        if (ease.movimiento == 14  && ease.listo == false)
          ease.movimiento++;

        ease(15, -1540, -1160, "pos");

        if (ease.movimiento == 15  && ease.listo == false) 
          ease.movimiento++;

        ease(16);
        break;

      case "cinematicaOficina":
        //movimiento, targetX, targetY, tipo

        ease(1, 2472, 1865, "tam");

        if (ease.movimiento == 1 && ease.listo == false )
          ease.movimiento++;

        ease(2, 0, -300, "pos");

        if (ease.movimiento == 2 && ease.listo == false)
          ease.movimiento++;

        ease(3, -1040, -180, "pos");

        if (ease.movimiento == 3)
          dialogo(0, 60, 394, 37);       //  "¡Vamos!"

        ease(4, 0, -1040, "pos");

        if (ease.movimiento == 4)
          dialogo(1, 120, 56, 29);      // "Bueno(...)"

        ease(5, 0, -1040, "pos");

        if (ease.movimiento == 5)
          dialogo(2, 120, 500, 84);      // "No estare"

        ease(6, 0, -1040, "pos");

        if (ease.movimiento == 6)
          dialogo(3, 80, 56, 29);        // "¡Por Cyro!"

        ease(7, -420, -1060, "pos");

        if (ease.movimiento == 7 && ease.listo == false)
          ease.movimiento++;

        ease(8, -1300, -960, "pos");

        if (ease.movimiento == 8 && ease.listo == false)
          ease.movimiento++;

        ease(9, -1300, -960, "pos");

        if (ease.movimiento == 9)
          dialogo(4, 60, 578, 44);        // "Aqui está(...)"

        ease(10, -1300, -960, "pos");

        if (ease.movimiento == 10 && ease.listo == false)
          ease.movimiento++;

        ease(11);
        break;
      case "cinematicaFinal":
        //movimiento, targetX, targetY, tipo
        ease(1, 0, -40, "pos");

        if (ease.movimiento == 1 && ease.listo == false)
          ease.movimiento++;

        ease(2, 5349.778, 3677.17, "tam");

        if (ease.movimiento == 2 && ease.listo == false)
          ease.movimiento++;

        ease(3, -1380, -180, "pos");

        if (ease.movimiento == 3 && ease.listo == false)
          ease.movimiento++;

        ease(4, -2140, -180, "pos");

        if (ease.movimiento == 4 && ease.listo == false)
          ease.movimiento++;

        ease(5, -1640, -1020, "pos");

        if (ease.movimiento == 5 && ease.listo == false)
          ease.movimiento++;

        ease(6, -2340, -1020, "pos");

        if (ease.movimiento == 6 && ease.listo == false)
          ease.movimiento++;
        ease(7, -980, -60, "pos");

        if (ease.movimiento == 7 && ease.listo == false)
          ease.movimiento++;

        ease(8, 2345.268, 1612.02, "tam");

        if (ease.movimiento == 8 && ease.listo == false)
          ease.movimiento++;

        ease(9, 0, -820, "pos");

        if (ease.movimiento == 9 && ease.listo == false)
          dialogo(0, 200, 46, 34);                          // "Se acabo, Xolotl(...)"

        ease(10, 0, -820, "pos");

        if (ease.movimiento == 10 && ease.listo == false)
          dialogo(1, 150, 397, 12);                         // "Gatos hediondos(...)"

        ease(11, 0, -820, "pos");

        if (ease.movimiento == 11 && ease.listo == false)
          dialogo(2, 180, 46, 34);                          // "!Basta!"

        ease(12, -260, -820, "pos");

        if (ease.movimiento == 12 && ease.listo == false)
          ease.movimiento++;

        ease(13, -980, -820, "pos");

        if (ease.movimiento == 13 && ease.listo == false)
          ease.movimiento++;

        ease(14);

        break;
      }
    }
  }
}