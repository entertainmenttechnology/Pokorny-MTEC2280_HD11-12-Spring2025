/*
  ARDUINO-TO_PROCESSING VIA UART
  - Receives 4 1-byte values from arduino and stores in array
  REFERENCE:
  https://processing.org/reference/libraries/serial/index.html
  https://processing.org/reference/libraries/serial/Serial_readBytesUntil_.html
  https://processing.org/reference/Array.html
*/


import processing.serial.*; //imports Serial library from Processing

Serial myPort; // creates object from Serial class

byte[] val ; // create array of bytes for incoming serial port data

void setup() 
{
  size(400, 400);  //create display window at given width & height
  textAlign(CENTER);
  rectMode(CENTER);
  textSize(24);

  printArray(Serial.list()); // this line prints the port list to the console
  String portName = Serial.list()[2]; //change the number in the [] for the port you need
  myPort = new Serial(this, portName, 115200);  //open selected port at given baud rate
}

void draw() 
{
  if (myPort.available() > 0 ) 
  {
    //read received bytes into array until 'e' ASCII value is received
    val = myPort.readBytesUntil('e'); 
  }
  
  if (val.length == 5)
  {
    println(val); //print val array to confirm data arrived
    //mapping -128 to 127 into 0 to 255 range, and Casting to integer
    int pot_1 = int(map(val[2], -128, 127, 0, 255));
    int pot_2 = int(map(val[3], -128, 127, 0, 255));
    
    //casting Byte button values to boolean
    boolean b_1 = boolean(val[0]);
    boolean b_2 = boolean(val[1]);

    background(255);
    fill (pot_1, pot_2, 0);
    ellipse (width/2, height/2, pot_1, pot_1);
    
    if (b_1)
    {
      fill(255 - pot_2);
      rect(width/8, height/2, 90, 90);
    }
    else
    {
      fill(pot_2);
      rect(width/8, height/2, 30, 30);
    }
    
    if (b_2)
    {
      fill(255 - pot_2);
      rect(width - width/8, height/2, 90, 90);
    }
    else
    {
      fill(pot_2);
      rect(width - width/8, height/2, 30, 30);
    }
 
    //print pot values to canvas
    fill(0);
    text("POT 1: " + pot_1, width/2, height/10);
    text("POT 2: " + pot_2, width/2, height/6);
  }
}
