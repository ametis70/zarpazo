class Cinematica {
  // Datos
  int alpha;
  float posX, posY;
  float tamX, tamY;
  float targetX, targetY;
  PImage cinematica;
  int movimiento;
  boolean listo;

  // Variables para oscurecer la pantalla
  boolean oscuro, termino;

  // Variables para la confirmación
  int tiempoInicial;
  boolean millis;


  // Constructor
  Cinematica(String directorio, float posX, float posY, float tamX, float tamY) {
    this.posX = targetX = posX;
    this.posY = targetY = posY;
    this.tamX = tamX;
    this.tamY = tamY;
    cinematica = loadImage(directorio);
    listo = false;
    movimiento = 100;
    alpha = 255;
    oscuro = true;
    termino = false;

    millis = true;
  }

  // Métodos
  void dibujar () {
    // La pantalla comienza oscura,
    if (oscuro && alpha > 0) 
      alpha -= 5;

    // Cuando ya no está oscura, comienza el movimiento
    if (oscuro && !termino && alpha <= 0) { 
      movimiento = 0;
      oscuro = false;
    }

    // Se dibuja el comic
    background(0, 0, 100);
    image(cinematica, posX, posY, tamX, tamY);

    // Se dibuja el cuadrado negro
    fill(0, alpha);
    rect(0, 0, width, height);

    // Función para hacer aparecer el dialogo de confirmación
    confirmacion();

    // Si la cinematica termino(o se salteó), oscurecer la pantalla
    if (termino && alpha < 255) 
      alpha += 5;

    if (termino && alpha >= 255) 
      juego.etapaActual = "callejon";
  }

  // Se cambia el objetivo(tanto para posición como tamaño. Mover con ease)
  void target(float targetX, float targetY) {
    listo = true;
    this.targetX = targetX;
    this.targetY = targetY;
  }

  // El valor por default de easing es debería ser 0.05. Ajustar según el tiempo
  void easePos(float easing) {
    float dx = targetX - posX;  // Variable para la distancia en X. Se resta la posición actual a donde queremos llegar.
    posX += dx * easing;        // Se actualiza la posición con una velocidad determinada por la variable easing.

    float dy = targetY - posY;  // Variable para la distancia en X. Se resta la posición actual a donde queremos llegar.
    posY += dy * easing;        // Se actualiza la posición con una velocidad determinada por la variable easing.
    if (listo) {
      if ( dist(posX, posY, targetX, targetY) <= 1) {
        movimiento++;
        listo = false;
      }
    }
  }

  void easeTam(float easing) {
    float dx = targetX - tamX;  // Variable para la distancia en X. Se resta la posición actual a donde queremos llegar.
    tamX += dx * easing;        // Se actualiza la posición con una velocidad determinada por la variable easing.

    float dy = targetY - tamY;  // Variable para la distancia en X. Se resta la posición actual a donde queremos llegar.
    tamY += dy * easing;        // Se actualiza la posición con una velocidad determinada por la variable easing.
    if (listo) {
      if ( dist(tamX, tamY, targetX, targetY) <= 1) {
        movimiento++;
        listo = false;
      }
    }
  }

  // Confirmación
  void confirmacion() {
    if (oscuro == false && termino == false) {
      if (keyPressed & millis) {
        tiempoInicial = millis();
        millis = false;
      }
    }

    if (millis == false) {

      textAlign(RIGHT, BOTTOM);
      textFont(fuenteNeon);
      textSize(32);
      fill(0, 100);
      rectMode(CORNER);
      noStroke();
      rect(width - 665, height -50, 665, 50);
      fill(0, 0, 100);
      text("Golpea nuevamente para saltear la escena", width - 10, height - 10);
    }

    // Si no pasaron 3 segundos
    if (keyPressed && millis() < tiempoInicial + 3000 && millis() > tiempoInicial + 1000) {
      termino = true;
      millis = true;
    }


    if (millis() > tiempoInicial + 3000) {
      millis = true;
      tiempoInicial = 0;
    }
  }



  // Métodos propios de cada cinemática
  void introduccion() {
    if (movimiento == 0) {  
      target(500, 500);
      easePos(0.05);
    }
    if (movimiento == 1) {
      target(0, 600);
      easePos(0.05);
    }
    if (movimiento == 2) {
      target(500, 0);
      easePos(0.05);
    }
    if (movimiento == 3) {
      target(0, 0);
      easePos(0.05);
    }
    if (movimiento == 4) {
      target(1920, 1356);
      easeTam(0.05);
    }
    if (movimiento == 5) {
      target(-500, -500);
      easePos(0.05);
    }
    if (movimiento == 6) {
      termino = true;
    }
  }
}