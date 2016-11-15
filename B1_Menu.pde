class Menu {
  // Datos
  PImage background, seleccion, zarpazo, baast;
  boolean oscuro, millis, termino;
  int alpha, tiempoInicial;
  String personaje;
  char actual;

  // Constructor
  Menu( ) {
    alpha =  0;
    background = loadImage("data/imagenes/menu/background.png");
    seleccion = loadImage("data/imagenes/menu/seleccion.png");
    zarpazo = loadImage("data/imagenes/menu/zarpazo.png");
    baast= loadImage("data/imagenes/menu/baast.png");

    actual = 'x'; // Valor default
  }

  // Función para dibujar el menú
  void principal(Leaderboard leaderboard) {
    background.resize(displayWidth, displayHeight);
    image(background, 0, 0);

    fill(0, alpha);
    rect(0, 0, width, height);

    leaderboard.dibujar();

    // Si se presiona una tecla, oscurecer y pasar a la cinemática 1.
    if (keyPressed) 
      oscuro = true;

    if (oscuro && alpha < 255) 
      alpha += 5;

    if (alpha >= 255) {
      oscuro = true;
      juego.etapaActual = "introduccion";
    }
  }

  void seleccion() {
    // La pantalla comienza oscura.
    if (oscuro && alpha > 0) 
      alpha -= 5;

    // Cuando ya no está oscura, comienza el movimiento
    if (oscuro && alpha <= 0) { 
      oscuro = false;
    }

    if (actual == 'x')
      image(seleccion, 0, 0, width, height);
    if (actual == 's') 
      image(zarpazo, 0, 0, width, height);
    if (actual == 'd') 
      image(baast, 0, 0, width, height);


    if (oscuro == false && termino == false) {
      if (keyPressed & millis) {
        actual = key;
        tiempoInicial = millis();
        millis = false;
      }
    }

    // Si no pasaron 5 segundos y se presiona la misma tecla, esta se selecciona 
    if (keyPressed && millis() < tiempoInicial + 5000 && millis() > tiempoInicial + 250) {
      if (actual == 's' && key == 's' || key == 'S') {
        personaje = "zarpazo";
        termino = true;
        millis = true;
      }
      if (actual == 's' && key == 'd' || key == 'D') {
        actual = 'd';
      }
      if (actual == 'd' && key == 'd' || key == 'D') {
        personaje = "baast";
        termino = true;
        millis = true;
      }
      if (actual == 'd' && key == 's' || key == 'S') {
        actual = 's';
      }
    }

    // Si pasaron 5 segundos, se reestablece
    if (millis() > tiempoInicial + 5000) {
      millis = true;
      tiempoInicial = 0;
      actual = 'x';

      // Si se seleccionó un personaje, oscurecer la pantalla
      if (termino && alpha < 255) 
        alpha += 5;

      if (termino && alpha >= 255) 
        juego.etapaActual = "callejon";
    }
  }
}