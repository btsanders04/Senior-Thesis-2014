//individual cubes that make up the entire matrix of cubes
public class Cube{
  float xOrig;
  float yOrig;
  float recWidth;
  float recHeight;
  float recDepth;
  color face;
  public Cube(float originX, float originY,float x, float y, float z, color c){
    recWidth=x;
    recHeight=z;
    recDepth=y;
    xOrig=originX;
    yOrig=originY;
    face=c;
    draw();
  }
  //drawn by appending rectangles together. This allows for separate coloring and filling functions. Top face is filled in while other faces
  //only have their outline
  public void draw(){
    stroke(face);
    rectMode(CORNER);
    rect(xOrig,yOrig,recWidth,recHeight);
  
    pushMatrix();
    translate(0,0,recDepth);
    rect(xOrig,yOrig,recWidth,recHeight);
    popMatrix();
    
    pushMatrix();
    rotateX(PI/2);
    translate(0,-yOrig,-yOrig);
    rect(xOrig,yOrig,recWidth,recDepth);
    translate(0,0,-recHeight);
    fill(face);
    rect(xOrig,yOrig,recWidth,recDepth);
    noFill();
    popMatrix();

    pushMatrix();
    rotateY(-PI/2);
    translate(-xOrig,0,-xOrig);
    rect(xOrig,yOrig,recDepth,recHeight);
    translate(0,0,-recWidth);
    rect(xOrig,yOrig,recDepth,recHeight);
    popMatrix();
    
  }
}


