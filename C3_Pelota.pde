String resultado; // Esta variable es para el debugging onscreen

class Pelota {
  // Datos
  float posX, posY;
  boolean activa, fueActiva, golpeada;
  int tipo, tam;

  // Constructor
  Pelota(float posicionX, float posicionY, int type) { 
    tam = 80;
    activa = fueActiva = false;

    posX = posicionX;
    posY = posicionY;
    tipo = type;
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
      image(circuloNaranja, posX, posY, tam, tam);
    }
    if (tipo == 3) {
      image(circuloVerde, posX, posY, tam, tam);
    }
    if (golpeada == true) {
      image(circuloGris, posX, posY, tam, tam);
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
  // Esta funcion restablece la variable para que las pelotas puedan volver a ser activas
  void restablecer() {
    fueActiva = false;
    golpeada = false;
  }

  // Función para cambiar el tipo de circulo(color-bolsa)
  void cambiarTipo() {
    tipo = int(random(4));
  }

  void mover(Jugador jugador) {
    if (jugador.personaje == "zarpazo") 
      posX -= 3;
    else
      posX -= 5;
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
          if ((colorGolpe() == "naranja")) {
            if (dist(posX, posY, mira.posX, mira.posY) < 5) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 25;
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
        }
        if (tipo == 3) {
          if ((colorGolpe() == "verde")) {
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