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
  }

  // Métodos
  void dibujar(String proxima) {
    cortina.fadeIn();

    if (cortina.listo == true && empezo) {
      ease.movimiento = 1;
      empezo = false;
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
      case "introduccion":
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
      case "cinematicaOficina":
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
      case "cinematicaFinal":
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
      }
    }
  }
}