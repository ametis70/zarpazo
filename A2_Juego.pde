class Juego {

  // Se crean los objetos para el Menu, nivel y cinemática. Estos se reconstruyen para mostrar todos los segmentos del juego
  Menu menu;
  Nivel callejon;
  Cinematica introduccion;
  Leaderboard leaderboard;

  String etapaActual;

  // Constructor
  Juego() {
    leaderboard = new Leaderboard();
    menu = new Menu();
    callejon = new Nivel("callejon", "zarpazo", 5000, "cerbero", 7000);
    introduccion = new Cinematica("introduccion", 0, 0, 1316, 751);

    // El juego comienza en el menú. Los diferentes valores se escriben en minúscula.
    etapaActual = "menu";
  }

  // Función para empezar a dibujar el juego
  void dibujar() {
    eventoSerial();
    if (etapaActual == "menu") {
      menu.principal(leaderboard);
    }

    if (etapaActual == "introduccion") {
      menu.musica = true;
      introduccion.dibujar("seleccion");
    }

    if (etapaActual == "seleccion") {
      menu.seleccion();
    }

    if (etapaActual == "tutorial") {
      menu.tutorial();
    }

    if (etapaActual == "callejon") {
      callejon.dibujar();
    }

    if (etapaActual == "gameover") {
      menu.gameOver();
    }

    if (etapaActual == "reiniciar") {
      setup();
    }
  }
}