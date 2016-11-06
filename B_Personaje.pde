class Personaje {
  // Datos
  int salud, saludMaxima, combo, damage, damageActual;
  String animal;

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