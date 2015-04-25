//creates the whole matrix that reacts to music. It is made out of many small cubes, and overall represents a large cube
class Matrix{
  float scale;
  float intensity;
  Cube cube;
  public Matrix(){
    
  }

  void MixChannel(){
     rotateX(PI/2);
     colorMode(HSB,colorRange);
     color mixColor = color(intensity*randomColor,colorRange,colorRange);
     
     //creates a new cube that changes its height based on the volume of the music. Scaled inward, so the center of the matrix grows larger
     //and surrounding cubes decrease in size from there
     cube=new Cube(0,0,20,20,song.mix.level()*height*scale, mixColor);
     
     //stars are the same color as the cube
     starColor=mixColor;

  }
  
  //This draws each matrx on the face of the overall cube. Individual cubes are drawn from the center and then outward from there. They are scaled based
  // on their location giving a pyramid effect.
  public void drawMatrix(){
   
    for(int x=-60;x<=60;x+=20){
      for(int y=-60;y<=60;y+=20){
          if (x==-60 || x ==60 || y == -60 || y == 60){
            scale=.25;
            intensity=1;
          }
          else if(x==-40 || x == 40 || y == -40 || y == 40){
            scale=.5;
            intensity=1.3;
          }
          else if(x==-20 || x==20 || y == -20 || y==20){
            scale=.75;
            intensity=1.5;
          }
          else {
            scale=1;
            intensity=1.7;
          }
          pushMatrix();
          
          translate(x,y);
          MixChannel();
          popMatrix();    
      }
    }
   }


//draws the entire overall cube with each individual matrix of cubes facing outward.
  public void drawCube(){
   pushMatrix();
   translate(0,80,0);
   rotateX(-PI/2);
   r.drawMatrix();
   popMatrix();
   
   pushMatrix();
   translate(0,-60,20);
   rotateX(PI/2);
   r.drawMatrix();
   popMatrix();
   
   pushMatrix();
   translate(80,20,20);
   rotateY(PI/2);
   r.drawMatrix();
   popMatrix();
   
   pushMatrix();
   translate(-60,20,0);
   rotateY(-PI/2);
   r.drawMatrix();
   popMatrix();
   
   pushMatrix();
   translate(0,20,80);
   r.drawMatrix();
   popMatrix();
   
   pushMatrix();
   translate(0,0,-60);
   rotateX(-PI);
   r.drawMatrix();
   popMatrix();
 
  }  
}
