class Juego {
  // Objetos para el menu.
  MenuStart menuStart;
  MenuSeleccion menuSeleccion;
  MenuTutorial menuTutorial;
  MenuGameOver menuGameOver;
  Leaderboard leaderboard;

  // Ojbetos para los niveles
  Nivel callejon, patio, oficina;

  // Objetos para las cinemáticas
  Cinematica introduccion;

  // String para determinar en que etapa se encuentra el juego
  String etapaActual;

  // Constructor
  Juego() {
    // El juego comienza en el menú. Los diferentes valores se escriben en minúscula.
    etapaActual = "menuStart";
  }

  // Función para empezar a dibujar el juego
  void dibujar() {
    // Eventos de Arduino. Ejecutar durante todo el juego
    eventoSerial();

    if (etapaActual == "menuStart") {
      // Si el objeto menú no se creó todavía, este se crea. También el del Leaderboard
      if (menuStart == null) {
        leaderboard = new Leaderboard();
        menuStart = new MenuStart(leaderboard);
      }

      // Se dibuja el menú
      menuStart.dibujar();
    }

    if (etapaActual == "introduccion") {
      if (introduccion == null) 
        introduccion = new Cinematica("introduccion", 0, 0, 1316, 751);

      introduccion.dibujar("seleccion");
    }

    if (etapaActual == "seleccion") {
      if (menuSeleccion == null)
        menuSeleccion = new MenuSeleccion();

      menuSeleccion.dibujar();
    }

    if (etapaActual == "tutorial") {
      if (menuTutorial == null)
        menuTutorial = new MenuTutorial();

      menuTutorial.dibujar();
    }

    if (etapaActual == "callejon") {
      // Se crea el objeto del callejón
      if (callejon == null) 
        callejon = new Nivel("callejon", menuSeleccion.personaje, 5000, "cerbero", 7000);

      // Se destruyen los objetos del menú
      if (menuStart != null || menuSeleccion != null || menuTutorial != null) {
        menuStart = null;
        menuSeleccion = null;
        menuTutorial = null;
      }

      // Se dibuja el nivel
      callejon.dibujar();
    }

    if (etapaActual == "gameover") {
      if (menuGameOver == null)
        menuGameOver = new MenuGameOver();

      menuGameOver.dibujar();
    }
  }
}