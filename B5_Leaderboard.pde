class Leaderboard {
  // Datos
  Table tabla;
  String[] jugadores;
  int[] puntajes;

  // Variables para el campo de texto.
  boolean listo;
  boolean nuevoNombre;
  String nombre;
  
  // Constructor
  Leaderboard() {
    // Se carga el .csv
    tabla = loadTable("leaderboard.csv", "header");

    // println(tabla.getRowCount() + "Cantidad total de filas"); // Debugging

    // Se settea la columna de puntos a int para poder ordenarla, y se ordena
    tabla.setColumnType("Puntos", Table.INT);
    tabla.sortReverse("Puntos");

    jugadores = new String[tabla.getRowCount()];
    puntajes = new int[tabla.getRowCount()];

    // Variables para el campo de texto

    nuevoNombre = false;
    listo = true;
    nombre = "";

    // Se llenan los arreglos de puntajes y jugadores para poder dibujarlos

    for (int i = 0; i < tabla.getRowCount(); i++) {
      TableRow row = tabla.getRow(i);
      puntajes[i] = row.getInt("Puntos");
      //println(puntajes[i]);
      jugadores[i] = row.getString("Jugador");
      //println(jugadores[i]);
    }
  }

  // Métodos
  void dibujar(int posY, int posX, int text) {
    textAlign(CENTER);
    textFont(fuenteNeon);
    int texto = text;
    textSize(texto);
    fill(0, 0, 100);
    for (int i = 0; i < 5; i++) {
      text((i + 1) + ". " + jugadores[i] + " - " + puntajes[i], posX, posY + texto * i);    
    }
  }

  void crearCampoTexto() {
    cp5.addTextfield("input")
      .setPosition(width / 2, height /2 )
      .setSize(200, 40)
      .setFont(fuenteJuego)
      .setFocus(true)
      .setColor(color(255, 255, 255));
  }

  void enviar() {
    if (keyPressed && listo)
      if (key == TAB) {
        listo = false;
        nombre = cp5.get(Textfield.class, "input").getText();
        cp5.remove("input");
        nuevoNombre = true;
      }
  }

  void agregarPuntaje(Jugador jugador) {
    if (nuevoNombre == true) {
      TableRow newRow = tabla.addRow();
      newRow.setInt("Puntos", jugador.puntos);
      newRow.setString("Nombre", nombre);

      saveTable(tabla, "leaderboard.csv");
    }
  }
}