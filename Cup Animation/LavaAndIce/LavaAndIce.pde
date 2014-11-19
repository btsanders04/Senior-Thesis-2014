PImage background;
Cup testCup;
void setup(){
  size(1040,1040,P3D);
  background=loadImage("WoodBackground.jpg");
  background.resize(1040,1040);
  background(background);
  testCup=new Cup();
}

void draw(){
  background(background);
  testCup.drawCircle();
  testCup.drawFire();
  
}
