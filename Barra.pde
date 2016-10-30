class Barra {
  // Datos 
  float posX, posY, barVelocidad, barVelocidadInicial, barAccel; 
  int tamX, tamY; 

  // Constructor
  Barra(float posicionX, float posicionY, int barX, int barY, float velocidad) {
    posX = posicionX;
    posY = posicionY;
    tamX = barX;
    tamY =  barY;
    barVelocidad = barVelocidadInicial = velocidad;

    barAccel = 1.0009;
  }

  void dibujar() {
    fill(255);
    noStroke();
    rect(posX, posY, tamX, tamY);
  }

  void mover() {
    if (player.combo == 0) 
      barVelocidad = barVelocidadInicial;   // Si hay combo break, se reinicia la velocidad
    if (barVelocidad <= 7) 
      barVelocidad *= barAccel;             // Si la velocidad es menor a 7, ésta se multiplica por la aceleración
      
    posX += barVelocidad;
  }
  
}