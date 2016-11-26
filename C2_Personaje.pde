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
  String personaje;


  String estado;

  boolean terminoP, terminoG;

  Animation(String personaje, int pasivoCount, int golpeandoCount) {
    this.pasivoCount = pasivoCount;
    this.golpeandoCount = golpeandoCount;

    pasivo = new PImage[pasivoCount];
    golpeando = new PImage[golpeandoCount];
    this.personaje = personaje;

    frame = 0;
    terminoP = true;
    terminoG = true;

    estado = "pasivo";

    for (int i = 0; i < pasivoCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = "data/imagenes/personajes/" + personaje + "/pasivo/"+ i + ".png";
      pasivo[i] = loadImage(filename);
    }
    for (int i = 0; i < golpeandoCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = "data/imagenes/personajes/" + personaje + "/golpeando/" + i + ".png";
      golpeando[i] = loadImage(filename);
    }
  }

  void dibujar(float posX, float posY, float tamX, float tamY) {
    if (estado == "pasivo") {
      pasivo(); 
      imageMode(CENTER);
      image(pasivo[frame], posX, posY, tamX, tamY);
    }
    if (estado == "golpeando") {
      golpeando();
      imageMode(CENTER);
      image(golpeando[frame], posX, posY, tamX, tamY);
    }
  }

  void pasivo() {
    if (terminoP) {
      millis = millis();
      terminoP = false;
    }    
    if (!terminoP) {
      if (millis() <  millis + 100) frame = 0;
      if (millis() >  millis + 100 && millis() < millis + 200) frame = 1;
      if (millis() >  millis + 200 && millis() < millis + 300) frame = 2;
      if (millis() >  millis + 300 && millis() < millis + 400) frame = 3;
      if (millis() >  millis + 400 && millis() < millis + 500) frame = 4;
      if (millis() >  millis + 500 && millis() < millis + 600) frame = 3;
      if (millis() >  millis + 600 && millis() < millis + 700) frame = 2;
      if (millis() > millis + 700) terminoP = true;
    }
  }
  void golpeando() {
    if (terminoG) {
      millis = millis();
      terminoG = false;
    }    
    if (terminoG == false) {
      if (millis() <  millis + 50) frame = 0;
      if (millis() >  millis + 50 && millis() < millis + 100) frame = 1;
      if (millis() >  millis + 100 && millis() < millis + 150) frame = 2;
      if (millis() >  millis + 150 && millis() < millis + 200) frame = 3;
      if (millis() >  millis + 250 && millis() < millis + 300) frame = 4;
      if (millis() >  millis + 350 && millis() < millis + 400) frame = 5;
      if (millis() >  millis + 450 && millis() < millis + 500) frame = 6;
      if (millis() >  millis + 550 && millis() < millis + 600) frame = 7;
      
      if (millis() > millis + 600) {

        terminoP = true;
        estado = "pasivo";
      }
    }
  }
}