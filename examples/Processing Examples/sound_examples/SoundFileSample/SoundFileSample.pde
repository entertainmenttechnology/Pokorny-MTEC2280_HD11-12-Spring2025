/*
This is a sound file player. 

Reference: https://processing.org/reference/libraries/sound/index.html
 */


import processing.sound.*; //import Processing sound library

SoundFile file;

void setup() {
  //Load a soundfile
  file = new SoundFile(this, "vibraphon.aiff");   
  // Play the file in a loop
  file.loop();
}      


void draw() {
}
