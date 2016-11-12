class Cinematica {
  // Datos
  float posX, posY;
  float tamX, tamY;
  float targetX, targetY;
  PImage cinematica;
  boolean listo;
  int movimiento;

  // Constructor
  Cinematica(String directorio, float posX, float posY, float tamX, float tamY) {
    this.posX = targetX = posX;
    this.posY = targetY = posY;
    this.tamX = tamX;
    this.tamY = tamY;
    cinematica = loadImage(directorio);
    listo = true;
    movimiento = 0;
  }

  // Métodos
  void dibujar () {
    image(cinematica, posX, posY, tamX, tamY);
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
}


/* Codigo de ejemplo

if (cinematica.movimiento == 0) {  
  cinematica.target(500, 500);
  cinematica.easePos(0.05);
}
if (cinematica.movimiento == 1) {
  cinematica.target(0, 600);
  cinematica.easePos(0.05);
}
if (cinematica.movimiento == 2) {
  cinematica.target(500, 0);
  cinematica.easePos(0.05);
}
if (cinematica.movimiento == 3) {
  cinematica.target(0, 0);
  cinematica.easePos(0.05);
}
if (cinematica.movimiento == 4) {
  cinematica.target(1920, 1356);
  cinematica.easeTam(0.05);
}
if (cinematica.movimiento == 5) {
  cinematica.target(-500, -500);
  cinematica.easePos(0.05);
}
*/