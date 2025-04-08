/*
||||||||||||||||||||||||||||||||||||||||||||||||||
||  "SENDING DATA FROM PROCESSING TO ARDUINO"   ||
||  - transmitting one byte at a time via UART  ||
||||||||||||||||||||||||||||||||||||||||||||||||||

Pair with Arduino demo sketch...
  "arduino_serial_read_LED_PWM.ino"
...to control LED fade.

REFERENCE:
- https://processing.org/reference/libraries/serial/Serial_write_.html
 */


int val = 0;

import processing.serial.*;  //import Serial library

Serial myPort;  // create object from Serial class

void setup() 
{
  size(600, 300); 
  background (255);
  fill(0);
  textSize (30);
  textAlign (CENTER);

  //set up Serial communication
  printArray(Serial.list()); // prints port list to the console
  String portName = Serial.list()[2]; //change to match your port
  myPort = new Serial(this, portName, 115200); //initialize Serial communication at 115200 baud
}

void draw() 
{
  //____GFX_START____//
  //draw gradient background with for loop
  for (int i = 0; i < width; i++)
  {
    int c = int(map(i, 0, width, 0, 255));  //map i to 0-255 range for color
    stroke(c * 2, c, 0);    //change stroke color for each x position, red is scaled to 2x
    line(i, 0, i, height);  //draw vertical line for each x position
  }
  
  //text stuff
  fill(255);
  text ("DIMMER", width/4, height/2);
  fill(0);
  text ("BRIGHTER", width-width/4, height/2);
  
  //mouse position indicator
  fill(0, 0, 255);
  circle(mouseX, mouseY, 20);
  //____GFX_END____//

  //mouse location controls communication to Serial 
  val = int (map (mouseX, 0, width, 0, 255)); //remaps mouseX to 0-255 range
  myPort.write(val);   //sends val as byte across serial port

  //NOTE: IMPORTANT TO SEND VALUES 0-255 AS ARDUINO RECEIVES DATA IN BYTE-SIZE
}
