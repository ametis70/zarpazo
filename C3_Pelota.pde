class Pelota {
  // Datos

  float posX, posY;
  boolean activa, fueActiva, golpeada;
  String resultado;
  int tipo, tam, alpha;

  // Variables para el feedback
  SistemaParticulas sp;
  boolean direccion;
  int contador;

  // Se pasa por referencia al objeto de la interfaz para poder acceder a la nivel.ui.mira
  Nivel nivel;

  // Constructor
  Pelota(float posicionX, float posicionY, Nivel nivel) { 
    tam = 80;
    activa = fueActiva = golpeada = false;

    posX = posicionX;
    posY = posicionY;
    tipo = int(random(3));

    this.nivel = nivel;

    contador = 20;
    direccion = true;
  }

  // Función para dibujar los circulos.
  void dibujar() {
    imageMode(CENTER);
    if (tipo == 0) {
      image(circuloAzul, posX, posY, tam, tam);
    }
    if (tipo == 1) {
      image(circuloVerde, posX, posY, tam, tam);
    }
    if (tipo == 2) {
      image(circuloRojo, posX, posY, tam, tam);
    }
    //if (tipo == 3) {
    //  image(circuloNaranja, posX, posY, tam, tam);
    //}
    if (golpeada == true) {
      if (bien())
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
    if (contador == 20) posX += 10;
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

  // Funciónes para saber cuando la nivel.ui.mirarita está sobre el circulo, activarlos y desactivarlos.
  void activar() {
    if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < tam / 2 && fueActiva == false)
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
  void golpear(Enemigo enemigo, Jugador jugador, Nivel nivel) { 
    // Si el circulo está activo...
    if (activa) {
      // Y se toca una bolsa...
      if (golpe()) {
        // Y la bolsa se corresponde al tipo...
        if (tipo == 0) {
          if (colorGolpe() == "azul") { 
            // Se hace daño según que tan cerca se esté del centro.
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 5) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 25;
              sp = new SistemaParticulas(posX, posY, 15);
              resultado = "¡Perfecto!";
              golpeada = true;
              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 13 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 3) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 15;
              sp = new SistemaParticulas(posX, posY, 6);
              resultado = "¡Excelente!";
              golpeada = true;
              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 35 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 13) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 10;
              sp = new SistemaParticulas(posX, posY, 4);
              resultado = "¡Bien!";
              golpeada = true;

              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 50 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 35) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 5;
              sp = new SistemaParticulas(posX, posY, 2);
              resultado = "Puede ser mejor...";
              golpeada = true;

              jugador.infligirDamage(enemigo);
              desactivar();
            }
          }
          // Pero si se toca la bolsa equivocada, se recibe daño

          if ((colorGolpe() == "azul") == false) {
            nivel.fallar = 30;
            jugador.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += 25;
            resultado = "¡Bolsa equivocada!";
            golpeada = true;
            if (nivel.enemigo.terminoP == true) nivel.enemigo.estado = "golpeando"; 
            nivel.enemigo.estado = "golpeando"; 
            jugador.infligirDamage(enemigo);
            desactivar();
          }
        }

        // Lo mismo para cada bolsa. Se podría condensar en un solo condicional enorme, pero sería muy ilegible.
        if (tipo == 1) {
          if ((colorGolpe() == "verde")) {
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 5) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 25;
              sp = new SistemaParticulas(posX, posY, 15);
              resultado = "¡Perfecto!";
              golpeada = true;
              jugador.infligirDamage(enemigo);

              desactivar();
            } 
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 13 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 5) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 15;
              sp = new SistemaParticulas(posX, posY, 6);
              resultado = "¡Excelente!";
              golpeada = true;

              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 35 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 13) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 10;
              sp = new SistemaParticulas(posX, posY, 4);
              resultado = "¡Bien!";
              golpeada = true;

              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 50 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 35) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 5;
              sp = new SistemaParticulas(posX, posY, 2);
              resultado = "Puede ser mejor...";
              golpeada = true;

              jugador.infligirDamage(enemigo);
              desactivar();
            }
          }
          if ((colorGolpe() == "verde") == false) {
            nivel.fallar = 30;
            jugador.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += 25;
            resultado = "¡Bolsa equivocada!";
            golpeada = true;
            if (nivel.enemigo.terminoP == true) nivel.enemigo.estado = "golpeando"; 
            nivel.enemigo.estado = "golpeando"; 
            enemigo.infligirDamage(jugador);
            desactivar();
          }
        }
        if (tipo == 2) {
          if ((colorGolpe() == "rojo")) {
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 5) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 25;
              sp = new SistemaParticulas(posX, posY, 15);
              resultado = "¡Perfecto!";
              golpeada = true;
              jugador.infligirDamage(enemigo);

              desactivar();
            } 
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 13 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 5) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 15;
              sp = new SistemaParticulas(posX, posY, 6);
              resultado = "¡Excelente!";
              golpeada = true;

              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 35 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 13) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 10;
              sp = new SistemaParticulas(posX, posY, 4);
              resultado = "¡Bien!";
              golpeada = true;

              jugador.infligirDamage(enemigo);
              desactivar();
            } 
            if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 50 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 35) {
              enemigo.combo = 0;
              jugador.combo++;
              jugador.damageActual += 5;
              sp = new SistemaParticulas(posX, posY, 2);
              resultado = "Puede ser mejor...";
              golpeada = true;

              jugador.infligirDamage(enemigo);
              desactivar();
            }
          }
          if ((colorGolpe() == "rojo") == false) {
            nivel.fallar = 30;
            jugador.combo = 0;
            enemigo.combo++;
            enemigo.damageActual += 25;
            resultado = "¡Bolsa equivocada!";
            if (nivel.enemigo.terminoP == true) nivel.enemigo.estado = "golpeando"; 
            nivel.enemigo.estado = "golpeando"; 
            enemigo.infligirDamage(jugador);
            golpeada = true;
            desactivar();
          }
        }
        /* if (tipo == 3) {
         if ((colorGolpe() == "naranja")) {
         if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 5) {
         enemigo.combo = 0;
         jugador.combo++;
         jugador.damageActual += 25;
         resultado = "¡Perfecto!";
         golpeada = true;
         perfect.trigger();
         jugador.infligirDamage(enemigo);
         desactivar();
         } 
         if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 13 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 5) {
         enemigo.combo = 0;
         jugador.combo++;
         jugador.damageActual += 15;
         resultado = "¡Excelente!";
         golpeada = true;
         comun.trigger();
         jugador.infligirDamage(enemigo);
         desactivar();
         } 
         if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 35 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 13) {
         enemigo.combo = 0;
         jugador.combo++;
         jugador.damageActual += 10;
         resultado = "¡Bien!";
         golpeada = true;
         comun.trigger();
         jugador.infligirDamage(enemigo);
         desactivar();
         } 
         if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 50 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 35) {
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
         nivel.fallar = 30;
         jugador.combo = 0;
         enemigo.combo++;
         enemigo.damageActual += 25;
         resultado = "¡Bolsa equivocada!";    
         if (nivel.enemigo.terminoP == true) nivel.enemigo.estado = "golpeando"; 
         nivel.enemigo.estado = "golpeando"; 
         enemigo.infligirDamage(jugador);
         golpeada = true;
         desactivar();
         }
         } */
      }
      // Si la nivel.ui.mirara pasa y no se pulsa ninguna bolsa, se recibe daño.
      if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) >= tam / 2) {
        nivel.fallar = 30;
        jugador.combo = 0;
        enemigo.combo++;
        enemigo.damageActual += 25;
        resultado = "¡No golpeaste ninguna bolsa!";
        golpeada = true;
        if (nivel.enemigo.terminoP == true) nivel.enemigo.estado = "golpeando"; 
        nivel.enemigo.estado = "golpeando"; 
        enemigo.infligirDamage(jugador);
        desactivar();
      }
    }
  }
}