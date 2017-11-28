void setup()
{
  size(500, 500);
  
  for (int i = 0 ; i < 100 ; i ++)
  {
    starX[i] = random(0, width);
    starY[i] = random(0, height / 2);
  }
  kx = random(border, width - border);
  ky = random(height / 2 + border, height - border);

  px = random(border, width - border);
  py = random(height / 2 + border, height - border);
  
  dx = width / 2;
  dy = height / 2 + 15;
  
}

float px, py;
float kx, ky;
float dx, dy;
float border = 50;
  
  
float[] starX = new float[100];
float[] starY = new float[100];

int state = 0;

void drawHouse(float x, float y)
{
  float s = 50;
  rectMode(CENTER);
  noStroke();
  fill(100, 100, 0);
  rect(x, y, s, s);
  fill(255, 100, 0);
  triangle(x - s * .6, y - s * 0.5, x, y - s, x + s * 0.6, y - s * 0.5); 
  
  // Draw the door
  if (state == 2)
  {
    fill(0);
  }
  else
  {
    fill(255, 0, 0);
  }
  
  rect(dx, dy, 20, -20);
}

void drawKey(float x, float y)
{
  stroke(0);
  noFill();
  ellipse(x, y, 10, 10);
  line(x - 5, y, x - 20, y);
  line(x-15, y, x-15, y + 5);
  line(x-10, y, x-10, y + 5);  
}

void drawPlayer(float x, float y)
{
  noFill();
  stroke(0);
  ellipse(x, y, 10, 10);
  line(x, y + 5, x, y + 20);
  line(x - 5, y + 10, x + 5, y + 10);
  line(x - 5, y + 25, x, y + 20);
  line(x + 5, y + 25, x, y + 20);
  
}

void drawStars()
{
  stroke(255);
  for(int i = 0 ; i < starX.length ; i ++)
  {
    point(starX[i], starY[i]);
  }
}

void movePlayer()
{
  if (keyPressed)
  {
    if (keyCode == LEFT)
    {
      px --;
    }
    if (keyCode == RIGHT)
    {
      px ++;
    }
    
    if (keyCode == UP)
    {
      py --;
    }
    
    if (keyCode == DOWN)
    {
      py ++;
    }
  }
}

void draw()
{
  background(0);
  noStroke();
  rectMode(CORNER);
  fill(0, 255, 0);
  rect(0, height * 0.5, width, height * 0.5);
  drawStars();
  drawHouse(width / 2, height / 2);
  
  if (state == 0)
  {
    drawKey(kx, ky);
  }
  drawPlayer(px, py);
  movePlayer(); 
  
  String message = "";
  if (state == 0)
  {
    message = "Collect the key!";
    float dist = dist(px, py, kx, ky);
    if (dist < 20)
    {
      state = 1;
    }
  }
  else if (state == 1)
  {
    message = "You got the key! Open the door!";    
    float dist = dist(dx, dy, px, py);
    if (dist < 20)
    {
      state = 2;
    }
  }
  else if (state == 2)
  {
    message = "Door open!";   
    float dist = dist(dx, dy, px, py);
    if (dist > 20)
    {
      state = 0;
      kx = random(border, width - border);
      ky = random(height / 2 + border, height - border);
    }
  }
  fill(255);
  text(message, 10, 20); 
  
}