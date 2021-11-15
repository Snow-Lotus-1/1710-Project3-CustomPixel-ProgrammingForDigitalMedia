class Player {  
  PVector position, target;
  color col;
  float speed;
  float dotSize;
  boolean ready;
  
  Player(color _col) {
    position = new PVector(50,height);
    target = new PVector(mouseX, mouseY);
    col = _col;
    speed = 0.1;
    dotSize = 40;
    ready = false;
  }
  
  void update() {
    target.x=mouseX;
    target.y=mouseY;
    if (position.dist(target) < 40)
    {
      position.x=target.x;
      position.y=target.y;
    }
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
