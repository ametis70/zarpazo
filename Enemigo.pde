class Enemigo {
  // Datos
  int salud, saludMaxima, combo, damage, damageActual, perro;
  float barraVida, barraVidaAtras;


  //Constructor
  Enemigo(int saludInicial, int perrito) {
    combo = damage = damageActual = 0;

    salud = saludMaxima = saludInicial;
    perro = perrito;
    barraVidaAtras = 400;
  }

  // Función para infligir daño al jugador
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

  void dibujarBarraEnemigo() {
    barraVida = map(salud, 0, saludMaxima, 0, barraVidaAtras);

    rectMode(CORNERS);
    fill(0, 0, 0);
    rect(width-50, 25, width-50-barraVidaAtras, 50);
    fill(270, 100, 100);
    rect(width-50, 25, width-50-barraVida, 50);
  }
}