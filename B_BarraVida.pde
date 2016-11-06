class BarraVida {
  float saludActual, ancho, alto;  
  BarraVida() {
    ancho = 400;
    alto = 25;
  }

  void dibujar(Personaje personaje, int modo, color color1, color color2, float x, float y) {

    // Se elige el personaje, y desde donde se dibujara el rectangulo
    saludActual = map(personaje.salud, 0, personaje.saludMaxima, 0, ancho);
    rectMode(modo);

    // Se dibuja la barra vacia(atrás)
    fill(color1);
    if (modo == CORNER)
      rect(x, y, ancho, alto);        // Jugador
    if (modo == CORNERS) 
    rect(x, y, x - ancho, alto+25);          // Enemigo

    // Se dibuja la barra con la vida(arriba)
    fill(color2);
    if (modo == CORNER)
      rect(x, y, saludActual, alto);  // Jugador
    if (modo == CORNERS)
    rect(x, y, x-saludActual, alto+25);  // Enemigo
  }
}