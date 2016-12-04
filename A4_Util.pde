// Utilidades utilizadas en todo el juego

// Rectangulo negro para hacer transiciones entre etapas
class Cortina {
  // Datos
  int alpha;
  boolean oscureciendo, aclarando, listo;

  // Constructor
  Cortina(int alpha) {
    this.alpha = alpha; // Usar valores 0, si se empieza claro y 255 si se empieza oscuro
    if (alpha == 255)
      aclarando = true;
    else aclarando = false;
    oscureciendo = listo = false;
  }

  // Métodos
  void dibujar() {
    fill(0, alpha);
    rectMode(CORNER);
    rect(0, 0, width, height);
  }

  // Permitir un fadeIn o Out
  void activar(String tipo) {
    if ( listo)
      if (tipo == "in" && alpha >= 255)
        aclarando = true;
    if (tipo == "out" && alpha <= 0) 
      oscureciendo = true;

    listo = false;
  }

  void fadeIn() {
    // Se comienza a aclarar
    if (aclarando && alpha > 0) 
      alpha -= 5;

    // Cuando está clara, se devuelve el control al jugador para la etapa
    if (aclarando && alpha <= 0) { 
      aclarando = false;
      listo = true;
    }
  }

  void fadeOut(String etapa) {
    // Se comienza a oscurecer
    if (oscureciendo && alpha < 255) 
      alpha += 5;

    // Cuando se termina de oscurecer, se cambia de etapa
    if (oscureciendo && alpha >= 255) {
      oscureciendo = false;
      juego.etapaActual = etapa;
      listo = true;
    }
  }
}

// Easing

class Ease {
  // Datos
  boolean listo, inicializado;
  float posX, posY, tamX, tamY, targetX, targetY;
  int movimiento;

  // Constructor
  Ease() {
    listo = inicializado = false;
    posX = posY = tamX = tamY = targetX = targetY = 0;
    movimiento = -1; // Iniciar movimiento externamente.
  }

  // Métodos

  // Se le da el mismo valor al posX y posY del ease que a lo que va a mover 
  void inicializar(float posX, float posY, float tamX, float tamY) {
    if (inicializado == false) {
      this.posX = posX;
      this.posY = posY;
      this.tamX = tamX;
      this.tamY = tamY;
      inicializado = true;
    }
  }

  // Se cambia el objetivo(tanto para posición como tamaño. Mover con ease)
  void target(float targetX, float targetY) {
    listo = true;
    this.targetX = targetX;
    this.targetY = targetY;
  }

  // El valor por default de easing debería ser 0.05. Ajustar según el tiempo
  void easePos(float easing) {
    float dx = targetX - posX;  // Variable para la distancia en X. Se resta la posición actual a donde queremos llegar.
    posX += dx * easing;        // Se actualiza la posición con una velocidad determinada por la variable easing.

    float dy = targetY - posY;  // Variable para la distancia en X. Se resta la posición actual a donde queremos llegar.
    posY += dy * easing;        // Se actualiza la posición con una velocidad determinada por la variable easing.
    if (listo && dist(posX, posY, targetX, targetY) <= 1) {
      movimiento++;
      listo = false;
    }
  }

  void easeTam(float easing) {
    float dx = targetX - tamX;  // Variable para la distancia en X. Se resta la posición actual a donde queremos llegar.
    tamX += dx * easing;        // Se actualiza la posición con una velocidad determinada por la variable easing.

    float dy = targetY - tamY;  // Variable para la distancia en X. Se resta la posición actual a donde queremos llegar.
    tamY += dy * easing;        // Se actualiza la posición con una velocidad determinada por la variable easing.
    if (listo && dist(tamX, tamY, targetX, targetY) <= 1) {
      movimiento++;
      listo = false;
    }
  }
}

// Clase para las particulas de los golpes acertados
class SistemaParticulas {
  // Datos
  Particula[] particulas;  // Arreglo de particulas
  float posX, posY;        // Origen en X e Y

  int cantidad;            // Cantidad de particulas. Depende de que tan certero sea el golpe, se asignará un número mayor

  SistemaParticulas(float posX, float posY, int cantidad, int tipo) {
    this.posX = posX;
    this.posY = posY;

    this.cantidad = cantidad;
    particulas = new Particula[cantidad];

    for (int i = 0; i < particulas.length; i++) {
      particulas[i] = new Particula(posX, posY, tipo);
    }
  }

  void dibujar() {
    for (int i = 0; i < particulas.length; i++) {
      particulas[i].dibujar();
    }
  }
}

// Clase para particulas individuales. Ver SistemaParticulas.
class Particula {
  float posX, posY;
  float tam;
  float velX, velY, accel;
  float rotacion;

  float alpha, lifespan;

  PImage estrella;

  Particula(float posX, float posY, int tipo) {
    this.posX = posX;
    this.posY = posY;

    if (tipo == 0)
      estrella = loadImage("data/imagenes/ui/particula/azul.png");
    else if (tipo == 1)
      estrella = loadImage("data/imagenes/ui/particula/verde.png");
    else if (tipo == 2)
      estrella = loadImage("data/imagenes/ui/particula/rojo.png");
    else
      estrella = loadImage("data/imagenes/ui/particula/particula.png");

    tam = random(15, 35);

    // Rotación en eje Z con translate() y rotate()    rotacion = random(0, 360);  // Rotación inicial

    // Velocidad y aceleración. Determinan la dirección.
    velX = random(-2.5, 2.5);
    velY = random(-2.5, 2.5);
    accel = 1.01;

    // Valor inicial para el tiempo de vida. Si se exceden los 1500, la estrella se deja de referenciar
    lifespan = millis();
  }

  void dibujar() {
    // Se actualiza, se aplican las transformaciones y se dibuja la estrella solo si el lifespan no se excedió
    if ( millis() < lifespan + 1500) {
      actualizar();
      pushStyle();
      imageMode(CENTER);
      tint(360, alpha);

      pushMatrix();
      transformar();
      image(estrella, 0, 0, tam, tam);
      popMatrix();
      popStyle();
    }
  }

  void actualizar() {
    // Se suma la acerleración a la variable que se pasa a rotate().
    rotacion += accel;

    // Posición en X
    velX *= accel;
    posX += velX;

    // Posición en Y
    velY *= accel;
    posY += velY;

    // Se mappea el alpha al tiempo de vida de la estrella
    alpha = map(millis(), lifespan, lifespan + 1500, 255, 0);
  }
  void transformar() {
    // Se mueve el origen en X e Y alcentro de la estrella y esta se rota. Utilizar en conjunto con pushMatrix y popMatrix.
    translate(posX, posY);
    rotate(radians(rotacion));
  }
}