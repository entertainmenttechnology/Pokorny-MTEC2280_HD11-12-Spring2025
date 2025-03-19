/*
  "SERIAL COMMS INTRO - BASIC UART"
  - Sending Data from MicroController Hardware to Processing Software

  DEMO FOR SENDING SERIAL DATA FROM ARDUINO TO PROCESSING
  READS ANALOG SENSOR AND WRITES VALUE TO SERIAL PORT
  IMPLEMENTS REPEATING SOFTWARE TIMER TO STABILIZE SERIAL COMMS

  NOTE:
  - You must STOP Processing Sketch before uploading to MCU.
  - Otherwise, the UART port used for upload will be blocked by UART comms to Processing
*/



const int adcPin = 1; //sensor hooked up to GPIO Pin 1
int adcRead = 0;  //variable to store our Analog-to-Digital Conversion value

//software timer variables
int lastTime = 0;
int currentTime = 0;
int timerInterval = 20; //not reliable with values less than 20ms

/*
NOTE:
- experiment with different baud rates (as long as both Tx & Rx side match) and timerInterval values
to see what effect it has on UART.
*/

void setup() 
{
  Serial.begin(115200);     // Start serial communication @ 115200 baud rate
  analogReadResolution(8);  //adjust adc read range to 0-255, 1-byte, 8-bit
}

void loop() 
{
  //we don't want or need to send updates to serial port so often, so use a timer:
  currentTime = millis(); //read current elapsed time
  if (currentTime - lastTime >= timerInterval)  //if we have reached our timer interval...
  {
    lastTime = currentTime; //store current time as last time so we know when timer last occured
    adcRead = analogRead(adcPin); //read sensor and assign to variable called adcRead

    /*
      NOTE: Uncomment Serial.println() OR Serial.write(), but not both!
    */

    //Serial. println(val); //to send human-readable data to Arduino monitor
    Serial.write(adcRead);  //to send binary data to Processing

    //code in here will only run every 20ms, freeing up our CPU for other tasks
  }

  //anything you add here will run more frequently than code inside of above if statement
}
