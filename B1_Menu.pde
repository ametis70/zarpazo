class Menu {
  // Datos
  PImage background;
  boolean oscuro;
  int alpha;

  // Constructor
  Menu() {
    alpha =  0;
    background = loadImage("data/imagenes/menu/background.png");
  }

  // Función para dibujar el menú
  void dibujar() {
    background.resize(displayWidth, displayHeight);
    image(background, 0, 0);

    fill(0, alpha);
    rect(0, 0, width, height);

    // Si se presiona una tecla, oscurecer y pasar a la cinemática 1.
    if (keyPressed) 
      oscuro = true;

    if (oscuro && alpha < 255) 
      alpha += 5;

    if (alpha >= 255) 
      juego.etapaActual = "introduccion";
  }
}