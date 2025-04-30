/*
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
|||||||||||||||||||||||||||||||||||||||||||
||        "Serial HandShaking"           ||
|||||||||||||||||||||||||||||||||||||||||||

  - Bi-Directional Serial Communication between Microcontroller & Processing
  - Tansmits(Tx) and Receives (Rx) serial data
  - Uses serialEvent method to:
    - Receive sensor data from microcontroller
    - Transmit commands to microcontroller

  REFERENCE:
  https://processing.org/reference/libraries/serial/Serial_bufferUntil_.html
  https://processing.org/reference/libraries/serial/Serial_serialEvent_.html
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
*/
import processing.serial.*;     // import the Processing serial library
Serial myPort;                  // The serial port object

boolean rxFlag = true;  //toggles sensor receive(rx) from arduino
boolean firstContact = false;
int pot1;
int pot2;    
int button1;
int button2;
int[] val = {0, 0, 0, 0};

void setup() 
{
  size(500, 500);
  textAlign(CENTER, CENTER);
  textSize(16);
  strokeWeight(12);
  stroke(255);

  printArray(Serial.list());
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 115200);
  myPort.bufferUntil('\n');  // read bytes into a buffer until you get a linefeed (ASCII 10)
}

void draw() 
{
  background(pot1, pot2, (pot1 + pot2)/2);  //set background color based on pot sensor values
  
  //pot indicator frames
  fill(0);
  rect(width/8, height/4, 60, 255);
  rect(width - width/4, height/4, 60, 255);
  
  //pot indicators
  fill(pot1, 0, 255 - pot1);
  rect(width/8, height/4, 60, pot1);
  fill(pot2, 0, 255 - pot2);
  rect(width - width/4, height/4, 60, pot2);
  
  //button indicators
  fill(button1);
  rect(width/2 + 50, height/4, 50, 50);
  fill(button2);
  rect(width/2 - 100, height/4, 50, 50);
  
  //pause button
  fill(200);
  circle(width/2, height - 60, 100);
  fill(0);
  
  if (rxFlag)  //draw text based on rxFlag state
  {
    text("PAUSE RX", width/2, height - 60);
  }
  else
  {
    text("RX PAUSED", width/2, height - 60);
  }
  
  if(!firstContact)  //draw text only if we haven't made first contact
  {
    fill(255);
    text("WAITING FOR FIRST CONTACT", width/2, height/2);
  }
}

void mousePressed()
{
  //if mouse is pressed within the pause button
  if(dist(mouseX, mouseY, width/2, height - 60) < 50 && mousePressed)
  {
    rxFlag = !rxFlag; //toggle rxFlag
  }
}

/*
  serialEvent method is called automatically by Processing whenever the buffer 
  reaches the byte value set in the bufferUntil() method in the setup():
*/

void serialEvent(Serial myPort) 
{
  if (!firstContact)  //if we have not yet made first contact...
  {
    firstContact = true;  //...then this is our first contact, set it to TRUE
  }

  String myString = myPort.readStringUntil('\n');  // read the serial buffer
  print(myString);  //print contents of serial buffer (note we are NOT using println since this message contains lineFeed)

  val = int(split(myString, ','));  // split the string at the commas and convert the sections into integers
  
  println(val);  //print val array to monitor
  
  if (val.length >= 4) //store sensors values once we have received all 4 of them
  {
    button1 = int(map(val[0], 0, 1, 0, 255));
    button2 = int(map(val[1], 0, 1, 0, 255));
    pot1 = int(map(val[2], 0, 1023, 0, 255));
    pot2 = int(map(val[3], 0, 1023, 0, 255));
  }

  if(rxFlag)
  {
    myPort.write('A');  //send char 'A' if you want to receive more sensor data
  }
  else
  {
    myPort.write('B');  //send char 'B' if you DON'T want to receive sensor data
  }
}
