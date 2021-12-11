//for emergency use and shouldn't be used in actual gameplay
//if screen is too small, might not be to reach goal or interact with player upon start of game

void keyPressed() {
  PVector mouse = new PVector(mouseX, mouseY);
  if (key == 'P'){
    player.position = mouse;
  } 
  if (key == '['){
    level--;
  } 
  if (key == '}'){
    level++;
  } 
}
