private class Juego {

  // Se crean los objetos para el Menu, nivel y cinemática. Estos se reconstruyen para mostrar todos los segmentos del juego
  Menu menu;
  Nivel callejon;
  Cinematica introduccion;


  String etapaActual;

  // Constructor
  Juego() {
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
      menu.principal();
    } else if (etapaActual == "introduccion") {
      introduccion.dibujar("seleccion");
    } else if (etapaActual == "seleccion") {
      menu.seleccion();
    } else if (etapaActual == "tutorial") {
      menu.tutorial();
    } else if (etapaActual == "callejon") {
      callejon.dibujar();
    } else {
      menu.gameOver();
    }
  }
}