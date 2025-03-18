/*
Reads values from serial port, written to the port by Microcontroller.
 The size of an ellipse changes according to the serial values.
 Must assign the correct port, see instructions below!
 
 REFERENCE:
 - https://processing.org/reference/libraries/serial/Serial.html
 - https://processing.org/reference/libraries/serial/Serial_read_.html
 */

import processing.serial.*; //imports Serial library from Processing

Serial myPort; // creates object from Serial class
int val = 0; // creates variable for data coming from serial port

void setup() 
{
  size(400, 400);  //create display window at given width & height
  textAlign(CENTER);
  textSize(64);
  
  /*
   IMPORTANT: We must tell Processing which port to read from.
   Run the sketch and check your console to see the results of printArray(Serial.list());
   and that is how you know the port to use.
   On my Mac, it is port 2 and so I open Serial.list()[2].
   */

  printArray(Serial.list()); // this line prints the port list to the console
  String portName = Serial.list()[2]; //change the number in the [] for the port you need
  myPort = new Serial(this, portName, 115200);  //open selected port at given baud rate
}

void draw() 
{
  if (myPort.available() > 0) // If data is available,...
  { 
    val = myPort.read();       // ...read it and store it in val
  }

  //draws an ellipse that grows and shrinks in relation to val
  background(255);
  fill (0);
  ellipse (width/2, height/2, val, val);
  //prints val to screen canvas
  text(val, width / 2, height / 6);
  
  //println (val); //prints to Processing console
  
  /*
    NOTE: You can print to Processing console in this config, but you can't open Arduino IDE Serial Monitor!
    - This will interrupt communication between MCU & Processing
  */
}
