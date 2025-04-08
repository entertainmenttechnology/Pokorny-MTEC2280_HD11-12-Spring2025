///////////////////////////////////////////////////////
/*
DEMO: SENDING DATA FROM PROCESSING TO ARDUINO
Pair with Arduino demo sketch to control motor.

Motor angle corresponds with mouseY position.
Click button for a motor sweep.

Note: Be sure to specify correct port number below!
 */
///////////////////////////////////////////////////////

int val = 0; //data to send over Serial

//button interface
int buttonWidth = 150;
int buttonHeight = 50;
boolean button = false;

import processing.serial.*;  //import Serial library

Serial myPort;  // create object from Serial class

void setup() 
{
  size(500, 500); 
  textSize (25);
  textAlign (CENTER, CENTER);
  rectMode (CENTER);

  //Serial communication setup
  printArray(Serial.list()); // prints port list to the console
  String portName = Serial.list()[0]; //change to match your port
  myPort = new Serial(this, portName, 115200); //initialize Serial communication at 115200 baud
}

void draw() 
{
  //____GFX_START____
  background(255);  //clear frame
  //background gradient 1
  for (int i = 0; i < height/2; i++)
  {
    int c = int(map(i, 0, height/2, 0, 255));  //map to color range
    stroke(c);  //change stroke color for each y position
    line(0, i, width, i);
  }
  //background gradient 2
  for (int i = height; i > height/2; i--)
  {
    int c = int(map(i, height/2, height, 255, 0));  //map to color range, inverted
    stroke(c);  //change stroke color for each y position
    line(0, i, width, i);
  }
  //center line
  stroke(127);
  line(0, height/2, width, height/2);
  //button
  fill(64);
  rect (width/2, height/2, buttonWidth, buttonHeight);
  //text
  fill(255);
  text ("THIS WAY", width/2, 100);
  text ("THAT WAY", width/2, height-100);
  text ("CLICK HERE", width/2, height/2);
  //mouse position indicator
  fill(255, 0, 0);
  circle(mouseX, mouseY, 20);
  //____GFX_END____
  
  if (button == false)  // if mouse button not pressed
  {
    val = int (map (mouseY, 0, width, 0, 180)); //remap mouseY to 0-180 angle range for servo
    myPort.write(val); //send value of 0 to 180 across Serial, based on mouse Y position
  }
}

void mousePressed() 
{
  // if mouse button is pressed and mouse position is within bounds of rectangular "click here" button...
  if (mouseX > width/2 - buttonWidth/2 && mouseX < width/2 + buttonWidth/2 && mouseY > height/2 - buttonHeight/2 && mouseY < height/2 + buttonHeight/2) 
  { 
    button = true;     //set button state to true, so we don't send two conflicting pieces of data (see line 77)
    myPort.write(255); //send value of 255 across Serial
  }
  
  button = false; //returns button state to false, since we are done sending data
}
