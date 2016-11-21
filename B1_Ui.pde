// Diferentes clases para elementos de la interfaz

// Mira utilizada en el sistema pelea en conjunto con Pelota
class Mira {
  // Datos 
  float posX, posY; 
  int tamX, tamY; 

  // Constructor
  Mira(float posicionX, float posicionY, int barX, int barY) {
    posX = posicionX;
    posY = posicionY;

    tamX = barX;
    tamY = barY;
  }

  // Función para dibujar la mira 
  void dibujar() {
    pushStyle();
    ellipseMode(CENTER);
    noFill();
    strokeWeight(6);
    stroke(0, 0, 100);

    ellipse(posX, posY, tamY, tamY);
    popStyle();
  }
}

// Barras para indicar la cantidad de vida de cada personaje
class BarraVida {
  // Datos
  float posX1, posY1, posX2, posY2, damageClip;  
  PImage fondo, relleno, retrato, damage; 
  boolean enemigo;

  // Constructor 
  BarraVida(Personaje personaje, int posX1, int posY1, int posX2, int posY2) {
    this.posX1 = posX1;
    this.posX2 = posX2;
    this.posY1 = posY1;
    this.posY2 = posY2;

    if (personaje.jugador)
      enemigo = false;
    else
      enemigo = true;

    retrato = loadImage("data/imagenes/ui/barras/retrato-" + personaje.personaje + ".png");
    fondo = loadImage("data/imagenes/ui/barras/vacio.png");
    damage = loadImage("data/imagenes/ui/barras/damage.png");
    relleno = loadImage("data/imagenes/ui/barras/hp.png");
    //if (enemigo) 
    //  relleno = loadImage("data/imagenes/ui/barras/enemigo-lleno.png");
    //else
    //  relleno = loadImage("data/imagenes/ui/barras/jugador-lleno.png");
  }

  // Método para dibujar la barra
  void dibujar(Personaje personaje, Personaje contrario) {
    imageMode(CORNERS);

    // Barra vacia
    image(fondo, posX1, posY1, posX2, posY2);

    // Se guarda la posición del primer golpe del combo para la barra de daño
    if (contrario.combo == 0) {
      if (enemigo)
        damageClip = map(personaje.salud, 0, personaje.saludMaxima, posY1, posY2);   
      else 
      damageClip = map(personaje.salud, 0, personaje.saludMaxima, posY2, posY1);
    }

    if (enemigo)
      clip(posX1, posY1, posX2, damageClip);   
    else 
    clip(posX1, damageClip, posX2, posY2);

    image(damage, posX1, posY1, posX2, posY2);

    noClip();


    // Si es enemigo, el clip es de abajo para arriba. Si es jugador, al revés
    if (enemigo)
      clip(posX1, posY1, posX2, map(personaje.salud, 0, personaje.saludMaxima, posY1, posY2));   
    else 
    clip(posX1, map(personaje.salud, 0, personaje.saludMaxima, posY2, posY1), posX2, posY2);




    // Barra con vida
    image(relleno, posX1, posY1, posX2, posY2);

    noClip();

    // Se dibuja el retrato
    imageMode(CENTER);
    if (!enemigo)
      image(retrato, (posX2 + posX1) / 2, posY2, 100, 100);
    else 
    image(retrato, (posX2 + posX1)/2, posY1, 100, 100);
  }
}

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

  // El valor por default de easing es debería ser 0.05. Ajustar según el tiempo
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