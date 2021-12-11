//Code based off of PixelExample7
class Player {  
  PVector position, target;
  color col;
  float speed;
  float dotSize;
  boolean ready;
  PImage terrain;
  
  Player(color colIn) {
    position = new PVector(50,height - 50);
    target = new PVector(50, height - 50);
    col = colIn;
    speed = 0.1;
    dotSize = 20;
    ready = false;
  }
  
  void update() {
    
  }
  
  void draw() {
    ellipseMode(CENTER);
    noStroke();
    fill(col);
    ellipse(position.x, position.y, dotSize, dotSize);
  }
  
  void run() {
    update();
    draw();
  } 
  
}
