class Personaje {
  // Datos
  int salud, saludMaxima, combo, damage, damageActual, tamX, tamY;
  
  // Nombre del personaje. Se utiliza para referenciar al personaje.
  String personaje;
  
  // Imagen para el Sprite. ¿Reemplazar por arreglo para animaciones?
  PImage sprite;

  // Función para infligir daño al enemigo
  void infligirDamage(Personaje personaje) {
    if (combo >= 3) {
      damage = damageActual * combo / 3;
      personaje.salud -= damageActual * combo / 3;
    } else {
      damage = damageActual;
      personaje.salud -= damageActual;
    }
    damageActual = 0;
  }
}

class Jugador extends Personaje {
  //Constructor
  Jugador(int saludInicial, String personaje) {
    combo = damage = damageActual = 0;

    salud = saludMaxima = saludInicial;
    this.personaje = personaje;
  }
}

class Enemigo extends Personaje {
  //Constructor
  Enemigo(int saludInicial, String personaje, int tamX, int tamY) {
    combo = damage = damageActual = 0;
    
    this.tamY = tamY;
    this.tamX = tamX;

    salud = saludMaxima = saludInicial;
    this.personaje = personaje;
    sprite = loadImage("data/imagenes/personajes/" + personaje + ".png");
    
  }
  
  // Métodos
  void dibujar() {
    imageMode(CENTER);
    sprite.resize(tamX, tamY);
    image(sprite, width/2+random(-1, 1), height/2+50+random(-1, 1));
  }
}

// ¿Mover a función dentro de la clase personaje Personaje?

//class Animation {
//  PImage[] images;
//  int imageCount;
//  int frame;

//  Animation(String imagePrefix, int count) {
//    imageCount = count;
//    images = new PImage[imageCount];

//    for (int i = 0; i < imageCount; i++) {
//      // Use nf() to number format 'i' into four digits
//      String filename = imagePrefix + nf(i, 4) + ".gif";
//      images[i] = loadImage(filename);
//    }
//  }

//  void display(float xpos, float ypos) {
//    frame = (frame+1) % imageCount;
//    image(images[frame], xpos, ypos);
//  }

//  int getWidth() {
//    return images[0].width;
//  }
//}