// Se declara e inicializa la variable para el pin 2
#define rojo 2
#define verde 3
#define azul 4
#define amarillo 5

// Declaración de variables
int pin2, pin3, pin4, pin5;

void setup() {
  // Se settea la tasa de bits(baudios) por segundo
  Serial.begin(9600);

  // Se configuran los pines para funcionar como input
  pinMode(rojo, INPUT);
  pinMode(verde, INPUT);
  pinMode(azul, INPUT);
  pinMode(amarillo, INPUT);

  // Inicialización de variables
  pin2 = pin3 = pin4 = pin5 = 0;
}

void loop() {

  // Si el puerto serial está disponible
  if ( Serial.available() >= 0) {

    // Se asigna el valor de la variable
    pin2 = digitalRead(rojo);
    pin3 = digitalRead(verde);
    pin4 = digitalRead(azul);
    //    pin5 = digitalRead(amarillo);
    delay(30);
    enviarDatos();
  }
}

void enviarDatos() {
  Serial.print('H');
  Serial.print(",");
  Serial.print(pin2, DEC);    // Rojo
  Serial.print(",");
  Serial.print(pin3, DEC);    // Verde
  Serial.print(",");
  Serial.print(pin4, DEC);    // Azul
  //  Serial.print(",");
  //  Serial.print(pin5, DEC);    // Naranja
  Serial.print(",");
  Serial.println();
  delay(30);
}








