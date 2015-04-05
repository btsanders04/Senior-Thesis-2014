class Tile {
  PVector p;
  Tile(PVector pos){
    p=pos;
  }
  
  void draw(){
    stroke(256);
    rectMode(CENTER);
    rect(p.x,p.y,tileSize,tileSize);
  }
  
}
