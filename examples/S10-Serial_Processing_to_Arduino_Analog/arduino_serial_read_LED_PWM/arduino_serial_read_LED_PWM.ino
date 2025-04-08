/*
|||||||||||||||||||||||||||||||||||||||||||||||||
||          "Serial Read - LED PWM"            ||
||  Reads from Serial UART one byte at a time  ||
|||||||||||||||||||||||||||||||||||||||||||||||||

- Receives data over Serial UART port from Processing to PWM fade an LED
- Hook up LED to PWM pin 4 for this example

REFERENCE:
- https://docs.arduino.cc/language-reference/en/functions/communication/serial/read/
- https://docs.arduino.cc/language-reference/en/functions/communication/serial/available/
*/

const int LED = 4; // LED PIN
byte val; // stores data received from serial port

void setup() 
{
  pinMode(LED, OUTPUT); // set LED pin as output
  Serial.begin(115200); // Start serial communication at 115200 bps
}

void loop() 
{
  if (Serial.available()) // If data is available to read
  { 
    val = Serial.read(); // read it and store it in val
  }

  analogWrite(LED, val); //PWM write from 0 to 255
}