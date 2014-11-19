class Lava {
  int size = tileSize;
  PVector position;
  Lava(PVector pos){
    position=pos;
  }
  
 void draw(){
    pushMatrix();
    //println((position.x-tileSize/2) + " " + (position.y-tileSize/2));
   // translate((position.x-tileSize/2),(position.y-tileSize/2));
    loadPixels();
   // colorMode(HSB, 100);
   println(position.x-tileSize/2,position.y-tileSize/2);
    for(int y=(int)(position.y-tileSize/2);y<(int)(position.y-tileSize/2+tileSize);y+=tileSize)
    {
        for(int x=(int)(position.x-tileSize/2);x<(int)(position.x-tileSize/2+tileSize);x++){
        pixels[x] = color(255,0,0);
        }
    }
    updatePixels();
    popMatrix();
  }
}
