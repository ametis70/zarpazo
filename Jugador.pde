class Jugador {
  // Datos
  int salud, saludMaxima, combo, damage, damageActual, gato;
  float barraVida, barraVidaAtras;

  //Constructor
  Jugador(int saludInicial, int gatito) {
    combo = damage = damageActual = 0;

    salud = saludMaxima = saludInicial;
    gato = gatito;
    barraVidaAtras = 400;

  }

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
  
  void dibujarBarraJugador(){
    barraVida = map(salud, 0, saludMaxima, 0, barraVidaAtras);
    
    rectMode(CORNER);
    fill(0,0,0);
    rect(50,25,barraVidaAtras,25);
    fill(360,100,100);
    rect(50,25,barraVida,25);
    
  }
  
  
}