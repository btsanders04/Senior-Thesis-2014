public class Man{
  int headSize;
  int bodySize;
  int legSize;
  int armSize;
  int scaleVibration=8;
  
  public Man(int hS, int bS, int lS, int aS)
  {
    headSize=hS;
    bodySize=bS;
    legSize=lS;
    armSize=aS;
  }
  
  public void drawMan(){
    pushMatrix();
    translate(-headSize/2,0);
    drawHead();
    popMatrix();
    pushMatrix();
    translate(0,headSize/2);
    rotate(PI/2);
    drawBody();
    popMatrix();
    pushMatrix();
    translate(0,bodySize/2);
    rotate(2*PI/3);
    drawArms();
     popMatrix();
     pushMatrix();
     translate(0,headSize/2+bodySize);
     rotate(PI/4);
     drawLegs();
     popMatrix();
  }
  
  public void drawHead(){
    stroke(255);
    noFill();
    
   
     for(int i = 0; i < groove.bufferSize() - 1; i++)
      {
   float x1 = map( i, 0, groove.bufferSize(), 0, headSize);
   float x2 = map( i+1, 0, groove.bufferSize(), 0, headSize);
   pushMatrix();
   translate(0,-headSize/2);
   line(x1,groove.left.get(i)*headSize/scaleVibration, x2,groove.left.get(i+1)*headSize/scaleVibration);
   rotate(PI/2);
   line(x1,groove.left.get(i)*headSize/scaleVibration, x2,groove.left.get(i+1)*headSize/scaleVibration);
   popMatrix();
   pushMatrix();
   translate(0,headSize/2);
   line(x1,groove.left.get(i)*headSize/scaleVibration, x2,groove.left.get(i+1)*headSize/scaleVibration);
   translate(headSize,0);
   rotate(-PI/2);
   line(x1,groove.left.get(i)*headSize/scaleVibration, x2,groove.left.get(i+1)*headSize/scaleVibration);
   popMatrix();
      }
     
  }
  
  
  public void drawBody(){
    for(int i = 0; i < groove.bufferSize() - 1; i++)
    {
    float x1 = map( i, 0, groove.bufferSize(), 0, bodySize);
    float x2 = map( i+1, 0, groove.bufferSize(), 0, bodySize);
    line(x1,groove.left.get(i)*bodySize/scaleVibration, x2,groove.left.get(i+1)*bodySize/scaleVibration);
    }
  }
  
  public void drawArms(){
    for(int i = 0; i < groove.bufferSize() - 1; i++)
    {
    float x1 = map( i, 0, groove.bufferSize(), 0, legSize);
    float x2 = map( i+1, 0, groove.bufferSize(), 0, legSize);
    line(x1,groove.left.get(i)*armSize/scaleVibration, x2,groove.left.get(i+1)*armSize/scaleVibration);
    pushMatrix();
    rotate(-PI/3);
    line(x1,groove.left.get(i)*legSize/scaleVibration, x2,groove.left.get(i+1)*armSize/scaleVibration);
    popMatrix();
    }
  }
   public void drawLegs(){
    for(int i = 0; i < groove.bufferSize() - 1; i++)
    {
    float x1 = map( i, 0, groove.bufferSize(), 0, legSize);
    float x2 = map( i+1, 0, groove.bufferSize(), 0, legSize);
    line(x1,groove.left.get(i)*legSize/scaleVibration, x2,groove.left.get(i+1)*legSize/scaleVibration);
    pushMatrix();
    rotate(PI/2);
    line(x1,groove.left.get(i)*legSize/scaleVibration, x2,groove.left.get(i+1)*legSize/scaleVibration);
    popMatrix();
   // rotate(-PI/2);
  //  line(0,0,-(legSize + groove.left.get(i)*legSize),0);
    }
  }
}
