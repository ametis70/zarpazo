class SistemaPelea {
  float velocidad;
  float velocidadInicial;
  float accel;
  boolean nuevoTurno;
  PImage preparado, listo, ya, imagenActiva;
  boolean preparadoListo, listoListo, todoListo;
  int tamImagen, transparencia;


  Mira mira;          // Objeto para la mira
  Pelota[] pelotas;   // Array para almacenar pelotas

  int posX, posY, ancho, alto;

  // Variables sistema de pelea
  int pelotasActual, pelotasInicial, cantidad, multiplicador;    

  SistemaPelea(int posX, int posY, int ancho, int alto) {

    // Inicialización de barra
    mira = new Mira(width/2, posY + alto / 2, 7, 80);

    preparado = loadImage("data/imagenes/ui/preparacion/preparado.png");
    listo = loadImage("data/imagenes/ui/preparacion/listo.png");
    ya = loadImage("data/imagenes/ui/preparacion/ya.png");
    imagenActiva = preparado;
    preparadoListo=true;

    this.posX = posX;
    this.posY = posY;
    this.alto = alto;
    this.ancho = ancho;

    tamImagen=300;
    transparencia=300;

    cantidad = abs(ceil((posX - ancho) / 80));
    println(cantidad);

    pelotas = new Pelota[cantidad]; 

    // Inicialización de pelotas(máximas)
    for (int i = 0; i < pelotas.length; i++) {
      pelotas[i] = new Pelota(ancho + 100 * i + i * int(random(10, 25)), posY + alto / 2, int(random(4)));
    }

    // Cantidad de pelotas que va a haber a la vez(inicial)
    pelotasActual = pelotasInicial = cantidad;

    velocidad = 3;
    velocidadInicial = velocidad;
    accel = 1.00009;
    nuevoTurno = false;
  }

  void pelea(Nivel nivel) {
    if (todoListo==true) {
      fill(0, 0, 0, 50);
      pushStyle();
      textAlign(LEFT, TOP);
      imageMode(CORNER);
      clip(posX, posY, ancho, alto);
      noStroke();
      rectMode(CORNER);
      popStyle();
      rect(posX, posY, ancho, alto);
      // Ciclo for para dibujar, mover, activar en colisión y detectar los golpes en las pelotas
      for (int i = 0; i < pelotas.length; i++) {
        pelotas[i].dibujar();
        pelotas[i].mover(nivel.jugador, this);
        pelotas[i].activar(mira);
        pelotas[i].golpear(nivel.enemigo, nivel.jugador, mira);
      }
    }

    // Se dibuja la Mira
    mira.dibujar();
    noClip();
  }

  void turno(Nivel nivel) {
    // Código para los "turnos". Se ejecuta cuando la ultima pelota sale de la pantalla.
    if (pelotas[pelotas.length -1 ].posX <= (posX - 100)) {
      for (int i = 0; i < pelotas.length; i++) {
        pelotas[i].cambiarTipo();                     // Se cambia el tipo de pelota
        pelotas[i].restablecer();                     // Se reinicia el estado para que puedan ser activadas nuevamente
        pelotas[i].posX=(width + 100 * i + i * int(random(10, 25)));   // Se reinicia la posicion de las pelotas
      }

      // Si el combo es mayor a pelotasActual y pelotasActual es menor a la cantidad máxima de pelotas posible, se incrementa la cantidad de pelotas en uno.
      if (nivel.jugador.combo >= pelotasActual && pelotasActual < pelotas.length)
        pelotasActual++;

      // Si hay combo break se resetea la cantidad ed pelotas
      if ( nivel.jugador.combo < pelotasActual) 
        pelotasActual = 3;

      // Se calculan los daños 
      nivel.jugador.infligirDamage(nivel.enemigo);
      nivel.enemigo.infligirDamage(nivel.jugador);

      //if (jugador.salud <= 0) { 
      //  nivel.etapaActual = 0;
      //  nivel.peleando = false;
      //}
      //if ( enemigo.salud <= 0) { 
      //  nivel.etapaActual+=2;
      //  nivel.peleando = false;
      //}
    }
  }

  void preparacion() {
    
    pushStyle();

    imageMode(CENTER);
    tint(255, transparencia);
    image(imagenActiva, width/2, height/2, tamImagen, tamImagen*0.4);
    tamImagen+=10;
    transparencia-=7;

    popStyle();

    if (transparencia<=0 && preparadoListo== true) {
      transparencia=200;
      tamImagen=300;
      imagenActiva=listo;
      preparadoListo=false;
      listoListo=true;
    }
    if (transparencia<=0 && listoListo== true) {
      transparencia=200;
      tamImagen=300;
      imagenActiva=ya;
      listoListo=false;
      todoListo=true;
    }
    if (transparencia<=0 && todoListo== true) {
      listoListo=false;
    }
  }
}