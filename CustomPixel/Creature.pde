class Creature {

  PVector position, target;
  color col;
  float speed;
  float size;
  boolean ready;
  
  Creature(float x, float y, color _col, PVector _target) {
    position = new PVector(x, y);
    col = _col;
    target = _target;
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
  }
  
  void run() {
    update();
    draw();
  }

}
