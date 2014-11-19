public class Star{

  PVector origin;
  int time;
  float gravity;
  float x;
  float y;
  float z;
  float velocity =10;
  float starSize;
  public Star(PVector orig, float grav){
    origin=orig;
    time=0;
    gravity=grav;
    x=orig.x;
    y=orig.y;
    z=orig.z;
  }
  
  public void draw(){
    z= velocity*time + .5*gravity*(float)Math.pow(time,2);
    pushMatrix();
    translate(0,0,z);
    fill(starColor);
      if ( beat.isKick() ) 
    {
     starSize = 10;
    }
    ellipse(x,y,starSize,starSize);
    starSize *= 0.95;
    if(starSize<1) starSize=10;
    popMatrix();
    time++;
  }
  
}
