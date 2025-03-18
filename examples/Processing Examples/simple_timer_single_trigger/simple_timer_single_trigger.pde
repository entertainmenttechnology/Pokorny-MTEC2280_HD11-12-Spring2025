/* 

Creating simple timers that trigger one time only.

millis() tracks total milliseconds since sketch started.
1000 milliseconds= 1 second.

Background begins as black,
Changes to white after 4 seconds,
Changes to red after 8 seconds.

*/

int currentTime = 0; //declaring variable to track millis() clock
int timer1 = 4000;   //declaring variable for a 4 second timer
int timer2 = 8000;   //8 second timer (8 seconds = 8000 milliseconds)

void setup() 
{
  size (600, 600);
  background(0);
}

void draw() 
{
  currentTime = millis(); //continuously update our currentTime variable
  //println(currentTime);
  
  if (currentTime > timer2) 
  {
    background(255, 0, 0);
    println("timer 2 is triggered");
  } 
  else if (currentTime > timer1) 
  {
    background(255);
    println("timer 1 is triggered");
  }
}
