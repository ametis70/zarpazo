class Personaje {
  // Datos
  int salud, saludMaxima, combo, damage, damageActual;
  String animal;

  // Función para infligir daño al enemigo
  void infligirDamage() {
    if (combo >= 3) {
      damage = damageActual * combo / 3;
      enemigo.salud -= damageActual * combo / 3;
    } else {
      damage = damageActual;
      enemigo.salud -= damageActual;
    }
    damageActual = 0;
  }
}


class BarraVida {
  float barraVida, barraVidaAtras;
  BarraVida() {
    barraVidaAtras = 400;
  }

/*

  void dibujar(Personaje personaje,int modo, color color1, int x1,int y1,int x2,int y2, int x3,int y3,int x4,int y4) {

    barraVida = map(personaje.salud, 0, personaje.saludMaxima, 0, barraVidaAtras);
    rectMode(modo);
    fill(0, 0, 0);
    rect(x1, y1, barraVidaAtras, y2);
    fill(360, 100, 100);
    rect(50, 25, barraVida, 25);
  }
}


/* void dibujarBarraJugador() {
 barraVida = map(salud, 0, saludMaxima, 0, barraVidaAtras);
 
 rectMode(CORNER);
 fill(0, 0, 0);
 rect(50, 25, barraVidaAtras, 25);
 fill(360, 100, 100);
 rect(50, 25, barraVida, 25);
 }
 
 
 void dibujarBarraEnemigo() {
 barraVida = map(salud, 0, saludMaxima, 0, barraVidaAtras);
 
 rectMode(CORNERS);
 fill(0, 0, 0);
 rect(width-50, 25, width-50-barraVidaAtras, 50);
 fill(270, 100, 100);
 rect(width-50, 25, width-50-barraVida, 50);
 }
 
 */


class Jugador extends Personaje {
  //Constructor
  Jugador(int saludInicial, String animalito) {
    combo = damage = damageActual = 0;

    salud = saludMaxima = saludInicial;
    animal = animalito;
  }
}

class Enemigo extends Personaje {
  //Constructor
  Enemigo(int saludInicial, String animalito) {
    combo = damage = damageActual = 0;

    salud = saludMaxima = saludInicial;
    animal = animalito;
  }
}