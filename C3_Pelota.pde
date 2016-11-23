String resultado; // Esta variable es para el debugging onscreen

class Pelota {
  // Datos

  float posX, posY;
  boolean activa, fueActiva, golpeada;
  String resultado;
  int tipo, tam, alpha;

  // Variables para el feedback
  sistemaParticulas sp;

  boolean direccion;
  int contador;

  // Constructor
  Pelota(float posicionX, float posicionY, int type) { 
    tam = 80;
    activa = fueActiva = golpeada = false;

    posX = posicionX;
    posY = posicionY;
    tipo = type;

    contador = 20;
    direccion = true;
  }

  // Función para dibujar los circulos.
  void dibujar() {
    imageMode(CENTER);
    if (tipo == 0) {
      image(circuloRojo, posX, posY, tam, tam);
    }
    if (tipo == 1) {
      image(circuloAzul, posX, posY, tam, tam);
    }
    if (tipo == 2) {
      image(circuloVerde, posX, posY, tam, tam);
    }
    //if (tipo == 3) {
    //  image(circuloNaranja, posX, posY, tam, tam);
    //}
    if (golpeada == true) {
      image(circuloGris, posX, posY, tam, tam);
      if (bien() == false) vibrar();
    }
  }

  boolean bien() {
    if (resultado == "Puede ser mejor..." ||
      resultado == "¡Bien!" ||
      resultado == "¡Excelente!" ||
      resultado == "¡Perfecto!")
      return true;
    else return false;
  }

  void vibrar() {
    if (contador == 20) posX += contador;
    if (contador > 0)
      if (direccion) {
        posX -= contador;
        direccion = !direccion;
        contador--;
      } else {
        posX += contador;
        direccion = !direccion;
        contador--;
      }
  }

  // Funciónes para saber cuando la mirarita está sobre el circulo, activarlos y desactivarlos.
  void activar(Mira mira) {
    if (dist(posX, posY, mira.posX, mira.posY) < tam / 2 && fueActiva == false)
      activa = fueActiva = true;
  }

  // Se desactiva la pelota luego de tocar un botón o que esta pase de largo
  void desactivar() {
    activa = false;
  }

  void mover(Jugador jugador) {
    if (jugador.personaje == "zarpazo") 
      posX -= 2;
    else
      posX -= 3;
  }

  // Función para los golpes
  void golpear(Enemigo enemigo, Jugador jugador, Mira mira, Nivel nivel) { 
    // Si el circulo está activo...
    if (activa) {
      // Y se toca una bolsa...
      if (golpe()) {
        // Y la bolsa se corresponde al tipo...
        if (tipo == 0) {
          if (colorGolpe() == "rojo") { 
            // Se hace daño según que tan cerca se esté del centro.
            if (dist(posX, posY, mira.posX, mira.posY) < 5) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 25;
              sp = new sistemaParticulas(posX, posY, 15);
              resultado = "¡Perfecto!";
              golpeada = true;
              jugador.infligirDamage(enemigo);
              perfect.trigger();
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 13 && dist(posX, posY, mira.posX, mira.posY) > 3) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 15;
              sp = new sistemaParticulas(posX, posY, 6);
              resultado = "¡Excelente!";
              comun.trigger();
              golpeada = true;
              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 35 && dist(posX, posY, mira.posX, mira.posY) > 13) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 10;
              sp = new sistemaParticulas(posX, posY, 4);
              resultado = "¡Bien!";
              golpeada = true;
              comun.trigger();
              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 50 && dist(posX, posY, mira.posX, mira.posY) > 35) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 5;
              sp = new sistemaParticulas(posX, posY, 2);
              resultado = "Puede ser mejor...";
              golpeada = true;
              comun.trigger();
              jugador.infligirDamage(enemigo);
              desactivar();
            }
          }
          // Pero si se toca la bolsa equivocada, se recibe daño

          if ((colorGolpe() == "rojo") == false) {
            jugador.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += 25;
            resultado = "¡Bolsa equivocada!";
            golpeada = true;
            if (nivel.cerbero.terminoP == true) nivel.cerbero.estado = "golpeando"; 
            nivel.cerbero.estado = "golpeando"; 
            jugador.infligirDamage(enemigo);
            desactivar();
          }
        }

        // Lo mismo para cada bolsa. Se podría condensar en un solo condicional enorme, pero sería muy ilegible.
        if (tipo == 1) {
          if ((colorGolpe() == "azul")) {
            if (dist(posX, posY, mira.posX, mira.posY) < 5) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 25;
              sp = new sistemaParticulas(posX, posY, 15);
              resultado = "¡Perfecto!";
              golpeada = true;
              jugador.infligirDamage(enemigo);
              perfect.trigger();
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 13 && dist(posX, posY, mira.posX, mira.posY) > 5) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 15;
              sp = new sistemaParticulas(posX, posY, 6);
              resultado = "¡Excelente!";
              golpeada = true;
              comun.trigger();
              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 35 && dist(posX, posY, mira.posX, mira.posY) > 13) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 10;
              sp = new sistemaParticulas(posX, posY, 4);
              resultado = "¡Bien!";
              golpeada = true;
              comun.trigger();
              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 50 && dist(posX, posY, mira.posX, mira.posY) > 35) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 5;
              sp = new sistemaParticulas(posX, posY, 2);
              resultado = "Puede ser mejor...";
              golpeada = true;
              comun.trigger();
              jugador.infligirDamage(enemigo);
              desactivar();
            }
          }
          if ((colorGolpe() == "azul") == false) {
            jugador.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += 25;
            resultado = "¡Bolsa equivocada!";
            golpeada = true;
            if (nivel.cerbero.terminoP == true) nivel.cerbero.estado = "golpeando"; 
            nivel.cerbero.estado = "golpeando"; 
            enemigo.infligirDamage(jugador);
            desactivar();
          }
        }
        if (tipo == 2) {
          if ((colorGolpe() == "verde")) {
            if (dist(posX, posY, mira.posX, mira.posY) < 5) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 25;
              sp = new sistemaParticulas(posX, posY, 15);
              resultado = "¡Perfecto!";
              golpeada = true;
              jugador.infligirDamage(enemigo);
              perfect.trigger();
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 13 && dist(posX, posY, mira.posX, mira.posY) > 5) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 15;
              sp = new sistemaParticulas(posX, posY, 6);
              resultado = "¡Excelente!";
              golpeada = true;
              comun.trigger();
              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 35 && dist(posX, posY, mira.posX, mira.posY) > 13) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 10;
              sp = new sistemaParticulas(posX, posY, 4);
              resultado = "¡Bien!";
              golpeada = true;
              comun.trigger();
              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 50 && dist(posX, posY, mira.posX, mira.posY) > 35) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 5;
              sp = new sistemaParticulas(posX, posY, 2);
              resultado = "Puede ser mejor...";
              golpeada = true;
              comun.trigger();
              jugador.infligirDamage(enemigo);
              desactivar();
            }
          }
          if ((colorGolpe() == "verde") == false) {
            jugador.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += 25;
            resultado = "¡Bolsa equivocada!";
            if (nivel.cerbero.terminoP == true) nivel.cerbero.estado = "golpeando"; 
            nivel.cerbero.estado = "golpeando"; 
            enemigo.infligirDamage(jugador);
            golpeada = true;
            desactivar();
          }
        }
        /* if (tipo == 3) {
         if ((colorGolpe() == "naranja")) {
         if (dist(posX, posY, mira.posX, mira.posY) < 5) {
         enemigo.combo = 0;
         jugador.combo++;
         jugador.damageActual += 25;
         resultado = "¡Perfecto!";
         golpeada = true;
         perfect.trigger();
         jugador.infligirDamage(enemigo);
         desactivar();
         } 
         if (dist(posX, posY, mira.posX, mira.posY) < 13 && dist(posX, posY, mira.posX, mira.posY) > 5) {
         enemigo.combo = 0;
         jugador.combo++;
         jugador.damageActual += 15;
         resultado = "¡Excelente!";
         golpeada = true;
         comun.trigger();
         jugador.infligirDamage(enemigo);
         desactivar();
         } 
         if (dist(posX, posY, mira.posX, mira.posY) < 35 && dist(posX, posY, mira.posX, mira.posY) > 13) {
         enemigo.combo = 0;
         jugador.combo++;
         jugador.damageActual += 10;
         resultado = "¡Bien!";
         golpeada = true;
         comun.trigger();
         jugador.infligirDamage(enemigo);
         desactivar();
         } 
         if (dist(posX, posY, mira.posX, mira.posY) < 50 && dist(posX, posY, mira.posX, mira.posY) > 35) {
         enemigo.combo = 0;
         jugador.combo++;
         jugador.damageActual += 5;
         resultado = "Puede ser mejor...";
         golpeada = true;
         comun.trigger();
         jugador.infligirDamage(enemigo);
         desactivar();
         }
         }
         if ((colorGolpe() == "naranja") == false) {
         jugador.combo = 0;
         enemigo.combo++;
         enemigo.damageActual += 25;
         resultado = "¡Bolsa equivocada!";    
         if (nivel.cerbero.terminoP == true) nivel.cerbero.estado = "golpeando"; 
         nivel.cerbero.estado = "golpeando"; 
         enemigo.infligirDamage(jugador);
         golpeada = true;
         desactivar();
         }
         } */
      }
      // Si la mirara pasa y no se pulsa ninguna bolsa, se recibe daño.
      if (dist(posX, posY, mira.posX, mira.posY) >= tam / 2) {
        jugador.combo = 0;
        enemigo.combo++;
        enemigo.damageActual += 25;
        resultado = "¡No golpeaste ninguna bolsa!";
        golpeada = true;
        if (nivel.cerbero.terminoP == true) nivel.cerbero.estado = "golpeando"; 
        nivel.cerbero.estado = "golpeando"; 
        enemigo.infligirDamage(jugador);
        desactivar();
      }
    }
  }
}

// Clase para las particulas de los golpes acertados
class sistemaParticulas {
  // Datos
  Particula[] particulas;  // Arreglo de particulas
  float posX, posY;        // Origen en X e Y

  int cantidad;            // Cantidad de particulas. Depende de que tan certero sea el golpe, se asignará un número mayor

  sistemaParticulas(float posX, float posY, int cantidad) {
    this.posX = posX;
    this.posY = posY;

    this.cantidad = cantidad;
    particulas = new Particula[cantidad];

    for (int i = 0; i < particulas.length; i++) {
      particulas[i] = new Particula(posX, posY);
    }
  }

  void dibujar() {
    for (int i = 0; i < particulas.length; i++) {
      particulas[i].dibujar();
    }
  }
}

// Clase para particulas individuales. Ver sistemaParticulas.

class Particula {
  float posX, posY;
  float tam;
  float velX, velY, accel;
  float rotacion;

  float alpha, lifespan;

  PImage estrella;

  Particula(float posX, float posY) {
    this.posX = posX;
    this.posY = posY;

    estrella = loadImage("data/imagenes/ui/particula.png");

    tam = 15;

    // Rotación en eje Z con translate() y rotate()
    rotacion = random(0, 360);  // Rotación inicial

    // Velocidad y aceleración. Determinan la dirección.
    velX = random(-2, 2);
    velY = random(-2, 2);
    accel = 0.98;

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