//Code based off of PixelExample6
class Creature {

  PVector position, target;
  color col;
  float speed;
  float size;
  boolean ready;
  
  Creature(float x, float y, color colIn, PVector targetIn) {
    position = new PVector(x, y);
    col = colIn;
    target = targetIn;
    speed = 0.1;
    size = 10;
    ready = false;
  }
  
  void update() {
    position.lerp(target, speed);
    ready = position.dist(target) < 5;
  }
  
  void draw() {
    stroke(col);
    strokeWeight(size);
    point(position.x, position.y);
    
    //triangles lag the game so much, don't use
    //triangle(position.x, position.y-3, position.x-2, position.y+2, position.x+2, position.y+2);
  }
  
  void run() {
    update();
    draw();
  }

}
