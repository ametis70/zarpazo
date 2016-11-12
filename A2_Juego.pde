class Juego {
  
  // Se crean los objetos para el Menu, nivel y cinemática. Estos se reconstruyen para mostrar todos lose segmentos del juego
  Menu menu;
  Nivel callejon;
  Cinematica introduccion;

  String etapaActual;

  // Constructor
  Juego() {
    menu = new Menu();
    callejon = new Nivel("data/imagenes/niveles/escenario1.jpg", "zarpazo", 450, "cerbero", 450);
    introduccion = new Cinematica("data/imagenes/cinematicas/cinematica1.jpg", 0, 0, 1280, 904);

    // El juego comienza en el menú. Los diferentes valores se escriben en minúscula.
    etapaActual = "menu";
  }

  // Función para empezar a dibujar el juego
  void dibujar() {
    if (etapaActual == "menu") {
      menu.dibujar();
    }
    
    if (etapaActual == "introduccion") {
      introduccion.dibujar();
    }
    
    if (etapaActual == "callejon") {
      callejon.dibujar();
    }
  }
}