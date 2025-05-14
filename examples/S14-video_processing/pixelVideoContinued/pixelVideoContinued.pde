//add video library
import processing.video.*;

//video capture object
Capture video;

int pixelSize = 16;
int threshold = 150;

float nR;
float nG;
float nB;

void setup() 
{
  size(1280, 720);
  noStroke();
  rectMode(CENTER);

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
    video = new Capture(this, width, height, cameras[1]);  //select your camera from list
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
      // Get the R,G,B, Bright values from image
      float r = red   (video.pixels[loc]);
      float g = green (video.pixels[loc]);
      float b = blue  (video.pixels[loc]);
      float bright = brightness (video.pixels[loc]);
      if(x % pixelSize == 0 && y % pixelSize == 0)
      {
        if (r > threshold)
        {
          nR = 255;
        }
        else if (r > threshold/2)
        {
          nR = 127;
        }
        else
        {
          nR = 0;
        }
         
        if (g > threshold)
        {
          nG = 255;
        }
        else if (g > threshold/2)
        {
          nG = 64;
        }
        else
        {
          nG = 0;
        }

        if (b > threshold)
        {
          nB = 255;
        }
        else if (b > threshold/2)
        {
          nB = 32;
        }
        else
        {
          nB = 0;
        }
        
        int c = color(nR, nG, nB);
        fill(c);
        
       float size = map(bright, 64, 255, 1, pixelSize);

        if (bright > 200)
        {
          circle(x, y, size);
        }
        else
        {
          square(x, y, size/2);
        }
      }
    }
  }

   //tint(255, 255, 255, 64);
   //image(video, 0, 0, width, height);
}
