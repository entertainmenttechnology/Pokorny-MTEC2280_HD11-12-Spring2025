//add video library
import processing.video.*;

//video capture object
Capture video;

int pixelSize = 32;  //variable to set pixel size. larger value decreases resolution

void setup() 
{
  size(1280, 720);  //lower these values for better performance
  rectMode(CENTER);  //rectMode center so square is drawn at center of pixel location

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
      // Get the R,G,B, & Brightness values from image
      float r = red   (video.pixels[loc]);
      float g = green (video.pixels[loc]);
      float b = blue  (video.pixels[loc]);
      float bright = brightness (video.pixels[loc]);
      
      //if we are at next pixel location, based on pixelSize...
      if(x % pixelSize == 0 && y % pixelSize == 0)  
      {
        int c = color(r, g, b);  //set color based on r, g, b pixel values
        float size = map(bright, 0, 255, 1, pixelSize - 8);  //map size to brightness
        fill(c);  //set fill to color
        square(x, y, size - 4);//draw square
        noFill();  //remove fill
        strokeWeight(1);  
        stroke(c);  //set stroke to color
        square(x, y, size);  //draw outline of square
      }
    }
  }
  
  //Uncomment below to see original image overlay
   //tint(255, 255, 255, 64);
   //image(video, 0, 0, width, height);
}
