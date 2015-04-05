class Board{
  
  int xSize;
  int ySize;
  Tile[] tiles = new Tile[(width/tileSize)*(height/tileSize)];
  Board(int x, int y){
    xSize=x;
    ySize=y;
    int i=0;
    for(int xt=0;xt<width/tileSize;xt++){
     for(int yt=0;yt<height/tileSize;yt++){
       tiles[i]= new Tile(new PVector(xt*tileSize + tileSize/2,yt*tileSize + tileSize/2));
    //   println(tiles[i].x + " " + tiles[i].y);
       i++;
     }
    }
     
  }
  
  void setup(){
    int i=0;
    for(int x=0;x<xSize;x+=tileSize){
      
      for(int y=0;y<ySize;y+=tileSize){
       tiles[i]= new Tile(new PVector(x,y));
       i++;
      }     
    }
    
  }
  
  void draw(){
  }
}
