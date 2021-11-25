//Code from PixelExample6

PImage img1, img2, img3;
ArrayList<Creature> creatures;
ArrayList<PVector> targets1, targets2, targets3;
int scaler = 2; // will use only every 2nd pixel from the image
int threshold = 200;
boolean imageToggled = false;
color col;
Player player;
boolean goal;
int level = 1;
PImage currentMap;

void setup() {
  frameRate(60);
  size(50, 50, P2D);  
  img1 = loadImage("maze1.png");
  img2 = loadImage("maze2.jpg");
  img3 = loadImage("maze3.png");
  
  //defualt sets size to 1000x1000 because all maps are 1000x1000
  surface.setSize(1000, 1000);

  img1.loadPixels();
  img2.loadPixels();
  img3.loadPixels();
  
  targets1 = new ArrayList<PVector>();
  targets2 = new ArrayList<PVector>();
  targets3 = new ArrayList<PVector>();

  col = color(255, 255, 255);
    
  for (int x = 0; x < img1.width; x += scaler) {
    for (int y = 0; y < img1.height; y += scaler) {
      // this translates x and y coordinates into a location in the pixels array
      int location = x + y * img1.width;

      if (brightness(img1.pixels[location]) < threshold) {
        targets1.add(new PVector(x, y));
      }
    }
  } 
  
  for (int x = 0; x < img2.width; x += scaler) {
    for (int y = 0; y < img2.height; y += scaler) {
      // this translates x and y coordinates into a location in the pixels array
      int location = x + y * img2.width;

      if (brightness(img2.pixels[location]) < threshold) {
        targets2.add(new PVector(x, y));
      }
    }
  } 
  
  creatures = new ArrayList<Creature>();
  for (int x = 0; x < img3.width; x += scaler) {
    for (int y = 0; y < img3.height; y += scaler) {
      // this translates x and y coordinates into a location in the pixels array
      int location = x + y * img3.width;

      if (brightness(img3.pixels[location]) < threshold) {
        //targets should all be same size
        int targetIndex = int(random(0, targets3.size()));
        targets3.add(new PVector(x, y));
        Creature creature = new Creature(x, y, col, targets3.get(targetIndex));
        creatures.add(creature);
      }
    }
  } 
  
  color red = color(250, 125, 125);
  player = new Player(red);
}

void draw() { 
  background(0);
  
  blendMode(ADD);
  
  goal = false;
  boolean flipTargets = true;
  for (Creature creature : creatures) {
    creature.run();
    if (!creature.ready) flipTargets = false;
  }
  

  if((player.position.y == 0 && level%2 != 0) || (player.position.y == height-1 && level%2 == 0)) {
     goal = true; 
     level++;
  }
  
  if (flipTargets == true && goal == true) {
    for (Creature creature : creatures) {
      if (level == 1) {
        int targetIndex = int(random(0, targets1.size()));
        creature.target = targets1.get(targetIndex);
        creature.col = col;
      } else if (level == 2) {
        int targetIndex = int(random(0, targets2.size()));
        creature.target = targets2.get(targetIndex);
        creature.col = col;
      } else if (level == 3) {
        int targetIndex = int(random(0, targets1.size()));
        creature.target = targets1.get(targetIndex);
        creature.col = col;
      } else if (level == 4) {
        int targetIndex = int(random(0, targets2.size()));
        creature.target = targets2.get(targetIndex);
        creature.col = col;
      } else if (level == 5) {
        int targetIndex = int(random(0, targets3.size()));
        creature.target = targets3.get(targetIndex);
        creature.col = col;
      }
    }
    
    
  }
  
  PVector mouse = new PVector(mouseX, mouseY);
  
  if (level == 1){currentMap = img3;}
  else if (level == 2){currentMap = img2;}
  else if (level == 3){currentMap = img1;}
  
  int loc = int(player.target.x) + int(player.target.y) * currentMap.width;
  float b = brightness(currentMap.pixels[loc]);
  
  int loc2 = int(player.position.x) + int(player.position.y) * currentMap.width;
  float b2 = brightness(currentMap.pixels[loc2]);
  
  if ((player.position.dist(mouse) < 20))
  {
    player.target.x = mouse.x;
    player.target.y = mouse.y;
    
    while (player.target.x > player.position.x){
      if (!(b < threshold)){
        player.position.x++;
      } else {
        if (b2 < threshold){
        player.position.x-=20;}
        break;
      }
    }
    while (player.target.x < player.position.x){
      if (!(b < threshold)){
        player.position.x--;
      } else {
        if (b2 < threshold){
        player.position.x+=20;}
        break;
      }
    }

    while (player.target.y > player.position.y){
      if (!(b < threshold)){
        player.position.y++;
      } else {
        if (b2 < threshold){
        player.position.y-=20;}
        break;
      }
    }
    while (player.target.y < player.position.y){
      if (!(b < threshold)){
        player.position.y--;
      } else {
        if (b2 < threshold){
        player.position.y+=20;}
        break;
      }
    }
  }
  
  
  
  
  player.run(); 
  surface.setTitle("" + frameRate);
}
