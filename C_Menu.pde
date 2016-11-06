class Menu {
  // Datos   

  Menu() {
  }

  void TitleScreen() {
    startScreen.resize(displayWidth, displayHeight);
    image(startScreen, 0, 0);
    text("Presione cualquier tecla para empezar", width/2, height-100);
  }
}