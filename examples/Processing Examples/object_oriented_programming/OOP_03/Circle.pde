class Circle 
{
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
  
  Circle(int tempR, int tempG, int tempB, int tempA, int tempSize)
  {
    r = tempR;
    g = tempG;
    b = tempB;
    a = tempA;
    size = tempSize;
    xDir = 0;
    xDir = 0;
    xPos = random(0, width);
    yPos = random(0, height);
    xSpeed = random(0.75, 10);
    ySpeed = random(0.75, 10);
  }
  
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
  
  void setXSpeed(float tempXSpeed)
  {
    xSpeed = tempXSpeed;
  }
  
  void setYSpeed(float tempYSpeed)
  {
    ySpeed = tempYSpeed;
  }
  
  void setColor(int tempR, int tempG, int tempB, int tempA)
  {
    r = tempR;
    g = tempG;
    b = tempB;
    a = tempA;
  } 
  
  void setSize(int tempSize)
  {
    size = tempSize;
  }
}
