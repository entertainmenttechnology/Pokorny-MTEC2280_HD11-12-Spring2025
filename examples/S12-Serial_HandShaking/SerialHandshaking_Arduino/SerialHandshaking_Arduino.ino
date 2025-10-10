/*
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
|||||||||||||||||||||||||||||||||||||||||||
||        "Serial HandShaking"           ||
||||||||||||||||||||||||||||||||||||||||||| 
  - Bi-Directional Serial Communication between Microcontroller & Processing
  - Tansmits(Tx) and Receives(Rx) Serial Data
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
*/

//Define Pins
const int adcPin_1 = 1;
const int adcPin_2 = 2;
const int buttonPin_1 = 20;
const int buttonPin_2 = 21;
const int ledPin = 4;

//Button Variables
bool buttonState_1 = 0;
bool buttonState_2 = 0;

//Pot Variables
int adcRead_1 = 0;
int adcRead_2 = 0;

//Serial Rx Data Variable
int inByte = 0;

void setup()
{
  pinMode(buttonPin_1, INPUT_PULLUP); //set pin modes
  pinMode(buttonPin_2, INPUT_PULLUP);
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, 0);  //turn off led
  analogReadResolution(10);  //set analog resolution to 0-1023 range
  Serial.begin(115200); //start serial comm @ 115200 baud rate
  establishContact(); //establish first contact via Serial
}

void loop() 
{
  if (Serial.available() > 0) //if there is data received on the serial port
  {
    inByte = Serial.read(); //store data in variable
    if (inByte == 'A')  //if stored byte is equal to char 'A'
    {
      digitalWrite(ledPin, 1);  //turn on LED
      adcRead_1 = analogRead(adcPin_1); //read analog pot values
      adcRead_2 = analogRead(adcPin_2);
      buttonState_1 = !digitalRead(buttonPin_1);  //read button states
      buttonState_2 = !digitalRead(buttonPin_2);
      Serial.print(buttonState_1);  //send 1st message
      Serial.print(',');            //send comma character
      Serial.print(buttonState_2);  //send 2nd message
      Serial.print(',');            //send comma character
      Serial.print(adcRead_1);      //send 3rd message
      Serial.print(',');            //send comma character
      Serial.print(adcRead_2);      //send 4th message
      Serial.print(',');            //send comma character
      Serial.print('\n');           //send "Line Feed", or "New Line" character (you could use println() instead)
    }
    else if (inByte == 'B') //if stored byte is equal to char 'B'
    {
      digitalWrite(ledPin, 0);  //turn off LED
      Serial.println("Sensor Update Paused..."); //send string message with "New Line" at end, using println()        
    }
  }
}

void establishContact() //user-defined function for establishing 1st contact with other serial device
{
  while (Serial.available() <= 0) //if there is nothing received on the serial port
  {
    Serial.println("Hello");  // send an initial string with "New Line" at end, using println()   
    delay(300); //wait 300 milliseconds
  }
}