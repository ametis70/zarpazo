class Personaje {
  // Datos
  int salud, saludMaxima, combo, damage, damageActual, tamX, tamY;
  int puntos;

  // Nombre del personaje. Se utiliza para referenciar al personaje.
  String personaje;
  boolean jugador;

  // Imagen para el Sprite. ¿Reemplazar por arreglo para animaciones?
  PImage sprite;

  // Función para infligir daño al enemigo
  void infligirDamage(Personaje personaje) {
    if (this.personaje == "zarpazo") {
      damage = damageActual + int((combo * 1.6));
      personaje.salud -= damageActual + int((combo * 1.6));
    } else if (this.personaje == "baast") {
      damage = damageActual + int((combo * 1.2));
      personaje.salud -= damageActual + int((combo * 1.2));
    } else {
      damage = damageActual + int((combo * 1.4));
      personaje.salud -= damageActual + int((combo * 1.4));
    }
  }
  void comboBreak() {
    if (combo == 0) {
      damageActual = 0;
    }
  }
}


class Jugador extends Personaje {
  //Constructor
  Jugador(int saludInicial, String personaje) {
    combo = damage = damageActual = 0;

    salud = saludMaxima = saludInicial;
    this.personaje = personaje;
    jugador = true;
    puntos = 0;
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
    jugador = false;
  }

  // Métodos
  void dibujar() {
    imageMode(CENTER);
    sprite.resize(tamX, tamY);
    image(sprite, width/2+random(-1, 1), height/2+50+random(-1, 1));
  }
}



class Animation {
  PImage[] pasivo;
  PImage[] golpeando;
  int pasivoCount;
  int golpeandoCount;
  int frame, millis;
  
  boolean termino;

  Animation(String pasivoPrefix, int pasivoCount, String golpeandoPrefix, int golpeandoCount) {
    this.pasivoCount = pasivoCount;
    this.golpeandoCount = golpeandoCount;

    pasivo = new PImage[pasivoCount];
    golpeando = new PImage[pasivoCount];

    for (int i = 0; i < pasivoCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = pasivoPrefix + i + ".png";
      pasivo[i] = loadImage(filename);
    }
    for (int i = 0; i < golpeandoCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = golpeandoPrefix + i + ".png";
      golpeando[i] = loadImage(filename);
    }
  }

  void pasivo(float xpos, float ypos, float xtam, float ytam) {
    if (termino) {
     millis = millis();
     termino = false;
    }
    
    if(millis() <  millis + 100) frame = 1;
    if(millis() <  millis + 100) frame = 1;
    if(millis() <  millis + 100) frame = 1;
    if(millis() <  millis + 100) frame = 1;
    if(millis() <  millis + 100) frame = 1;
  }
}