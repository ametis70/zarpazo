class Menu {
  // Datos
  PImage background;

  // Constructor
  Menu() {
    background = loadImage("data/imagenes/menu/background.png");
  }

  // Función para dibujar el menú
  void dibujar() {
    background.resize(displayWidth, displayHeight);
    image(background, 0, 0);


    // Si se presiona una tecla, ir a la etapa del callejón. Debería ser cinemática 1.
    if (keyPressed)
      juego.etapaActual = "callejon";
  }
}