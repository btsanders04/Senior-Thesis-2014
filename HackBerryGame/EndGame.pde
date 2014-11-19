class EndGame{
  
  PVector pos;
  PImage img;
  EndGame(PVector p){
    pos=p;
    img = loadImage("HackBerries.jpeg");
  }
  
  void draw(){
    image(img,pos.x,pos.y,tileSize-2,tileSize-2);
  }
  boolean Eaten(){
    if(dist(p.pos.x,p.pos.y,pos.x,pos.y)==0){
      return true;
    }
    else return false;
  }
}
