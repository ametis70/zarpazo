private class Juego {
  // Objetos para el menu.
  MenuStart menuStart;
  MenuSeleccion menuSeleccion;
  MenuTutorial menuTutorial;
  MenuGameOver menuGameOver;
  Leaderboard leaderboard;

  Jugador jugador;

  // Objetos para los niveles
  Nivel callejon, mansion, oficina;

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
    } else if (etapaActual == "introduccion") {
      if (introduccion == null) 
        introduccion = new Cinematica("introduccion", 0, 0, 1316, 751);

      introduccion.dibujar("seleccion");
    } else if (etapaActual == "seleccion") {
      if (menuSeleccion == null)
        menuSeleccion = new MenuSeleccion();

      menuSeleccion.dibujar();
    } else if (etapaActual == "tutorial") {
      if (menuTutorial == null)
        menuTutorial = new MenuTutorial();

      menuTutorial.dibujar();
    } else if (etapaActual == "callejon") {

      if (jugador == null) 
        jugador = new Jugador (menuSeleccion.personaje);

      // Se crea el objeto del callejón
      if (callejon == null) 
        callejon = new Nivel("callejon", jugador.personaje, "cerbero", "mansion");

      // Se destruyen los objetos del menú
      if (menuStart != null || menuTutorial != null || menuSeleccion != null) {
        menuStart = null;
        menuSeleccion = null;
        menuTutorial = null;
      }

      // Se dibuja el nivel
      callejon.dibujar();
    } else if (etapaActual == "mansion") {

      // Se crea el objeto de la mansión
      if (mansion == null) 
        mansion = new Nivel("mansion", jugador.personaje, "anubis", "oficina");

      // Se destruye el objeto del callejon
      if (callejon != null)
        callejon = null;

      // Se dibuja el nivel
      mansion.dibujar();
    } else if (etapaActual == "gameover") {
      if (menuGameOver == null)
        menuGameOver = new MenuGameOver();

      menuGameOver.dibujar();
    } else {
      println("NO WAY? NO WAY! NO WAY? NO WAY!");
    }
  }
  void debugging() {
    if (key == 'r')
      juego = new Juego();

    if (key == '1') {
      juego.menuSeleccion = new MenuSeleccion();
      juego.menuSeleccion.personaje = "zarpazo";
      if (jugador == null) 
        jugador = new Jugador (menuSeleccion.personaje);
      if ( juego.menuSeleccion.personaje != null) 
        juego.menuSeleccion.personaje = null;
      juego.etapaActual = "callejon";
    }

    if (key == '2') {
      juego.menuSeleccion = new MenuSeleccion();
      juego.menuSeleccion.personaje = "zarpazo";
      if (jugador == null) 
        jugador = new Jugador (menuSeleccion.personaje);
      if ( juego.menuSeleccion.personaje != null) 
        juego.menuSeleccion.personaje = null;
      juego.etapaActual = "mansion";
    }

    if (key == 'k') {
      if (callejon != null) {
        juego.callejon.ui.enemigo.salud = 5;
      }
      if (mansion!= null) {
        juego.mansion.ui.enemigo.salud = 5;
      }
    }
    if (key == 'j') {
      juego.callejon.ui.jugador.salud = 5;
    }
  }
}