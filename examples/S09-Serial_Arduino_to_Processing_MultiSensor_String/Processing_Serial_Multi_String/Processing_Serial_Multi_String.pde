/*
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
|||||||||||||||||||||||||||||||||||||||||||
||  "Multiple Sensors from Arduino IDE"  ||
||          "String Version"             ||
|||||||||||||||||||||||||||||||||||||||||||

  - Receives String values from Arduino IDE
  - Splits String @ commas
  - Casts the split data into integer and stores in array
  
  REFERENCE:
  https://processing.org/reference/libraries/serial/index.html
  https://processing.org/reference/libraries/serial/Serial_readStringUntil_.html
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
*/

import processing.serial.*; //imports Serial library from Processing

Serial myPort; // creates object from Serial class

String myString = null; // create array of bytes for incoming serial port data

int lf = 10; //ASCII linefeed, newline equals 10

int[] val;

int xPos = 0;
int yPos = 0;
int b_1 = 0;
int b_2 = 0;
int size = 100;

void setup() 
{
  size(400, 400);  //create display window at given width & height
  textAlign(CENTER);
  textSize(20);

  printArray(Serial.list()); // this line prints the port list to the console
  String portName = Serial.list()[2]; //change the number in the [] for the port you need
  myPort = new Serial(this, portName, 115200);  //open selected port at given baud rate
}

void draw() 
{
  if (myPort.available() > 0 ) //if there is data on UART serial port...
  {
    myString = myPort.readStringUntil(lf);  //read ASCII data into string until LINE FEED
    
    if (myString != null) //if the string contains data...
    {
      println(myString);  //print myString to serial monitor, only for debugging
      val = int(split(myString, ','));  //split string into array elements @ comma, cast into integer
      println(val);  //print val to serial monitor, only for debugging
      
      //update control variables from val array
      b_1 = val[0];
      b_2 = val[1];
      xPos = int(map(val[2], 0, 1023, 0, width));
      yPos = int(map(val[3], 0, 1023, 0, height));
    }
  }
  
  //DRAW TO CANVAS
  background(size);
  
  if (b_1 == 1)  //if button 1 pressed...
  {
    size++;  //increase size
  }
  
  if (b_2 == 1)  //if button 2 pressed...
  {
    size--;  //decrease size
  }
  
  //make sure size is always between 10 and 200
  if (size < 10)
  {
    size = 10;
  }
  
  if (size > 200)
  {
    size = 200;
  }
  
  fill(255, 0, 0);
  circle(xPos, yPos, size);
  fill(255 - size);
  rect(0, 10, xPos, 20);
  rect(0, 40, yPos, 20);
  fill(255);
  text("xPos: " + xPos, width/2, 25);
  text("yPos: " + yPos, width/2, 55);
}
