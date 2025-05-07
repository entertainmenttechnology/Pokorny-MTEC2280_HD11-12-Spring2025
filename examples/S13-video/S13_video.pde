/*
|||||||||||||||||||||||||||
||  "BASIC CAMERA DEMO"  ||
|||||||||||||||||||||||||||

- uses processing video library
- captures webcam image for each frame
- adjusts camera image color using tint

REFERENCE:
https://processing.org/reference/libraries/video/index.html
*/

//add video library
import processing.video.*;

//video capture object
Capture video;

float min = 127;
float max = 255;
float r = max;
float g = max;
float b = max;
float c = min;
float direction = 1;

void setup() 
{
  size(640, 480);

  String[] cameras = Capture.list();  //list of available cameras
  
  if (cameras.length == 0) 
  {
    println("There are no cameras available for capture.");
    exit();
  } 
  else 
  {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) 
    {
      println(cameras[i]);  //print available cameras to serial monitor
    }

    video = new Capture(this, cameras[1]);  //select your camera from list
    video.start();     //start video capture
  }      
}

void draw() 
{
  if (video.available() == true) //if video feed is available
  {
    video.read();  //capture video pixels
  }
  video.loadPixels();  //load pixels into buffer
  tint(r, g, b, 16);  //apply RGBA tint
  image(video, 0, 0);  //display image
  
  //adjusting colors by scaling c variable
  r = c;
  g = c * 0.5;
  b = c * 0.75;
  //incrementing c by direction
  c += direction;
  
  if (c > max || c < min)  //if c has reached our min or max...
  {
    direction = -direction;  //change direction
  }
}
