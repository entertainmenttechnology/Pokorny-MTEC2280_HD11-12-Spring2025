Circle[] circles = new Circle[10];

void setup()
{
  size(500, 500);
  
  for (int i = 0; i < circles.length; i++)
  {
    circles[i] = new Circle(i * 3, i * 5, i * 2, i * 20, 40); 
  }
}

void draw()
{
  background(255);
  
  for (int i = 0; i < circles.length; i++)
  {
    circles[i].move();
    circles[i].display();
  }
}

void mousePressed()
{
  for (int i = 0; i < circles.length; i++)
  {
    circles[i].setXSpeed(random(0, 10));
    circles[i].setYSpeed(random(0, 10));
  }
}

void keyPressed()
{
  if (key == 'a')
  {
    for (int i = 0; i < circles.length; i++)
    {
      circles[i].setColor(0, 255, 0, 127);
      circles[i].setSize(60);
    }
  }
  
  if (key == 's')
  {
    for (int i = 0; i < circles.length; i++)
    {
      circles[i].setSize(int(random(10, 150)));
    }
  }
  
  if (key == 'd')
  {
    for (int i = 0; i < circles.length; i++)
    {
      int _r = int(random(0, 255));  //"casting": converting from float to integer
      int _g = int(random(0, 255));
      int _b = int(random(0, 255));
      int _a = int(random(0, 255));
      circles[i].setColor(_r, _g, _b, _a);
    }
  }
}
