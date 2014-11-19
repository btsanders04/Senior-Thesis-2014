class Board{
  
  int xSize;
  int ySize;
  PVector[] tiles = new PVector[(width/tileSize)*(height/tileSize)];
  Board(int x, int y){
    xSize=x;
    ySize=y;
    int i=0;
    for(int xt=0;xt<width/tileSize;xt++){
     for(int yt=0;yt<height/tileSize;yt++){
       tiles[i]= new PVector(xt*tileSize + tileSize/2,yt*tileSize + tileSize/2);
       println(tiles[i].x + " " + tiles[i].y);
       i++;
     }
    }
     
  }
  
  void draw(){
    for(int x=0;x<xSize;x+=tileSize){
      line(x,0,x,ySize);
     
    }
    for(int y=0;y<ySize;y+=tileSize){
       line(0,y,xSize,y);
      
      }  
  }
}
