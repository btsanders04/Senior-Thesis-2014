class Tile {
  PVector p;
  Tile(PVector pos){
    p=pos;
  }
  
  draw(){
    rectMode(CENTER);
    rect(p.x,p.y,tileSize,tileSize);
  }
  
}
