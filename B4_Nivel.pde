class Nivel {
  // Objeto para el sistema de pelea, cortina, enemigo, jugador y sus respectivas barras de vida
  SistemaPelea combat;
  Enemigo enemigo;
  Jugador jugador;
  Ui ui; 

  Cortina cortina;

  // Imagen de fondo para el nivel
  PImage background;

  boolean termino, peleaTerminada;
  int fallar;  

  int alphaNivelTerminado, colorEnemigo, alphaEnemigo, alphaRectFondo;
  boolean blancoDibujado, alphaRectFondoCambio, alphaEnemigoZero;

  PImage [] globosDialogocerbero;
  int cantidadGlobos;
  boolean finalListo, finKO;
  int alphaGlobo;

  String siguienteEtapa;
  String direccion;

  // Constructor
  Nivel(String background, String gato, String perro, String siguienteEtapa) {

    this.siguienteEtapa = siguienteEtapa;

    combat = new SistemaPelea(this, 185, 80, 999, 110);
    jugador = new Jugador(gato);
    enemigo = new Enemigo(perro);

    ui = new Ui(jugador, enemigo, combat);

    termino = true;

    this.background = loadImage("data/imagenes/niveles/" + background + ".png");

    cortina = new Cortina(255);

    fallar = 0;

    peleaTerminada = false;

    alphaNivelTerminado = 360;
    colorEnemigo = 360;
    blancoDibujado = false;
    alphaEnemigo = 255;
    alphaRectFondo = 360;
    alphaRectFondoCambio = false;
    alphaEnemigoZero = false;
    alphaGlobo = 0;
    finKO = false;

    cantidadGlobos = 5;
    globosDialogocerbero = new PImage [cantidadGlobos];
    for (int i = 0; i < cantidadGlobos; i++) {
      globosDialogocerbero[i] = loadImage("data/imagenes/globosDialogo/cerbero/" + i + ".png");
    }
    direccion = "globosDialogo" + enemigo;
  }

  void dibujar() {
    cortina.fadeIn();
    
    imageMode(CORNER);

    pushMatrix();
    if (fallar > 0 ) {
      translate(random(-2, 2), random(-2, 2));
      fallar--;
    }
    pushStyle();
    image(background, 0, 0, width, height);

    // Desde acá empiezan una sucesión de estados que determinan como se comportan los elementos luego de que el jugador haya derrotado al enemigo 

    if (peleaTerminada == true) {

      fill(360, 0 - alphaRectFondo);
      rect(0, 0, width, height);


      if (alphaRectFondo <= 0 && blancoDibujado == false) {
        blancoDibujado = true;
      } else

        if (blancoDibujado == true && colorEnemigo > 0) {
          println(colorEnemigo);
          colorEnemigo-=5;
          blancoDibujado = false;
        } else

          if (colorEnemigo <= 0 && alphaRectFondoCambio == false) {
            alphaEnemigo-=3;
            if (alphaEnemigo <= 0) {
              alphaEnemigoZero = true;
            }
          } 

      if (alphaEnemigoZero == true) {
        println(colorEnemigo);
        alphaRectFondoCambio = true;
        enemigo.estado = "derrotado";
        alphaRectFondo+=10;
        colorEnemigo+=3;
        alphaEnemigo+=3;
        finalListo = true;
      }

      if (colorEnemigo >= 350 && finalListo == true) {
        tint(360, alphaGlobo);
        alphaGlobo+=2;
        alphaEnemigoZero = false;
        image(globosDialogocerbero[4], width/2+150, height/2-350, 300, 300);
      }

      if (alphaGlobo >= 240) {
        finKO = true;
      }
    }

    // Si el enemigo no fue derrotado, las variables no cambian y tanto el color como el alpha permanecen en sus valores por defecto (360,255)
    tint(colorEnemigo, alphaEnemigo);
    enemigo.dibujar(width / 2, height / 2 + 100, 420.8, 557.6);
    popStyle();

    popMatrix();

    if (cortina.listo)
      if (ui.textoPreparacion.iniciarPelea && peleaTerminada == false) {
        combat.pelea();
        combat.reiniciar();
      }

    ui.dibujar();

    if (termino) {
      if (jugador.salud <= 0) {
        cortina.dibujar();
        cortina.fadeOut("gameover");
        cortina.activar("out");
        termino = false;
      } else if (enemigo.salud <= 0) {
        enemigoKO();
      }
    }
  }
  void enemigoKO () {

    ui.alphaRectNivelTerminado -= 1;
    ui.alphaNivelTerminado -= 5;
    if (alphaRectFondoCambio == false) {
      alphaRectFondo-=5;
    }

    if (ui.alphaNivelTerminado <= 10 && ui.alphaRectNivelTerminado <=10) {
      peleaTerminada = true;
    }

    if (finKO == true) {
      cortina.dibujar();
      cortina.activar("out");
      cortina.fadeOut(this.siguienteEtapa);
    }
  }
}