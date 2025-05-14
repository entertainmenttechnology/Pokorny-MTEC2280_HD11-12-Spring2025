/*
|||||||||||||||||||||||||||
||  "PIXEL CAMERA DEMO"  ||
|||||||||||||||||||||||||||

- uses processing video library
- captures webcam image for each frame
- modifies video image pixel-by-pixel
- applies a threshold to each color
- when pixel is above color threshold, a square is drawn

REFERENCE:
https://processing.org/reference/libraries/video/index.html
https://processing.org/tutorials/pixels/#your-very-first-image-processing-filter
https://processing.org/reference/libraries/video/captureEvent_.html
https://github.com/CodingTrain/website-archive/tree/main/Tutorials/Processing/11_video
*/

//add video library
import processing.video.*;

//video capture object
Capture video;

//declare variables
float r;
float g;
float b;
float alpha = 127;
float rThresh = 210;
float gThresh = 150;
float bThresh = 150;
int pixelSize = 8;

void setup() 
{
  size(640, 480);
  noFill();

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
      println(i + ": " + cameras[i]);  //print available cameras to serial monitor
     }
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    video = new Capture(this, cameras[1]);  //select your camera from list
    video.start();     //start video capture
  }      
}

void captureEvent(Capture video) //store video frame when available
{
  video.read();
}

void draw() 
{
  background(0);
  video.loadPixels(); 
 
  
  for (int x = 0; x < video.width; x++) //for every column...
  {
    for (int y = 0; y < video.height; y++ ) //for every row...
    {
      // Calculate the current pixel location
      int loc = x + y * video.width;
      // Get the R,G,B values from image
      float r = red   (video.pixels[loc]);
      float g = green (video.pixels[loc]);
      float b = blue  (video.pixels[loc]);
      
      if (x % pixelSize == 0 && y % pixelSize == 0)
      {

        
        if (b > bThresh)  //if this pixel's blue value is above threshold...
        {
          stroke(64, 64, 64);  //set color to dark grey
          square(x, y, pixelSize * 4);  //draw square at pixel location
        }
        
                if (g > gThresh)  //if this pixel's green value is above threshold...
        {
          stroke(127, 127, 127);  //set color to light grey
          square(x, y, pixelSize * 2);  //draw square at pixel location 
        }
        
                if (r > rThresh)  //if this pixel's red value is above threshold...
        {
          stroke(255, 255, 255);  //set color to white
          square(x, y, pixelSize);  //draw square at pixel location
        }
      }
    }
  }
  
  //uncomment this to blend in the original video image
  //tint(255, 255, 255, 127);
  //image(video, 0, 0);
}
