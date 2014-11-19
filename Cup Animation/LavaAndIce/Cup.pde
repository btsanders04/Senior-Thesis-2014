
class Cup {
  
  float cupPositionX;
  float cupPositionY;
  PVector cupCenter;
  int plus =100;
  Cup(){ 
  }
  
  void drawCircle()
  {
    cupCenter= new PVector(mouseX,mouseY);
    ellipse(cupCenter.x,cupCenter.y,100,100);

  }
  
  void drawFire()
  {
    loadPixels();
    for(int x=0;x<1040;x++) {
      for(int y=0;y<1040;y++) {
        int loc = x + y*1040;
        float r= red (background.pixels[loc]);
        float g= green (background.pixels[loc]);
        float b= blue (background.pixels[loc]);
        float distance = dist(x,y,cupCenter.x,cupCenter.y);
        float heatUp = (plus/distance);
        if(distance<60){
        r+= heatUp;
        g-= heatUp;
        b-= heatUp;
        }
        r=constrain(r,0,255);
        g=constrain(g,0,255);
        b=constrain(b,0,255);
        color c = color(r,g,b);
        pixels[loc]=c;
    }
   }
   plus+=10;
  }
 }
