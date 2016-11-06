Barra bar;                          // Objeto para la barra
Pelota[] pelotas = new Pelota[6];   // Array para almacenar pelotas

// Objeto para jugador y enemigo
Enemigo enemigo;
Jugador player;

class SistemaPelea {

  float velocidad;
  float velocidadInicial;
  float accel;
  boolean nuevoTurno;

  // Variables sistema de pelea
  int pelotasActual, multiplicador;    

  SistemaPelea(int pelotasInicial) {

    // Se inicializan los objetos del jugador y el enemigo
    player = new Jugador(450, "Zarpazo");
    enemigo = new Enemigo(450, "Xolotl");

    // Inicialización de barra
    bar = new Barra(300, 150, 7, 125);

    // Inicialización de pelotas(máximas)
    for (int i = 0; i < pelotas.length; i++) {
      pelotas[i] = new Pelota(width + 100 * i + i * 25, 100 + 50, int(random(4)));
    }

    // Cantidad de pelotas que va a haber a la vez(inicial)
    pelotasActual = pelotasInicial;

    velocidad = 3;
    velocidadInicial = velocidad;
    accel = 1.00009;
    nuevoTurno = false;
  }

  void pelea() {
    textAlign(LEFT, TOP);

    // Ciclo for para dibujar, mover, activar en colisión y detectar los golpes en las pelotas
    for (int i = 0; i < pelotasActual; i++) {
      pelotas[i].dibujar();
      pelotas[i].mover();
      pelotas[i].activar();
      pelotas[i].golpear();
    }
    // Se dibuja la barra
    bar.dibujar();
  }

  void turno() {
    // Código para los "turnos". Se ejecuta cuando la ultima pelota sale de la pantalla.
    if (pelotas[pelotasActual -1 ].posX <= - 75) {
      for (int i = 0; i < pelotas.length; i++) {
        pelotas[i].cambiarTipo();                     // Se cambia el tipo de pelota
        pelotas[i].restablecer();                     // Se reinicia el estado para que puedan ser activadas nuevamente
        pelotas[i].posX=(width + 100 * i + i * 25);   // Se reinicia la posicion de las pelotas
      }

      // Si el combo es mayor a pelotasActual y pelotasActual es menor a la cantidad máxima de pelotas posible, se incrementa la cantidad de pelotas en uno.
      if (player.combo >= pelotasActual && pelotasActual < pelotas.length)
        pelotasActual++;

      // Si hay combo break se resetea la cantidad ed pelotas
      if ( player.combo < pelotasActual) 
        pelotasActual = 3;

      // Se calculan los daños 
      player.infligirDamage(enemigo);
      enemigo.infligirDamage(player);
    }
  }


  // Onscreen debugging

  void debugging() {  
    textFont(fuenteDebugging);

    if (enemigo.salud < 0) {
      fill(90, 100, 100);
      inicializarFuentes();
      text("GANASTE", width / 2, 100);
      nivel.nivelActual = 0;
      nivel.peleando = false;
    }

    if (player.salud < 0) {
      fill(0, 100, 100);
      inicializarFuentes();
      text("PERDISTE", width / 2, 100);
      nivel.nivelActual = 0;
      nivel.peleando = false;
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
    fill(0, 0, 100);
    text("Ultimo Golpe: " + resultado, 25, height-(height/3));
    text("Daño infligido en el ultimo turno: " + player.damage +  " - Daño recibido en el ultimo turno: " + enemigo.damage, 25, height-(height/3)+30);
    text("Combo jugador: " + player.combo, 25, height-(height/3)+60);
    text("Combo enemigo: " + enemigo.combo, 25, height-(height/3)+90);
    text("HP Jugador: " + player.salud, 25, height-(height/3)+120);  
    text("HP Enemigo: " + enemigo.salud, 25, height-(height/3)+150);
  }
}