// Librería
import processing.serial.*;

// Variables globales y objeto para Arduino
Serial arduino;

char HEADER;
int[] microswitch;

// Función para inicializar variables.
void inicializarArduino() {
  String puerto = Serial.list()[1];
  arduino = new Serial(this, puerto, 9600);
  HEADER = 'H';              // Primer caracter a enviar al monitor serial para identificar(ver función eventoSerial);
  microswitch = new int[5];  // Cantidad de valores + 1(por el Header)

  for (int i = 0; i < microswitch.length; i++) {
    microswitch[i] = 0;
  }
}

// Función para actualizar el monitor serial y guardar los valores en el arrelgo Microswitch
void eventoSerial(Serial arduino) {

  String message = arduino.readStringUntil(10);
  if (message != null) {
    String [] data = message.split(",");      // Se crea un arreglo utilizando las comas para crear los pares de indices y valores.
    //Aca comprobamos que el mensaje se este leyendo desde el principio utilizando el HEADER.
    if (data[0].charAt(0) == HEADER) {
      for (int i = 1; i < data.length - 1; i++) {
        microswitch[i] = int(data[i]);
        //println("VALOR  " + i  + " = " + microswitch[i]);  // Debugging
      }
    }
  }
}

// Función para comprobar que se presionó ALGUNO de los microswitches
int microswitch() {
 int numero = 0;
  for (int i = 0; i < microswitch.length; i++) {
    numero += microswitch[i];
  }
  // println(numero);  // Debugging
  return numero;
}

// Función para comprobar que el microswitch correcto se esté presionando.
int microswitch(int indice) {
  return microswitch[indice];
}