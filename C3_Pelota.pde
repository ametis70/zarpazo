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

    pushStyle();
    imageMode(CENTER);
    tint(360, nivel.ui.alphaNivelTerminado);
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
    popStyle();
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
    if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < tam / 2 && fueActiva == false) {
      nivel.ui.mira.cambiarColor(this);
      activa = fueActiva = true;
    }
  }

  // Se desactiva la pelota luego de tocar un botón o que esta pase de largo
  void desactivar() {
    activa = false;
    nivel.ui.mira.apagar();
  }

  void mover(Jugador jugador) {
    if (jugador.personaje == "zarpazo") 
      posX -= 2;
    else
      posX -= 3;
  }

  // Funciones para los golpes

  void correcto(int damage, int particulas, boolean perfect) {
    nivel.enemigo.combo = 0;
    nivel.jugador.combo++;
    nivel.jugador.damageActual += damage;
    sp = new SistemaParticulas(posX, posY, particulas, tipo);
    resultado = "¡Perfecto!";
    golpeada = true;
    if (perfect)
      nivel.jugador.perfect = true;
    nivel.jugador.golpeando = true;
    nivel.enemigo.terminoAnimacion = true; 
    desactivar();
  }

  void incorrecto() {
    nivel.jugador.combo = 0;
    nivel.enemigo.combo++;
    nivel.enemigo.damageActual += 25;
    resultado = "¡Bolsa equivocada!";
    golpeada = true;
    nivel.enemigo.proximaAnimacion = "golpeando"; 
    nivel.enemigo.terminoAnimacion = true; 
    desactivar();
  }

  void golpear() { 


    // Si el circulo está activo...
    if (activa) {
      // Y se toca una bolsa...
      if (golpe()) {
        // Y la bolsa se corresponde al tipo...
        if ((tipo == 0 && colorGolpe() == "azul") ||
          (tipo == 1 && colorGolpe() == "verde") ||
          (tipo == 2 && colorGolpe() == "rojo")) {
          // Se hace daño según que tan cerca se esté del centro.
          if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 5) {
            nivel.puntos(50);
            correcto(4, 15, true);
          } 
          if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 13 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 3) {
            nivel.puntos(30);
            correcto(3, 6, false);
          } 
          if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 35 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 13) {
            nivel.puntos(20);
            correcto(2, 4, false);
          } 
          if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) < 50 && dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) > 35) {
            nivel.puntos(10);
            correcto(1, 2, false);
          }
        }
        // Pero si se toca la bolsa equivocada, se recibe daño
        if ((tipo == 0 && (colorGolpe() == "azul") == false) ||
          (tipo == 1 && (colorGolpe() == "verde") == false) ||
          (tipo == 2 && (colorGolpe() == "rojo") == false)) {
          incorrecto();
        }
      }

      // Si la pelota pasa y no se pulsa ninguna bolsa, se recibe daño.
      if (dist(posX, posY, nivel.ui.mira.posX, nivel.ui.mira.posY) >= tam / 2) {
        incorrecto();
      }
    }
  }
}