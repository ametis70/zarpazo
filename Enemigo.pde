class Enemigo {
  // Datos
  int salud, combo, damage, damageActual, perro;

  //Constructor
  Enemigo(int saludInicial, int perrito) {
    combo = damage = damageActual = 0;

    salud = saludInicial;
    perro = perrito;
  }

  void infligirDamage() {
    if (combo >= 3) {
      damage = damageActual * combo / 3;
      player.salud -= damageActual * combo / 3;
    } else {
      damage = damageActual;
      player.salud -= damageActual;
    }
    damageActual = 0;
  }
}