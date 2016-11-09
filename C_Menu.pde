class Menu {
  // Datos   

  Menu() {
  }

  void TitleScreen() {
    pushStyle();
    startScreen.resize(displayWidth, displayHeight);
    image(startScreen, 0, 0);
    textFont(fuenteMenu);
    text("Presione cualquier tecla para empezar", width/2, height-100);
    popStyle();
    
  }
}