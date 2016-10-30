class Jugador {
  // Datos
  int salud, combo, damage, damageActual, gato;

  //Constructor
  Jugador(int saludInicial, int gatito) {
    combo = damage = damageActual = 0;

    salud = saludInicial;
    gato = gatito;
  }

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