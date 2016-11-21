class Menu {
  // Datos

  int textoAlpha;
  boolean textoAlphaDireccion;
  float logoPosY, backPosX, backPosY, formaGolpeePosX, textoGolpeePosX;
  PImage background, logo, textoGolpeeComenzar, formaGolpeeComenzar, seleccion, zarpazo, baast, tutorial, tutorialImagen, gameOver; // Fondos
  // Variable para almacenar el nombre del personaje que luego se construirá
  String personaje;


  // Booleanos para los fade
  boolean empezo, termino;

  // Obetos para el fade y mover los elementos
  Cortina cortina;
  Ease easeLogo, easeEmpezar;

  // Musica
  boolean musica;

  // Variables para elegir
  int tiempoInicial;
  boolean millis;
  String actual;

  // Constructor
  Menu( ) {
    textoAlpha = 0;
    textoAlphaDireccion=true;

    logoPosY =- 200;
    formaGolpeePosX = width;

    background = loadImage("data/imagenes/menu/background.png");
    logo = loadImage("data/imagenes/menu/logo.png");
    formaGolpeeComenzar = loadImage("data/imagenes/menu/formaGolpeeComenzar.png");
    textoGolpeeComenzar = loadImage("data/imagenes/menu/textoGolpeeComenzar.png");
    seleccion = loadImage("data/imagenes/menu/seleccion.png");
    zarpazo = loadImage("data/imagenes/menu/zarpazo.png");
    baast = loadImage("data/imagenes/menu/baast.png");
    tutorial = loadImage("data/imagenes/menu/tutorial.png");
    tutorialImagen = loadImage("data/imagenes/menu/tutorialImagen.png");
    gameOver = loadImage("data/imagenes/menu/gameover.png");

    cortina = new Cortina(0);
    easeLogo = new Ease();
    easeEmpezar = new Ease();

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

    // Se dibuja el fondo y se lo mueve para que, al llegar a cierta posición, se recinicie y se mantenga el bucle
    imageMode(CORNER);
    image(background, backPosX, backPosY, 3000, 3000);
    backPosX--;
    backPosY--;

    if (backPosX <= -1500 && backPosY <= -1500) 
      backPosX=backPosY=0;

    imageMode(CENTER);
    image(logo, width/2, logoPosY, 964, 620);


    easeLogo.inicializar(width/2, logoPosY, 964, 620);
    easeLogo.target(width/2, 300);
    easeLogo.easePos(0.05);

    logoPosY = easeLogo.posY;

    imageMode(CORNER);

    image(formaGolpeeComenzar, formaGolpeePosX, height-170, 612, 78);

    easeEmpezar.inicializar(formaGolpeePosX, height-170, 612, 78);
    easeEmpezar.target(width-612, height-170);
    easeEmpezar.easePos(0.09);

    formaGolpeePosX = easeEmpezar.posX;

    if (easeEmpezar.movimiento > -1) {
      pushStyle();
      tint(360, textoAlpha);
      image(textoGolpeeComenzar, width-510, height-150, 431, 36);

      if (textoAlphaDireccion)
        textoAlpha += 5;
      else 
      textoAlpha -= 5;

      if (textoAlpha >= 255 || textoAlpha <= 0)
        textoAlphaDireccion  = !textoAlphaDireccion;

      popStyle();
    }

    leaderboard.dibujar(250, height-170, 24);

    cortina.dibujar();
    cortina.fadeOut("introduccion");

    // Si se presiona una tecla, oscurecer y pasar a la cinemática 1.
    if (golpe() && termino && easeEmpezar.movimiento > -1) {
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

    // Se dibuja el fondo y se lo mueve para que, al llegar a cierta posición, se recinicie y se mantenga el bucle
    imageMode(CORNER);
    image(background, backPosX, backPosY, 3000, 3000);
    backPosX--;
    backPosY--;

    if (backPosX <= -1500 && backPosY <= -1500) 
      backPosX=backPosY=0;

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

    // Se dibuja el fondo y se lo mueve para que, al llegar a cierta posición, se recinicie y se mantenga el bucle
    imageMode(CORNER);
    image(background, backPosX, backPosY, 3000, 3000);
    backPosX--;
    backPosY--;

    if (backPosX <= -1500 && backPosY <= -1500) 
      backPosX=backPosY=0;

    image(tutorial, 0, 0, width, height);
    image(tutorialImagen, 0, 0, width, height);

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