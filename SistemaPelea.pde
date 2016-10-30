Barra bar;                          // Objeto para la barra
Pelota[] pelotas = new Pelota[6];   // Array para almacenar pelotas

Enemigo enemigo;
Jugador player;

class SistemaPelea {

  // Variables sistema de pelea
  int pelotasActual, multiplicador;    

  SistemaPelea(int pelotasInicial) {
    
    player = new Jugador(1000, 0);
    enemigo = new Enemigo(1000, 0);

    // Inicialización de barra
    bar = new Barra(0, height / 2, 7, height / 3, 3);

    // Inicialización de pelotas(máximas)
    for (int i = 0; i < pelotas.length; i++) {
      pelotas[i] = new Pelota(200 + 100 * i + i * 25, height / 2, int(random(4)));
    }

    // Cantidad de pelotas que va a haber a la vez(inicial)
    pelotasActual = pelotasInicial;
  }

  void pelea() {
    textAlign(LEFT, TOP);
    // Ciclo for para dibujar las pelotas
    for (int i = 0; i < pelotasActual; i++) {
      pelotas[i].dibujar();
      pelotas[i].activar();
      pelotas[i].golpear();
    }
    bar.dibujar();
    bar.mover(); 
  }

  void turno() {

    // Código para los "turnos". Se ejecuta cuando la barra sale de la pantalla.
    if (bar.posX >= width + 4) {
      for (int i = 0; i < pelotasActual; i++) {
        pelotas[i].cambiarTipo();  // Se cambia el tipo de pelota
        pelotas[i].restablecer();  // Se reinicia el estado para que puedan ser activadas nuevamente
      }

      // Se incrementa la cantidad de pelotas en 1 si el combo es mayor a la cantidad de pelotas actual.
      if (player.combo >= pelotasActual && pelotasActual < pelotas.length) {
        pelotasActual++;
      }
      // Se reinicia la cantidad de pelotas a 3 si hay combo break.
      if ( player.combo < pelotasActual) {
        pelotasActual = 3;
      }

      // Calculos de daño y salud para el jugador y enemigo
      player.infligirDamage();
      enemigo.infligirDamage();

      bar.posX = -7; // Cuando la barra cruza la pantalla, se resetea su posición
    }
  }

  // Onscreen debugging

  void debugging() {  
    fuenteJuego = createFont("Arial", 12);

    if (enemigo.salud < 0) {
      fill(90, 100, 100);
      text("GANASTE", width / 2, 100);
    }

    if (player.salud < 0) {
      fill(0, 100, 100);
      text("PERDISTE", width / 2, 100);
    }

    // Texto de controles
    fill(0 * 90, 100, 100);
    text("A - Rojo", 25, 100);
    fill(1 * 90, 100, 100);
    text("S - Verde", 25, 130);
    fill(2 * 90, 100, 100);
    text("D - Azul", 25, 160);
    fill(3 * 90, 100, 100);
    text("F - Violeta", 25, 190);

    // Texto informativo
    fill(0, 100, 100);
    text("Ultimo Golpe: " + resultado, 25, height-(height/3));
    text("Daño infligido en el ultimo turno: " + player.damage +  " - Daño recibido en el ultimo turno: " + enemigo.damage, 25, height-(height/3)+30);
    text("Combo: " + player.combo, 25, height-(height/3)+60);
    text("Combo: " + enemigo.combo, 25, height-(height/3)+90);
    text("HP Jugador: " + player.salud, 25, height-(height/3)+120);  
    text("HP Enemigo: " + enemigo.salud, 25, height-(height/3)+150);
  }
}