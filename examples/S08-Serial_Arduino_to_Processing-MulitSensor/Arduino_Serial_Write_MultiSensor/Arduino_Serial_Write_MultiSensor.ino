/*
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
||||||||||||||||||||||||||||||||||||||||||||
||    "Multiple Sensors to Processing"    ||
||||||||||||||||||||||||||||||||||||||||||||     
- Example of sending 4 bytes via UART to Processing
- We are using the ASCII character 'e' to signal end of transmitted message  
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
*/

//Define Pins
const int adcPin_1 = 1;
const int adcPin_2 = 2;
const int buttonPin_1 = 20;
const int buttonPin_2 = 21;

//Button Variables
bool buttonState_1 = 0;
bool buttonState_2 = 0;

//Pot Variables
int adcRead_1 = 0;
int adcRead_2 = 0;

//Software Timer Variables
int lastTime = 0;
int currentTime = 0;
int timerInterval = 20; //not reliable with values less than 20ms

void setup() 
{
  //set button pin modes to Input with internal Pullup resistors
  pinMode(buttonPin_1, INPUT_PULLUP); 
  pinMode(buttonPin_2, INPUT_PULLUP);
  analogReadResolution(8);  //since we only need 0-255 range, set ADC resolution to 8-bit (1-byte)
  Serial.begin(115200); //start serial comm @ 115200 baud rate
}

void loop() 
{
  //map ADC read from 0 to 255 range into -128 to 127 range
  //Processing handles bytes as -128 to 127 range, so we need to adjust
  adcRead_1 = map(analogRead(adcPin_1), 0, 255, -128, 127);
  adcRead_2 = map(analogRead(adcPin_2), 0, 255, -128, 127);
  //read button state on pins [NOTE: logic is inverted due to Pullup config]
  buttonState_1 = !digitalRead(buttonPin_1);
  buttonState_2 = !digitalRead(buttonPin_2);

  /*
    printf() is only for debugging, not for UART-to-Processing communication
    do not use Serial.printf() and Serial.write() at the same time!
  */
  // Serial.printf("%i \t %i \t %i \t %i \n", adcRead_1, adcRead_2, buttonState_1, buttonState_2);

  currentTime = millis(); //read current elapsed time
  if (currentTime - lastTime >= timerInterval)  //if we have reached our timer interval...
  {
    lastTime = currentTime; //store current time as lastTime so we know when timer last triggered

    //Send Data to Processing via Serial UART
    Serial.write(buttonState_1);  //send 1st byte
    Serial.write(buttonState_2);  //send 2nd byte
    Serial.write(adcRead_1);      //send 3rd byte
    Serial.write(adcRead_2);      //send 4th byte
    Serial.write('e');            //send 'e' ASCII character to signal end of message
  }
}
