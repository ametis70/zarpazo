String resultado; // Esta variable es para el debugging onscreen

class Pelota {
  // Datos
  float posX, posY;
  boolean activa, fueActiva, golpeada;
  int tipo, tam;

  // Constructor
  Pelota(int posicionX, int posicionY, int type) { 
    tam = 80;
    activa = fueActiva = false;

    posX = posicionX;
    posY = posicionY;
    tipo = type;
  }

  // Función para dibujar los circulos.
  void dibujar() {
    imageMode(CENTER);
    if(tipo == 0) {
     image(circuloRojo, posX, posY, tam, tam);
    }
    if(tipo == 1) {
     image(circuloVerde, posX, posY, tam, tam);
    }
    if(tipo == 2) {
     image(circuloAzul, posX, posY, tam, tam);
    }
    if(tipo == 3) {
     image(circuloAmarillo, posX, posY, tam, tam);
    }
    if(golpeada == true) {
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

  void mover(Jugador player, SistemaPelea combat) {
    if (player.combo == 0) 
      combat.velocidad = combat.velocidadInicial;   // Si hay combo break, se reinicia la combat.velocidad
    if (combat.velocidad <= 7) 
      combat.velocidad *= combat.accel;             // Si la combat.velocidad es menor a 7, ésta se multiplica por la aceleración

    posX -= combat.velocidad;
  }

  // Función para los golpes
  void golpear(Enemigo enemigo, Jugador player, Mira mira) { 
    // Si el circulo está activo...
    if (activa) {
      // Y se toca una bolsa...
      if (keyPressed || microswitch() != 0) {
        // Y la bolsa se corresponde al tipo...
        if (tipo == 0) {
          if (key == 'a' || key == 'A' || microswitch(1) == 1) { 
            // Se hace daño según que tan cerca se esté del centro.
            if (dist(posX, posY, mira.posX, mira.posY) < 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(12, 20));
              resultado = "¡Perfecto!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 13 && dist(posX, posY, mira.posX, mira.posY) > 3) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(9, 12));
              resultado = "¡Excelente!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 35 && dist(posX, posY, mira.posX, mira.posY) > 13) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(5, 9));
              resultado = "¡Bien!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 50 && dist(posX, posY, mira.posX, mira.posY) > 35) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(1, 5));
              resultado = "Puede ser mejor...";
              golpeada = true;
              desactivar();
            }
          }
          // Pero si se toca la bolsa equivocada, se recibe daño

          if ((key == 'a' || key == 'A' || microswitch(1) == 1) == false) {
            player.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += int(random(9, 20));
            resultado = "¡Bolsa equivocada!";
            golpeada = true;
            desactivar();
          }
        }

        // Lo mismo para cada bolsa. Se podría condensar en un solo condicional enorme, pero sería muy ilegible.
        if (tipo == 1) {
          if (key == 's' || key == 'S' || microswitch(2) == 2) {
            if (dist(posX, posY, mira.posX, mira.posY) < 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(12, 20));
              resultado = "¡Perfecto!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 13 && dist(posX, posY, mira.posX, mira.posY) > 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(9, 12));
              resultado = "¡Excelente!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 35 && dist(posX, posY, mira.posX, mira.posY) > 13) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(5, 9));
              resultado = "¡Bien!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 50 && dist(posX, posY, mira.posX, mira.posY) > 35) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(1, 5));
              resultado = "Puede ser mejor...";
              golpeada = true;
              desactivar();
            }
          }
          if ((key == 's' || key == 'S'  || microswitch(2) == 2) == false) {
            player.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += int(random(9, 20));
            resultado = "¡Bolsa equivocada!";
            golpeada = true;
            desactivar();
          }
        }
        if (tipo == 2) {
          if (key == 'd' || key == 'D' || microswitch(3) == 3) {
            if (dist(posX, posY, mira.posX, mira.posY) < 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(12, 20));
              resultado = "¡Perfecto!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 13 && dist(posX, posY, mira.posX, mira.posY) > 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(9, 12));
              resultado = "¡Excelente!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 35 && dist(posX, posY, mira.posX, mira.posY) > 13) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(5, 9));
              resultado = "¡Bien!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 50 && dist(posX, posY, mira.posX, mira.posY) > 35) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(1, 5));
              resultado = "Puede ser mejor...";
              golpeada = true;
              desactivar();
            }
          }
          if ((key == 'd' || key == 'D'  || microswitch(3) == 3) == false) {
            player.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += int(random(9, 20));
            resultado = "¡Bolsa equivocada!";
            golpeada = true;
            desactivar();
          }
        }
        if (tipo == 3) {
          if (key == 'f' || key == 'F'  || microswitch(4) == 4) {
            if (dist(posX, posY, mira.posX, mira.posY) < 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(12, 20));
              resultado = "¡Perfecto!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 13 && dist(posX, posY, mira.posX, mira.posY) > 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(9, 12));
              resultado = "¡Excelente!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 35 && dist(posX, posY, mira.posX, mira.posY) > 13) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(5, 9));
              resultado = "¡Bien!";
              golpeada = true;
              desactivar();
            } 
            if (dist(posX, posY, mira.posX, mira.posY) < 50 && dist(posX, posY, mira.posX, mira.posY) > 35) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(1, 5));
              resultado = "Puede ser mejor...";
              golpeada = true;
              desactivar();
            }
          }
          if (( key == 'f' || key == 'F'  || microswitch(4) == 4) == false) {
            player.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += int(random(9, 20));
            resultado = "¡Bolsa equivocada!";
            golpeada = true;
            desactivar();
          }
        }
      }
      // Si la mirara pasa y no se pulsa ninguna bolsa, se recibe daño.
      if (dist(posX, posY, mira.posX, mira.posY) >= tam / 2) {
        player.combo = 0;
        enemigo.combo++;
        enemigo.damageActual += int(random(9, 20));
        resultado = "¡No golpeaste ninguna bolsa!";
        golpeada = true;
        desactivar();
      }
    }
  }
}