//Code from PixelExample6

PImage img1, img2;
ArrayList<Creature> creatures;
ArrayList<PVector> targets1, targets2;
int scaler = 2; // will use only every 2nd pixel from the image
int threshold = 200;
boolean imageToggled = false;
color col1, col2;
Player player;
boolean goal;
int level = 1;

void setup() {
  frameRate(60);
  size(50, 50, P2D);  
  img1 = loadImage("maze1.png");
  img2 = loadImage("maze2.jpg");
  
  // set the window size to the largest sides of each image
  int w, h;
  if (img1.width > img2.width) {
    w = img1.width;
  } else {
    w = img2.width;
  }
  if (img1.height > img2.height) {
    h = img1.height;
  } else {
    h = img2.height;
  }
  surface.setSize(w, h);

  img1.loadPixels();
  img2.loadPixels();
  
  targets1 = new ArrayList<PVector>();
  targets2 = new ArrayList<PVector>();

  col1 = color(255, 255, 255);
  col2 = color(255, 255, 255);
    
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
  for (int x = 0; x < img1.width; x += scaler) {
    for (int y = 0; y < img1.height; y += scaler) {
      // this translates x and y coordinates into a location in the pixels array
      int location = x + y * img1.width;

      if (brightness(img1.pixels[location]) < threshold) {
        int targetIndex = int(random(0, targets2.size()));
        targets1.add(new PVector(x, y));
        Creature creature = new Creature(x, y, col1, targets2.get(targetIndex));
        creatures.add(creature);
      }
    }
  } 
  
  player = new Player(255);
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
  
  print("\nplayer y:"+player.position.y);
  if((player.position.y == 0 && level%2 != 0) || (player.position.y == height-1 && level%2 == 0)) {
     goal = true; 
     level++;
  }
  
  if (flipTargets == true && goal == true) {
    for (Creature creature : creatures) {
      if (!imageToggled) {
        int targetIndex = int(random(0, targets1.size()));
        creature.target = targets1.get(targetIndex);
        creature.col = col2;
      } else {
        int targetIndex = int(random(0, targets2.size()));
        creature.target = targets2.get(targetIndex);
        creature.col = col1;
      }
    }
    imageToggled = !imageToggled;
  }
    
  player.run();
  
  surface.setTitle("" + frameRate);
}

void generateMap(PImage image, ArrayList<PVector> targets) {
  
  for (int x = 0; x < image.width; x += scaler) {
    for (int y = 0; y < image.height; y += scaler) {
      // this translates x and y coordinates into a location in the pixels array
      int location = x + y * image.width;

      if (brightness(image.pixels[location]) < threshold) {
        targets.add(new PVector(x, y));
      }
    }
  } 
}

void switchUp(Creature creature, ArrayList<PVector> targets, color col) {
  int targetIndex = int(random(0, targets.size()));
  creature.target = targets.get(targetIndex);
  creature.col = col;
  
}
