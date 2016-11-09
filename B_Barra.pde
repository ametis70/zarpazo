class Barra {
  // Datos 
  float posX, posY; 
  int tamX, tamY; 

  // Constructor
  Barra(float posicionX, float posicionY, int barX, int barY) {
    posX = posicionX;
    posY = posicionY;

    tamX = barX;
    tamY = barY;
  }

  // Función para dibujar la barra 
  void dibujar() {
    fill(0, 0, 100);
    noStroke();
    rectMode(CENTER);
    rect(posX, posY, tamX, tamY);
  }
}