///////////////////////////////////////////////////////
/*
DEMO: SENDING DATA FROM PROCESSING TO ARDUINO OVER SERIAL.
Hover over text to send data to Serial.
Pair with Arduino demo sketch to control LEDs.

Note: Be sure to specify correct port number below!
 */
///////////////////////////////////////////////////////

import processing.serial.*;  //import Serial library

Serial myPort;  // create object from Serial class

void setup() 
{
  size(500, 500); 
  background (255);
  fill(0);
  textSize (22);
  textAlign (CENTER, CENTER);
  noStroke();

  //set up Serial communication
  printArray(Serial.list()); // prints port list to the console
  String portName = Serial.list()[2]; //change to match your port
  myPort = new Serial(this, portName, 115200); //initialize Serial communication at 9600 baud
}

void draw() 
{
  //draw rectangular areas
  fill(200);
  rect(0, width/2, width, height/2);
  fill(255, 255, 0);
  rect(0, 0, width/2, height/2);
  fill(0, 255, 0);
  rect(width/2, 0, width/2, height/2);
  
  //text stuff
  fill(0);
  text ("this light", width/4, height/4);
  text ("that light", width-width/4, height/4);
  text ("no light", width/2, height-height/4);

  //mouse location controls communication to Serial 
  if (mouseY > height/2 && mouseY < height) 
  {  
    myPort.write(0); //send a 0
    //println ("0");
  } 
  else if (mouseX < width/2 && mouseX > 0) 
  { //if mouse is on left side of screen
    myPort.write(1);  //write '1' to Serial port
    //println("1"); //also print '1' to console
  } 
  else if (mouseX > width/2 && mouseX < width) 
  {
    myPort.write(2);  //write '2' to Serial port
    //println ("2"); //print to '2' to console
  } 
  else 
  {  //otherwise
    myPort.write(0); //send a 0
    //println ("0");
  }
}
