/**
 * Continuous Lines. 
 * 
 * Click and drag the mouse to draw a line. 
 */
 
float size = 1;
int r = 0;
int g = 255;
int b = 255;
int alpha = 64;
float dir = 1;

void setup() 
{
 size(2048, 1024);
 background(0);
}

void draw() 
{
  //set stroke weaight and color with alpha transparency
  stroke(r, g, b, alpha);  
  strokeWeight(size);
  
  //increase stroke size for each frame
  size += 0.5;
  if(size > 32)  //reset if above 32
  {
    size = 1;
  }
  
  //increase red for each frame
  r++;
  if(r > 255)  //reset if above 255
  {
    r = 0;
  }
  
  //decrease blue for each frame
  b--;
  if(b < 0)
  {
    b = 255;  //reset if below 0
  }
  
  //draw line from previous frame's mouse position to current position when mouse pressed
  if (mousePressed == true) 
  {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}
