class BarraVida {
  // Datos
  float posX1, posY1, posX2, posY2, damageClip;  
  PImage fondo, relleno, retrato, damage; 
  boolean enemigo;

  // Constructor 
  BarraVida(Personaje personaje, int posX1, int posY1, int posX2, int posY2) {
    this.posX1 = posX1;
    this.posX2 = posX2;
    this.posY1 = posY1;
    this.posY2 = posY2;

    if (personaje.jugador)
      enemigo = false;
    else
      enemigo = true;

    retrato = loadImage("data/imagenes/ui/barras/retrato-" + personaje.personaje + ".png");
    fondo = loadImage("data/imagenes/ui/barras/vacio.png");
    damage = loadImage("data/imagenes/ui/barras/damage.png");
    relleno = loadImage("data/imagenes/ui/barras/hp.png");
    //if (enemigo) 
    //  relleno = loadImage("data/imagenes/ui/barras/enemigo-lleno.png");
    //else
    //  relleno = loadImage("data/imagenes/ui/barras/jugador-lleno.png");
  }

  // Método para dibujar la barra
  void dibujar(Personaje personaje, Personaje contrario) {
    imageMode(CORNERS);

    // Barra vacia
    image(fondo, posX1, posY1, posX2, posY2);

    // Se guarda la posición del primer golpe del combo para la barra de daño
    if (contrario.combo == 0) {
      if (enemigo)
        damageClip = map(personaje.salud, 0, personaje.saludMaxima, posY1, posY2);   
      else 
      damageClip = map(personaje.salud, 0, personaje.saludMaxima, posY2, posY1);
    }

    if (enemigo)
      clip(posX1, posY1, posX2, damageClip);   
    else 
    clip(posX1, damageClip, posX2, posY2);

    image(damage, posX1, posY1, posX2, posY2);

    noClip();


    // Si es enemigo, el clip es de abajo para arriba. Si es jugador, al revés
    if (enemigo)
      clip(posX1, posY1, posX2, map(personaje.salud, 0, personaje.saludMaxima, posY1, posY2));   
    else 
    clip(posX1, map(personaje.salud, 0, personaje.saludMaxima, posY2, posY1), posX2, posY2);




    // Barra con vida
    image(relleno, posX1, posY1, posX2, posY2);

    noClip();

    // Se dibuja el retrato
    imageMode(CENTER);
    if (!enemigo)
      image(retrato, (posX2 + posX1) / 2, posY2, 100, 100);
    else 
    image(retrato, (posX2 + posX1)/2, posY1, 100, 100);
  }
}