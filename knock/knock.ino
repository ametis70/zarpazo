/* El circuito:
  conexión + del piezo al pin análogico
  conexión - del piezo a tierra
  resistencia de 1MOhm conectada del analógico a tierra

http://www.arduino.cc/en/Tutorial/Knock */

// Estas constantes no cambian:
const int ledPin = 13;       // Led en el pin digital 13
const int knockSensor0 = A0; // Piezo en el pin A0
const int knockSensor1 = A1; // Piezo en el pin A1
const int knockSensor2 = A2; // Piezo en el pin A2
const int knockSensor3 = A3; // Piezo en el pin A3
const int potenciometro = A5;


// Estas variables cambian:
int sensorReading0 = 0;      // Variable para almacenar el valor leido del pin A0
int sensorReading1 = 0;      // Variable para almacenar el valor leido del pin A1
int sensorReading2 = 0;      // Variable para almacenar el valor leido del pin A2
int sensorReading3 = 0;      // Variable para almacenar el valor leido del pin A3

int threshold = 25;    // Umbral para decidir cuando el sonido es detectado como un golpe

int ledState = LOW;          // Variable para almacenar el esado del led, para así encenderlo y apagarlo



void setup() {
  pinMode(ledPin, OUTPUT);  // Se declara el led como OUTPUT
  Serial.begin(9600);       // Utilizar el puerto serial
}

void loop() {
  // read the sensor and store it in the variable sensorReading:
  sensorReading0 = analogRead(knockSensor0);
  sensorReading1 = analogRead(knockSensor1);
  sensorReading2 = analogRead(knockSensor2);
  sensorReading3 = analogRead(knockSensor3);

  // Si la lectura del sensor A0 es mayor al umbral
  if (sensorReading0 >= threshold) {
    // Se alterna el estado del led
    ledState = !ledState;
    // Se actualiza el estado del
    digitalWrite(ledPin, ledState);
    // Envía una string "a" seguida de una nueva linea
    Serial.println("a");
  }

  // Si la lectura del sensor A1 es mayor al umbral
  if (sensorReading1 >= threshold) {
    // Se alterna el estado del led
    ledState = !ledState;
    // Se actualiza el estado del
    digitalWrite(ledPin, ledState);
    // Envía una string "s" seguida de una nueva linea
    Serial.println("s");
  }

  // Si la lectura del sensor A2 es mayor al umbral
  if (sensorReading2 >= threshold) {
    // Se alterna el estado del led
    ledState = !ledState;
    // Se actualiza el estado del
    digitalWrite(ledPin, ledState);
    // Envía una string "d" seguida de una nueva linea
    Serial.println("d");
  }

  // Si la lectura del sensor A3 es mayor al umbral
  if (sensorReading3 >= threshold) {
    // Se alterna el estado del led
    ledState = !ledState;
    // Se actualiza el estado del
    digitalWrite(ledPin, ledState);
    // Envía una string "f" seguida de una nueva linea
    Serial.println("f");
  }

//Serial.println("rojo(0): " + sensorReading0 + " - verde(1): " + sensorReading1 + " - cyan(2): " + sensorReading 2 + " - violeta(3): " + sensorReading3);
//Serial.println(String("rojo es " + analogRead(sensorReading0));


// threshold = analogRead(potenciometro);
//Serial.println(threshold);

  delay(400);  // delay para evitar que se sobrecargue el buffer serial
}
