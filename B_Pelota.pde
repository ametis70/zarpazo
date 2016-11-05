String resultado; // Esta variable es para el debugging onscreen

class Pelota {
  // Datos
  float posX, posY;
  boolean activa, fueActiva;
  int tipo, tam;

  // Constructor
  Pelota(int posicionX, int posicionY, int type) { 
    tam = 100;
    activa = fueActiva = false;

    posX = posicionX;
    posY = posicionY;
    tipo = type;
  }

  // Función para dibujar los circulos.
  void dibujar() {
    if (activa)
      stroke(255);
    else
      noStroke();
    fill(tipo * 90, 100, 100);
    ellipse(posX, posY, tam, tam);
  }

  // Funciónes para saber cuando la barrita está sobre el circulo, activarlos y desactivarlos.
  void activar() {
    if (dist(posX, posY, bar.posX, bar.posY) < tam / 2 && fueActiva == false)
      activa = fueActiva = true;
  }
  
  // Se desactiva la pelota luego de tocar un botón o que esta pase de largo
  void desactivar() {
    activa = false;
  }
  // Esta funcion restablece la variable para que las pelotas puedan volver a ser activas
  void restablecer() {
    fueActiva = false;
  }
  

  // Función para cambiar el tipo de circulo(color-tecla)
  void cambiarTipo() {
    tipo = int(random(4));
  }
  
  void mover() {
    if (player.combo == 0) 
      combat.velocidad = combat.velocidadInicial;   // Si hay combo break, se reinicia la combat.velocidad
    if (combat.velocidad <= 7) 
      combat.velocidad *= combat.accel;             // Si la combat.velocidad es menor a 7, ésta se multiplica por la aceleración
      
    posX -= combat.velocidad; 
  }
  
  // Función para los golpes
  void golpear() {
    // Si el circulo está activo...
    if (activa) {
      // Y se toca una tecla...
      if (keyPressed) {
        // Y la tecla se corresponde al tipo...
        if (tipo == 0) {
          if (key == 'a' || key == 'A') { 
            // Se hace daño según que tan cerca se esté del centro.
            if (dist(posX, posY, bar.posX, bar.posY) < 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(12, 20));
              resultado = "¡Perfecto!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 13 && dist(posX, posY, bar.posX, bar.posY) > 3) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(9, 12));
              resultado = "¡Excelente!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 35 && dist(posX, posY, bar.posX, bar.posY) > 13) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(5, 9));
              resultado = "¡Bien!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 50 && dist(posX, posY, bar.posX, bar.posY) > 35) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(1, 5));
              resultado = "Puede ser mejor...";
              desactivar();
            }
          }
          // Pero si se toca la tecla equivocada, se recibe daño

          if ((key == 'a' || key == 'A') == false) {
            player.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += int(random(9, 20));
            resultado = "¡Tecla equivocada!";
            desactivar();
          }
        }

        // Lo mismo para cada tecla. Se podría condensar en un solo condicional enorme, pero sería muy ilegible.
        if (tipo == 1) {
          if (key == 's' || key == 'S') {
            if (dist(posX, posY, bar.posX, bar.posY) < 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(12, 20));
              resultado = "¡Perfecto!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 13 && dist(posX, posY, bar.posX, bar.posY) > 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(9, 12));
              resultado = "¡Excelente!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 35 && dist(posX, posY, bar.posX, bar.posY) > 13) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(5, 9));
              resultado = "¡Bien!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 50 && dist(posX, posY, bar.posX, bar.posY) > 35) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(1, 5));
              resultado = "Puede ser mejor...";
              desactivar();
            }
          }
          if ((key == 's' || key == 'S') == false) {
            player.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += int(random(9, 20));
            resultado = "¡Tecla equivocada!";
            desactivar();
          }
        }
        if (tipo == 2) {
          if (key == 'd' || key == 'D') {
            if (dist(posX, posY, bar.posX, bar.posY) < 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(12, 20));
              resultado = "¡Perfecto!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 13 && dist(posX, posY, bar.posX, bar.posY) > 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(9, 12));
              resultado = "¡Excelente!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 35 && dist(posX, posY, bar.posX, bar.posY) > 13) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(5, 9));
              resultado = "¡Bien!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 50 && dist(posX, posY, bar.posX, bar.posY) > 35) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(1, 5));
              resultado = "Puede ser mejor...";
              desactivar();
            }
          }
          if ((key == 'd' || key == 'D') == false) {
            player.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += int(random(9, 20));
            resultado = "¡Tecla equivocada!";
            desactivar();
          }
        }
        if (tipo == 3) {
          if (key == 'f' || key == 'F') {
            if (dist(posX, posY, bar.posX, bar.posY) < 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(12, 20));
              resultado = "¡Perfecto!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 13 && dist(posX, posY, bar.posX, bar.posY) > 5) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(9, 12));
              resultado = "¡Excelente!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 35 && dist(posX, posY, bar.posX, bar.posY) > 13) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(5, 9));
              resultado = "¡Bien!";
              desactivar();
            } 
            if (dist(posX, posY, bar.posX, bar.posY) < 50 && dist(posX, posY, bar.posX, bar.posY) > 35) {
              enemigo.combo = 0;
              player.combo++;
              player.damageActual += int(random(1, 5));
              resultado = "Puede ser mejor...";
              desactivar();
            }
          }
          if (( key == 'f' || key == 'F') == false) {
            player.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += int(random(9, 20));
            resultado = "¡Tecla equivocada!";
            desactivar();
          }
        }
      }
      // Si la barra pasa y no se pulsa ninguna tecla, se recibe daño.
      if (dist(posX, posY, bar.posX, bar.posY) >= tam / 2) {
        player.combo = 0;
        enemigo.combo++;
        enemigo.damageActual += int(random(9, 20));
        resultado = "¡No presionaste ninguna tecla!";
        desactivar();
      }
    }
  }
}