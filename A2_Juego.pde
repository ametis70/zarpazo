private class Juego {
  // Objetos para el menu.
  MenuStart menuStart;
  MenuSeleccion menuSeleccion;
  MenuTutorial menuTutorial;
  MenuGameOver menuGameOver;
  Leaderboard leaderboard;

  // Objetos para los niveles
  Nivel callejon, mansion, oficina;

  // Objetos para las cinemáticas
  Cinematica introduccion, cinematicaOficina, cinematicaMansion, cinematicaFinal;

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

    // A partír de este punto se empiezan a suceder las etapas del juego, pasando por los menues de inicio, una cinematica de introducción al juego, una pantalla de selección de
    // personajes, un tutorial y, a partír de ese punto, comienzan a sucederse, inercalandose, un nivel y una cinemática, hasta que llega al final y se reinicia el juego.

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
        introduccion = new Cinematica("introduccion", 0, 0, 2315.28, 1636.8, 7);

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
      // Se crea el objeto del callejón
      if (callejon == null) 
        callejon = new Nivel("callejon", menuSeleccion.personaje, "cerbero", "cinematicaMansion");

        // Se destruyen los objetos del menú
        if (menuStart != null && menuTutorial != null && menuSeleccion != null && introduccion != null) {
        menuStart = null;
        menuSeleccion = null;
        menuTutorial = null;
        introduccion = null;
      }

      // Se dibuja el nivel
      callejon.dibujar();
      
    } else if (etapaActual == "cinematicaMansion") {
      if (cinematicaMansion == null) 
        cinematicaMansion = new Cinematica("mansion", 0, 0, 2315.28, 1636.8, 7);
      cinematicaMansion.dibujar("mansion");
    } else if (etapaActual == "mansion") {
      // Se crea el objeto de la mansión
      if (mansion == null) 
        mansion = new Nivel("mansion", callejon.jugador.personaje, "anubis", "cinematicaOficina");

      // Se dibuja el nivel
      mansion.dibujar();

      // Se destruye el objeto del callejon y el de la anterior cinemática
      if (callejon != null || introduccion != null) {
        callejon = null;
        introduccion = null;
      }
    } else if (etapaActual == "cinematicaOficina") {
      if (cinematicaOficina == null) 
        cinematicaOficina = new Cinematica("oficina", 0, 0, 2315.28, 1636.8, 7);
      cinematicaOficina.dibujar("oficina");
    } else if (etapaActual == "oficina") {
      // Se crea el objeto de la oficina
      if (oficina == null) 
        oficina = new Nivel("oficina", mansion.jugador.personaje, "xolotl", "cinematicaFinal");

      // Se destruye el objeto de la mansion y de la anterior cinematica
      if (mansion != null || cinematicaMansion != null ||  cinematicaOficina != null) {
        mansion = null;
        cinematicaMansion = null;
        cinematicaOficina = null;
      }
      oficina.dibujar();
    } else if (etapaActual == "cinematicaFinal") {
      if (cinematicaFinal == null) 
        cinematicaFinal = new Cinematica("cinematicaFinal", 0, 0, 2315.28, 1636.8, 7);
      cinematicaFinal.dibujar("victoria");

      if (oficina != null) {
        oficina = null;
      }
    } else if (etapaActual == "victoria") {
      juego = new Juego();
    } else if (etapaActual == "gameover") {
      if (menuGameOver == null)
        menuGameOver = new MenuGameOver();

      menuGameOver.dibujar();
    }
    else {
      println("NO WAY? NO WAY! NO WAY? NO WAY!");
    }
  }


  void debugging() {

    // Si se aprieta "r", se reinicia el juego
    if (key == 'r')
      juego = new Juego();

    // Si se aprieta 1, se va al nivel 1. Lo mismo para los botones 2 y 3.
    if (key == '1') {
      juego.menuSeleccion = new MenuSeleccion();
      juego.menuSeleccion.personaje = "zarpazo";
      juego.etapaActual = "callejon";
    }

    if (key == '2') {
      juego.menuSeleccion = new MenuSeleccion();
      juego.menuSeleccion.personaje = "zarpazo";
      juego.etapaActual = "mansion";
    }

    if (key == '3') {
      juego.menuSeleccion = new MenuSeleccion();
      juego.menuSeleccion.personaje = "zarpazo";
      juego.etapaActual = "oficina";
    }

    // Si se aprieta "k", el enemigo del nivel en el que se este pierde vida hasta quedar en 5.
    if (key == 'k') {
      if (callejon != null) {
        juego.callejon.ui.enemigo.salud = 5;
      }
      if (mansion!= null) {
        juego.mansion.ui.enemigo.salud = 5;
      }
      if (oficina != null) {
        juego.oficina.ui.enemigo.salud = 5;
      }
    }

    // Si se aprieta "j", el jugador pierde vida hasta quedar en 5.
    if (key == 'j') {
      juego.callejon.ui.jugador.salud = 5;
    }
  }
}