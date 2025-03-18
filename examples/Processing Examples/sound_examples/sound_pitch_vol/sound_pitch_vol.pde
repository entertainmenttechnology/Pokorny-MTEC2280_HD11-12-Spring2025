import processing.sound.*;

SoundFile soundfile;

void setup()
{
  size(500, 500);
  background(255);
  
  soundfile = new SoundFile(this, "break.wav");
  
  soundfile.loop();
}

void draw()
{
   background(mouseX, mouseY, 0);
   ellipse(mouseX, mouseY, 20, 20);

  float playbackSpeed = map(mouseX, 0, width, 0.50, 2.0);
  soundfile.rate(playbackSpeed);
  
  float amplitude = map(mouseY, 0 , width, 0.05, 0.75);
  soundfile.amp(amplitude);
}
