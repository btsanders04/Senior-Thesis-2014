class Player{
  
  PVector pos;
  float angle;
  PImage img = loadImage("arduinoUnoBug.jpg");
  Player(PVector p){
    pos=p;
  }
  
  void draw(){
    pushMatrix();
    imageMode(CENTER);
    translate(pos.x,pos.y);
    rotate(angle);
    image(img,0,0,tileSize-2,tileSize-2);
    popMatrix();
  }
  
  
  void moveLeft(){
    if(pos.x>tileSize)
    pos.x-=tileSize;
   // pushMatrix();
    angle=0;
   // image(img,0,0,tileSize,tileSize);
  //  popMatrix();
  }
  
  void moveRight(){
    if(pos.x<width-tileSize)
    pos.x+=tileSize;
 //   pushMatrix();
     angle=PI;
  //  image(img,0,0,tileSize,tileSize);
  //  popMatrix();
  }
  
  void moveUp(){
     if(pos.y>tileSize)
    pos.y-=tileSize;
 //   pushMatrix();
     angle=PI/2;
  
 //   image(img,0,0,tileSize,tileSize);
  //  popMatrix();
  }
  void moveDown(){
     if(pos.y<height-tileSize)
    pos.y+=tileSize;
  //  pushMatrix();
     angle=3*PI/2;
  //  image(img,0,0,tileSize,tileSize);
  //  popMatrix();
  }
}

