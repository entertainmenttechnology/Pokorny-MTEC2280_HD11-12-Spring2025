import processing.sound.*;

SoundFile soundfile;
Reverb reverb;

void setup()
{
  size(500, 500);
  background(255);
  
  soundfile = new SoundFile(this, "synth.wav");
  
  reverb = new Reverb(this);
  
  soundfile.loop();
  
  reverb.process(soundfile);
  soundfile.amp(0.5);
}

void draw()
{
  ellipse(mouseX, mouseY, 20, 20);
  
  float roomSize = map(mouseX, 0, width, 0, 1.0);
  reverb.room(roomSize);

  // Change the high frequency dampening parameter
  float damping = map(mouseX, 0, width, 0, 1.0);
  reverb.damp(damping);

  // Change the wet/dry relation of the effect
  float effectStrength = map(mouseY, 0, height, 0, 1.0);
  reverb.wet(effectStrength);
}
