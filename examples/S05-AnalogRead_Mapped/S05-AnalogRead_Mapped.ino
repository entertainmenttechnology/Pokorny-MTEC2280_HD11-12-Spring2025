/*
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>


REFERENCE:
- https://docs.arduino.cc/language-reference/en/functions/analog-io/analogRead/
- https://docs.arduino.cc/language-reference/en/functions/analog-io/analogReadResolution/
- https://docs.arduino.cc/language-reference/en/functions/math/map/

<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
*/
const int pinRGB = 38;
const int potPin = 1;
const int numReads = 16;
int reading[numReads];
int count = 0;

void setup() 
{
  // initialize serial communication at 115200 bits per second:
  Serial.begin(115200);
  analogReadResolution(11);
}

void loop() 
{
  reading[count] = analogRead(potPin);
  count++;

  if (count >= numReads)
  {
    count = 0;
  }

  int sum = 0;

  for (int i = 0; i < numReads; i++)
  {
    sum += reading[i];
  }

  int analogValue = sum / numReads;
  
  //map(input value, input low, input high, output low, output high)
  int mapVal = map(analogValue, 0, 1618, 0, 255);
  
  rgbLedWrite(38, mapVal, 0, 0);

  Serial.printf("ADC raw = %i \t ADC averaged = %i \t ADC mapped = %i \n", analogRead(potPin), analogValue, mapVal);
}
