class Cinematica {
  int posXcambio, posYcambio;

  Cinematica() {
  }

  void Dibujar (PImage cinematica, int posX, int posY, int tamX, int tamY) {

    posX=posXcambio;
    posY=posYcambio;
    cinematica.resize(tamX, tamY);
    imageMode(CORNER);
    image(cinematica, posX, posY);
  }

}