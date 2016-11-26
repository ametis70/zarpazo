class Cinematica {
  // Datos

  // Variables para la posición
  float posX, posY;
  float tamX, tamY;
  float targetX, targetY;

  // Imagen
  PImage comic;

  // Booleanos para los fade
  boolean empezo, termino;

  // Obetos para el fade y mover el comic
  Cortina cortina;
  Ease ease;

  // Variables para saltear
  int tiempoInicial;
  boolean millis;

  // Constructor
  Cinematica(String comic, float posX, float posY, float tamX, float tamY) {
    this.posX = targetX = posX;
    this.posY = targetY = posY;
    this.tamX = tamX;
    this.tamY = tamY;
    this.comic = loadImage("data/imagenes/cinematicas/" + comic + ".jpg");
    termino = false;
    empezo = true;

    millis = true;

    cortina = new Cortina(255);
    ease = new Ease();
  }

  // Métodos
  void dibujar(String proxima) {
    cortina.fadeIn();

    // Se dibuja el comic
    background(0, 0, 100);
    image(comic, posX, posY, tamX, tamY);
    

    if (cortina.listo == true && empezo) {
      ease.movimiento = 1;
      empezo = false;
    }

    if (termino) {
      cortina.activar("out");
      cortina.fadeOut(proxima);
    }

    mover();

    cortina.dibujar();

    // Función para hacer aparecer el dialogo de confirmación
    saltear();

    // Si la cinematica termino(o se salteó), oscurecer la pantalla
  }

  // Función para saltear la escena
  void saltear() {
    // Si se golpea por primera vez se activa el cuadro de confirmación 
    if (cortina.listo == true && empezo == false && millis == true) {
      if (golpe()) {
        tiempoInicial = millis();
        millis = false;
      }
    }

    // Se dibuja el cuadrado y el texto de confirmación
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

    // Si no pasaron 3 segundos(pero pasaron mas de 250ms) y se golpea nuevamente, se saltea la escena
    if (golpe() && millis() < tiempoInicial + 3000 && millis() > tiempoInicial + 250 && !termino) {

      termino = true;
    }

    // Si pasaron 3 segundos, el cuadrado de confirmación desaparece
    if (millis() > tiempoInicial + 3000) {
      millis = true;
      tiempoInicial = 0;
    }
  }

  // Atajo para hacer el Easing.
  void ease(int movimiento, float targetX, float targetY, String tipo) {
    // Si no se inicializó, se hace esto primero;
    ease.inicializar(posX, posY, tamX, tamY);

    // Se realiza uno u otro movimiento
    if (ease.movimiento == movimiento) {  
      // Se cambia el target
      ease.target(targetX, targetY);

      // Según el tipo, se actualiza la posición o tamaño del ease
      if (tipo == "pos") ease.easePos(0.05);
      if (tipo == "tam") ease.easeTam(0.05);

      // Se actualizan las variables de la cinemática según las del ease
      if (tipo == "pos") { 
        posX = ease.posX; 
        posY = ease.posY;
      }
      if (tipo == "tam") { 
        tamX = ease.tamX; 
        tamY = ease.tamY;
      }
    }
  }
  // Función con un solo parámetro para determinar el movimiento final
  void ease(int movimiento) {
    if (ease.movimiento == movimiento) {
      termino = true;
    }
  }

  // Métodos propios de cada cinemática
  void mover() {
    if (!empezo && !termino) {
      //println(ease.movimiento);  // Debugging
      if (juego.etapaActual == "introduccion") {
        //movimiento, targetX, targetY, tipo
        ease(1, 500, 500, "pos");
        ease(2, 0, 600, "pos");
        ease(3, 500, 0, "pos");
        ease(4, 0, 0, "pos");
        ease(5, 2632, 1502, "tam");
        ease(6, -500, -500, "pos");
        ease(7);
      }
    }
  }
}