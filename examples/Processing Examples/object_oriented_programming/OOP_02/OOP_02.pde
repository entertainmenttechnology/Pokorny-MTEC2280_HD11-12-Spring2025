Circle myCircle;

void setup()
{
  size(500, 500);
  
  myCircle = new Circle(255, 0, 0, 127, 50);
}

void draw()
{
  background(255);
  
  myCircle.move();
  myCircle.display();
}

void mousePressed()
{
  myCircle.setXSpeed(random(0, 20));
  myCircle.setYSpeed(random(0, 20));
}

void keyPressed()
{
  if (key == 'a')
  {
    myCircle.setColor(0, 255, 0, 60);
    myCircle.setSize(100);
  }
  
  if (key == 's')
  {
    myCircle.setSize(int(random(10, 150)));
  }
  
  if (key == 'd')
  {
    int _r = int(random(0, 255));  //"casting": converting from float to integer
    int _g = int(random(0, 255));
    int _b = int(random(0, 255));
    int _a = int(random(0, 255));
    myCircle.setColor(_r, _g, _b, _a);
  }
}
