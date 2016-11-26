protected class Menu {
  // Datos

  int textoAlpha;
  boolean textoAlphaDireccion;
  float logoPosY, backPosX, backPosY, formaGolpeePosX, textoGolpeePosX;
  PImage background, logo, textoGolpeeComenzar, formaGolpeeComenzar, seleccion, zarpazo, baast, tutorial, tutorialImagen, gameOver; // Fondos
  // Variable para almacenar el nombre del personaje que luego se construirá
  String personaje;
  Leaderboard leaderboard;


  // Booleanos para los fade
  boolean empezo, termino;

  // Objetos para el fade y mover los elementos
  Cortina cortina;
  Ease easeLogo, easeEmpezar;

  // Variables para elegir
  int tiempoInicial;
  boolean millis;
  String actual;

  // Constructor
  Menu() {
    leaderboard = new Leaderboard();
    textoAlpha = 0;
    textoAlphaDireccion=true;

    logoPosY =- 200;
    formaGolpeePosX = width;

    background = loadImage("data/imagenes/menu/background.png");
    logo = loadImage("data/imagenes/menu/logo.png");
    formaGolpeeComenzar = loadImage("data/imagenes/menu/formaGolpeeComenzar.png");
    textoGolpeeComenzar = loadImage("data/imagenes/menu/textoGolpeeComenzar.png");

    // Selección
    seleccion = loadImage("data/imagenes/menu/seleccion/seleccion.png");
    zarpazo = loadImage("data/imagenes/menu/seleccion/zarpazo.png");
    baast = loadImage("data/imagenes/menu/seleccion/baast.png");

    tutorial = loadImage("data/imagenes/menu/tutorial.png");
    tutorialImagen = loadImage("data/imagenes/menu/tutorialImagen.png");
    gameOver = loadImage("data/imagenes/menu/gameover.png");

    cortina = new Cortina(0);
    easeLogo = new Ease();
    easeEmpezar = new Ease();

    tiempoInicial = 0;
    millis = true;
    actual = "";

    termino = true;
  }

  // Función para dibujar el menú
  void principal() {

    fondo();

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
      cortina.activar("out");

      termino = false;
    }
  }

  void seleccion() {

    cortina.activar("in");
    cortina.fadeIn();

    fondo();

    // Se dibuja el fondo(con el personaje seleccionado)
    if (actual == "")
      image(seleccion, 0, 0, width, height);
    if (actual == "azul") 
      image(zarpazo, 0, 0, width, height);
    if (actual == "verde") 
      image(baast, 0, 0, width, height);



    // Se dibuja el fade
    cortina.dibujar();

    // Si se golpea una bolsa(verde o azul) por primera vez, se activa marca un personaje
    if (!empezo && !termino) {
      if (golpe() && millis) {

        if (colorGolpe() == "azul") {
          actual = "azul";
        }
        if (colorGolpe() == "verde") {
          actual = "verde";
        }

        tiempoInicial = millis();
        millis = false;
      }
    }

    // Si no pasaron 5 segundos y más de 350ms se selecciona un personaje 
    if (golpe() && millis() < tiempoInicial + 5000 && millis() > tiempoInicial + 350 && !termino) {
      // Si se golpea dos veces al azul, se selecciona a Zarpazo definitivamente
      if (actual == "azul" && colorGolpe() == "azul" && !millis) {
        personaje = "zarpazo";
        termino = true;
        millis = true;
      }
      // Si se golpea dos veces al verde, se selecciona a Baast definitivamente
      if (actual == "verde" && colorGolpe() == "verde" && !millis) {
        personaje = "baast";
        termino = true;
        millis = true;
      }
      // Si se golpea el verde después del azul, se  Marca a Baast
      if (actual == "azul" &&  colorGolpe() == "verde" && !millis) {
        
        millis = true;
        actual = "verde";
      }
      // Si se golpea el azul después del verde, se marca a Zarpazo
      if (actual == "verde" &&  colorGolpe() == "azul" && !millis) {
        
        millis = true;
        actual = "azul";
      }
      // Si se golpea algún color que no sea ni verde ni azul
      if (actual == "verde" &&  (colorGolpe() == "azul") == false && (colorGolpe() == "verde") == false && !millis) {
        millis = true;
        actual = "";
      }
      if (actual == "azul" &&  (colorGolpe() == "azul") == false && (colorGolpe() == "verde") == false && !millis) {
        millis = true;
        actual = "";
      }
      // Si no se habia golpeando ni la verde ni la azul y se golpea una de estas
      if (actual == "" && colorGolpe() == "azul" && !millis) {
        
        millis = true;
        actual = "azul";
      }
      if (actual == "" && colorGolpe() == "verde`" && !millis) {
        
        millis = true;
        actual = "verde";
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

    fondo();

    image(tutorial, 0, 0, width, height);
    image(tutorialImagen, 0, 0, width, height);

    cortina.dibujar();
    cortina.fadeOut("callejon");

    if (golpe() && termino) {

      
      cortina.activar("out");
    }
  }

  void gameOver() {
    cortina.activar("in");
    cortina.fadeIn();
    imageMode(CORNER);
    image(gameOver, 0, 0, width, height);
    cortina.dibujar();
  }

  private void fondo() {
    // Se dibuja el fondo y se lo mueve para que, al llegar a cierta posición, se recinicie y se mantenga el bucle
    imageMode(CORNER);
    image(background, backPosX, backPosY, 3000, 3000);
    backPosX--;
    backPosY--;

    if (backPosX <= -1500 && backPosY <= -1500) 
      backPosX=backPosY=0;
  }

  class Leaderboard {
    // Datos
    Table tabla;
    String[] jugadores;
    int[] puntajes;

    // Variables para el campo de texto.
    boolean listo;
    boolean nuevoNombre;
    String nombre;

    // Constructor
    Leaderboard() {
      // Se carga el .csv
      tabla = loadTable("leaderboard.csv", "header");

      // println(tabla.getRowCount() + "Cantidad total de filas"); // Debugging

      // Se settea la columna de puntos a int para poder ordenarla, y se ordena
      tabla.setColumnType("Puntos", Table.INT);
      tabla.sortReverse("Puntos");

      jugadores = new String[tabla.getRowCount()];
      puntajes = new int[tabla.getRowCount()];

      // Variables para el campo de texto

      nuevoNombre = false;
      listo = true;
      nombre = "";

      // Se llenan los arreglos de puntajes y jugadores para poder dibujarlos

      for (int i = 0; i < tabla.getRowCount(); i++) {
        TableRow row = tabla.getRow(i);
        puntajes[i] = row.getInt("Puntos");
        //println(puntajes[i]);
        jugadores[i] = row.getString("Jugador");
        //println(jugadores[i]);
      }
    }

    // Métodos
    void dibujar(int posX, int posY, int text) {
      textAlign(CENTER);
      textFont(fuenteNeon);
      int texto = text;
      fill(#e7d37a);
      textSize(texto+10);
      text("PUNTAJES ALTOS", posX, posY-25);

      for (int i = 0; i < 5; i++) {
        textSize(texto);
        textAlign(LEFT);
        text((i + 1) + ". " + jugadores[i], posX-130, posY + texto * i);
        text(" - ", posX, posY + texto * i);
        textAlign(RIGHT);
        text(nf(puntajes[i], 6), posX+130, posY + texto * i);
      }
    }

    void crearCampoTexto() {
      cp5.addTextfield("input")
        .setPosition(width / 2, height /2 )
        .setSize(200, 40)
        .setFont(fuenteJuego)
        .setFocus(true)
        .setColor(color(255, 255, 255));
    }

    void enviar() {
      if (keyPressed && listo)
        if (key == TAB) {
          listo = false;
          nombre = cp5.get(Textfield.class, "input").getText();
          cp5.remove("input");
          nuevoNombre = true;
        }
    }

    void agregarPuntaje(Jugador jugador) {
      if (nuevoNombre == true) {
        TableRow newRow = tabla.addRow();
        newRow.setInt("Puntos", jugador.puntos);
        newRow.setString("Nombre", nombre);

        saveTable(tabla, "leaderboard.csv");
      }
    }
  }
}