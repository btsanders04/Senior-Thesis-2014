class Matrix{
  float scale;
  float intensity;
  Cube cube;
  public Matrix(){
    
  }
 /* 
  void Kick(){
    
    if ( beat.isKick() ) 
    {
     kickSize = 100;
     kickC=100;
    }
   rotateX(PI/2);
   colorMode(HSB,100);
 //  fill(scale*kickC,255,kickC);
   color kickColor= color(scale*kickC,255,kickC);
   cube=new Cube(0,0,20,20,kickSize*scale,kickColor);
   kickSize = constrain(kickSize * 0.95, 50, 100);
   kickC= constrain(kickC*0.95,10,100);
  }
  
  void Snare(){
     if ( beat.isSnare() ) 
  {
    snareSize = 100;
    snareC=100;
  }
   rotateX(PI/2);
   colorMode(HSB,100);
  // fill(scale*snareC,25,snareC);
   color snareColor = color(scale*snareC,25,snareC);
   cube=new Cube(0,0,20,20,snareSize*scale,snareColor);
   snareSize = constrain(snareSize * 0.95, 50, 100);
   snareC= constrain(snareC*0.95,10,100);
  }
  
  void Hat(){
     if ( beat.isSnare() ) 
  {
    hatSize = 100;
    hatC=100;
  }
   rotateX(PI/2);
   colorMode(HSB,100);
   fill(scale*hatC,50,hatC);
   color hatColor= color(scale*hatC,50,hatC);
   cube=new Cube(0,0,20,20,-hatSize*scale,hatColor);
   hatSize = constrain(hatSize * 0.95, 50, 100);
   hatC= constrain(snareC*0.95,10,100);
  }
  
  void LeftChannel(){
     rotateX(PI/2);
     colorMode(HSB,100);
    // fill(scale*randomColor,255,75);
     color leftColor=color(scale*randomColor,255,75);
     cube=new Cube(0,0,20,20,-song.left.level()*height*scale,leftColor);

     
   //  kickC= constrain(kickC*0.95,10,75);
  }
  
   void RightChannel(){
     rotateX(PI/2);
     colorMode(HSB,100);
    // fill(scale*randomColor,150,100);
    color rightColor = color(scale*randomColor,150,100);
     cube=new Cube(0,0,20,20,song.right.level()*height*scale, rightColor);
  }
  */
   void MixChannel(){
     rotateX(PI/2);
     colorMode(HSB,colorRange);
   //  fill(scale*randomColor,150,150);
     color mixColor = color(intensity*randomColor,colorRange,colorRange);
     cube=new Cube(0,0,20,20,song.mix.level()*height*scale, mixColor);
     starColor=mixColor;
     colorMode(RGB,255);
  }
 
  void ReverseMixChannel(){
     rotateX(PI/2);
     colorMode(HSB,colorRange);
   //  fill(scale*randomColor,150,150);
     color mixColor = color(intensity*randomColor,colorRange,colorRange);
     cube=new Cube(0,0,20,20,song.mix.level()*height*scale, mixColor);
     starColor=mixColor;
     colorMode(RGB,255);
  }
  
  public void drawMatrix(int face){
   
    for(int x=-60;x<=60;x+=20){
      for(int y=-60;y<=60;y+=20){
          if (x==-60 || x ==60 || y == -60 || y == 60){
         // scale=random(0,.25);
          scale=.25;
       //   intensity=random(0,.25);
          intensity=1;
          }
          else if(x==-40 || x == 40 || y == -40 || y == 40){
         // scale=random(.25,.5);
         scale=.5;
       //   intensity=random(.25,.5);
          intensity=1.3;
          }
          else if(x==-20 || x==20 || y == -20 || y==20){
         // scale=random(.5,.75);
         scale=.75;
        //  intensity=random(0,.25);
          intensity=1.5;
          }
          else {
         //   scale=random(.75,1);
         scale=1;
      //    intensity=random(.75,1);
           intensity=1.7;
          }
          pushMatrix();
          translate(x,y);
          switch(face){
            
        /*    case(1):Hat();
            break;
            case(2):Snare();
            break;
            case(3):Kick();
            break;
            case(4):LeftChannel();
            break;
            case(5):RightChannel();
            break;
      */    case(6):MixChannel();
            break;
            case(7):ReverseMixChannel();
            break;
          }
          popMatrix();    
      }
    }
   }

public void drawCube(){
 pushMatrix();
 translate(0,80,0);
 rotateX(-PI/2);
 r.drawMatrix(6);
 popMatrix();
 
 pushMatrix();
 translate(0,-60,20);
 rotateX(PI/2);
 r.drawMatrix(6);
 popMatrix();
 
 pushMatrix();
 translate(80,20,20);
 rotateY(PI/2);
 r.drawMatrix(6);
 popMatrix();
 
 pushMatrix();
 translate(-60,20,0);
 rotateY(-PI/2);
 r.drawMatrix(6);
 popMatrix();
 
 pushMatrix();
 translate(0,20,80);
 r.drawMatrix(6);
 popMatrix();
 
 pushMatrix();
 translate(0,0,-60);
 rotateX(-PI);
 r.drawMatrix(6);
 popMatrix();
 
}  
}
