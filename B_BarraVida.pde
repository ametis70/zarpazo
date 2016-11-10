// Hay que agarrar lo que sirve de la barra de manu y combinarla con la nuestra. Que quede una sola clase.

//class BarraVida {
//  float saludActual, ancho, alto;  
//  BarraVida() {
//    ancho = 400;
//    alto = 25;
//  }

//  void dibujar(Personaje personaje, int modo, color color1, color color2, float x, float y) {

//    // Se elige el personaje, y desde donde se dibujara el rectangulo
//    saludActual = map(personaje.salud, 0, personaje.saludMaxima, 0, ancho);
//    rectMode(modo);

//    // Se dibuja la barra vacia(atrás)
//    fill(color1);
//    if (modo == CORNER)
//      rect(x, y, ancho, alto);        // Jugador
//    if (modo == CORNERS) 
//      rect(x, y, x - ancho, alto+25);          // Enemigo

//    // Se dibuja la barra con la vida(arriba)
//    fill(color2);
//    if (modo == CORNER)
//      rect(x, y, saludActual, alto);  // Jugador
//    if (modo == CORNERS)
//      rect(x, y, x-saludActual, alto+25);  // Enemigo
//  }
//}


class BarraVida {

  PImage fondo;
  PImage relleno;

  PImage retrato;

  boolean revertido = false;

  BarraVida(String nombrePersonaje,String nombreImgRelleno) {
    retrato = loadImage("grafikks/retrato-" + nombrePersonaje + ".png");
    fondo = loadImage("grafikks/" + nombreImgRelleno + "-vacio.png");
    relleno = loadImage("grafikks/" + nombreImgRelleno + "-lleno.png");

  }

  BarraVida(String nombrePersonaje,String nombreImgRelleno,boolean revertido) {
    this(nombrePersonaje,nombreImgRelleno);
    this.revertido = revertido;
  }


  void dibujar(float posX1, float posY1,float posX2,float posY2,int hp,int hpMax) {
    imageMode(CORNERS);
    image(fondo,posX1,posY1,posX2,posY2);

    if (revertido) clip(posX1,posY1,posX2,map(hp,0,hpMax,posY1,posY2));   
    else clip(posX1,map(hp,0,hpMax,posY2,posY1),posX2,posY2);

    image(relleno,posX1,posY1,posX2,posY2);

    noClip();
    imageMode(CENTER);
    if (!revertido) image(retrato,(posX2+posX1)/2,posY2,100,100);
    else image(retrato,(posX2+posX1)/2,posY1,100,100);

  }


}