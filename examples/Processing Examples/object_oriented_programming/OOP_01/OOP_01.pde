Circle myCircle1; //declare an object
Circle myCircle2;
Circle myCircle3;


void setup()
{
  size(500, 500);
  
  myCircle1 = new Circle(); //initialize object by calling Constructor
  myCircle2 = new Circle();
  myCircle3 = new Circle();
}

void draw()
{
  background(0);
  
  myCircle1.move();   //call methods from class
  myCircle1.display();
  
  myCircle2.move();
  myCircle2.display();
  
  myCircle3.move();
  myCircle3.display();
  
  println(myCircle1.getXPos());
}

class Circle 
{
  //class variables//
  int r;
  int g;
  int b;
  int a;
  int size;
  int xDir;
  int yDir;
  
  float xPos;
  float yPos;
  float xSpeed;
  float ySpeed;
  float currentXSpeed;
  float currentYSpeed;
  
  //class Constructor//
  Circle()
  {
    r = 255;
    g = 255;
    b = 255;
    a = 255;
    size = 50;
    xDir = 0;
    xDir = 0;
    xPos = random(0, width);
    yPos = random(0, height);
    xSpeed = random(0.75, 10);
    ySpeed = random(0.75, 10);
  }
  
  //class functions//
  void display()
  {
    ellipseMode(CENTER);
    fill(r, g, b, a);
    ellipse(xPos, yPos, size, size);
  }
  
  void move()
  {
    xPos = xPos + xSpeed;
    yPos = yPos + ySpeed;
    
    if (xPos > width || xPos <= 0)
    {
      xDir = 1;
    }
   
    if (xDir == 1)
    {
      xDir = 0;
      xSpeed = -xSpeed;
    }
    
    if (yPos > height || yPos <= 0)
    {
      yDir = 1;
    }
    
    if (yDir == 1)
    {
      yDir = 0;
      ySpeed = -ySpeed;
    }
  }
  
  float getXPos()
  {
    return xPos;
  }
  
  float getYPos()
  {
    return yPos;
  }
}
