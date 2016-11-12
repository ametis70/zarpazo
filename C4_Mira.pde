class Mira {
  // Datos 
  float posX, posY; 
  int tamX, tamY; 

  // Constructor
  Mira(float posicionX, float posicionY, int barX, int barY) {
    posX = posicionX;
    posY = posicionY;

    tamX = barX;
    tamY = barY;
  }

  // Función para dibujar la mira 
  void dibujar() {
    pushStyle();
    ellipseMode(CENTER);
    noFill();
    strokeWeight(6);
    stroke(0,0, 100);

    ellipse(posX, posY, tamY, tamY);
    popStyle();
  }
}