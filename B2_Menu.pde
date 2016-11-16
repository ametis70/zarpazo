class Menu {
  // Datos

  PImage background, seleccion, zarpazo, baast, tutorial, gameOver; // Fondos
  // Variable para almacenar el nombre del personaje que luego se construirá
  String personaje;

  // Booleanos para los fade
  boolean empezo, termino;

  // Obetos para el fade y mover los elementos
  Cortina cortina;
  Ease ease;

  // Musica
  boolean musica;

  // Variables para elegir
  int tiempoInicial;
  boolean millis;
  String actual;

  // Constructor
  Menu( ) {
    background = loadImage("data/imagenes/menu/background.png");
    seleccion = loadImage("data/imagenes/menu/seleccion.png");
    zarpazo = loadImage("data/imagenes/menu/zarpazo.png");
    baast = loadImage("data/imagenes/menu/baast.png");
    tutorial = loadImage("data/imagenes/menu/tutorial.png");
    gameOver = loadImage("data/imagenes/menu/gameover.png");

    cortina = new Cortina(0);

    tiempoInicial = 0;
    millis = true;
    actual = "";

    musica = true;

    termino = true;
  }

  // Función para dibujar el menú
  void principal(Leaderboard leaderboard) {
    if (musica) {
      way.loop();
      musica = false;
    }

    background.resize(displayWidth, displayHeight);
    image(background, 0, 0);

    leaderboard.dibujar(400, 200, 24);

    cortina.dibujar();
    cortina.fadeOut("introduccion");

    // Si se presiona una tecla, oscurecer y pasar a la cinemática 1.
    if (golpe() && termino) {
      way.pause();
      select.trigger();
      cortina.activar("out");
      termino = false;
    }
  }

  void seleccion() {
    if (musica) {
      way.loop();
      musica = false;
    }
    cortina.activar("in");
    cortina.fadeIn();

    // Se dibuja el fondo(con el personaje seleccionado)
    if (actual == "")
      image(seleccion, 0, 0, width, height);
    if (actual == "azul") 
      image(zarpazo, 0, 0, width, height);
    if (actual == "naranja") 
      image(baast, 0, 0, width, height);


    // Se dibuja el fade
    cortina.dibujar();

    // Si se golpea una bolsa(naranja o azul) por primera vez, se activa marca un personaje
    if (!empezo && !termino) {
      if (golpe() && millis) {

        if (colorGolpe() == "azul") {
          select.trigger(); 
          actual = "azul";
        }
        if (colorGolpe() == "naranja") {
          select.trigger(); 
          actual = "naranja";
        }

        tiempoInicial = millis();
        millis = false;
      }
    }

    // Si no pasaron 5 segundos y más de 350ms se selecciona un personaje 
    if (golpe() && millis() < tiempoInicial + 5000 && millis() > tiempoInicial + 350 && !termino) {
      // Si se golpea dos veces al azul, se selecciona a Zarpazo definitivamente
      if (actual == "azul" && colorGolpe() == "azul" && !millis) {
        select.trigger();
        personaje = "zarpazo";
        termino = true;
        millis = true;
      }
      // Si se golpea dos veces al naranja, se selecciona a Baast definitivamente
      if (actual == "naranja" && colorGolpe() == "naranja" && !millis) {
        select.trigger();
        personaje = "baast";
        termino = true;
        millis = true;
      }
      // Si se golpea el naranja después del azul, se  Marca a Baast
      if (actual == "azul" &&  colorGolpe() == "naranja" && !millis) {
        select.trigger();
        millis = true;
        actual = "naranja";
      }
      // Si se golpea el azul después del naranja, se marca a Zarpazo
      if (actual == "naranja" &&  colorGolpe() == "azul" && !millis) {
        select.trigger();
        millis = true;
        actual = "azul";
      }
      // Si se golpea algún color que no sea ni naranja ni azul
      if (actual == "naranja" &&  (colorGolpe() == "azul") == false && (colorGolpe() == "naranja") == false && !millis) {
        millis = true;
        actual = "";
      }
      if (actual == "azul" &&  (colorGolpe() == "azul") == false && (colorGolpe() == "naranja") == false && !millis) {
        millis = true;
        actual = "";
      }
      // Si no se habia golpeando ni la naranja ni la azul y se golpea una de estas
      if (actual == "" && colorGolpe() == "azul" && !millis) {
        select.trigger();
        millis = true;
        actual = "azul";
      }
      if (actual == "" && colorGolpe() == "naranja" && !millis) {
        select.trigger();
        millis = true;
        actual = "naranja";
      }
    }

    // Si pasaron 5 segundos, se reestablece
    if (millis() > tiempoInicial + 5000) {
      millis = true;
      actual = "";
    }

    // Si se seleccionó un personaje, oscurecer la pantalla
    if (termino) {
      cortina.activar("out");
      cortina.fadeOut("tutorial");
    }
  }

  void tutorial() {

    cortina.activar("in");
    cortina.fadeIn();

    image(tutorial, 0, 0, width, height);

    cortina.dibujar();

    cortina.fadeOut("callejon");

    if (golpe() && termino) {
      way.pause();
      select.trigger();
      cortina.activar("out");
      termino = false;
    }
  }

  void gameOver() {
    cortina.activar("in");
    cortina.fadeIn();

    imageMode(CORNER);
    image(gameOver, 0, 0, width, height);

    cortina.dibujar();
  }
}