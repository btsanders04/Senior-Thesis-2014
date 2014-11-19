/**
  * This sketch demonstrates how to use the BeatDetect object in FREQ_ENERGY mode.<br />
  * You can use <code>isKick</code>, <code>isSnare</code>, </code>isHat</code>, <code>isRange</code>, 
  * and <code>isOnset(int)</code> to track whatever kind of beats you are looking to track, they will report 
  * true or false based on the state of the analysis. To "tick" the analysis you must call <code>detect</code> 
  * with successive buffers of audio. You can do this inside of <code>draw</code>, but you are likely to miss some 
  * audio buffers if you do this. The sketch implements an <code>AudioListener</code> called <code>BeatListener</code> 
  * so that it can call <code>detect</code> on every buffer of audio processed by the system without repeating a buffer 
  * or missing one.
  * <p>
  * This sketch plays an entire song so it may be a little slow to load.
  * <p>
  * For more information about Minim and additional features, 
  * visit http://code.compartmental.net/minim/
  */

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
  
  public void draw(){
   // fill(255,0,0);
    stroke(face);
    rectMode(CORNER);
    rect(xOrig,yOrig,recWidth,recHeight);
   
   
    pushMatrix();
    translate(0,0,recDepth);
    rect(xOrig,yOrig,recWidth,recHeight);
    popMatrix();
  //  fill(0,255,0);
  
    pushMatrix();
    rotateX(PI/2);
    translate(0,-yOrig,-yOrig);
    rect(xOrig,yOrig,recWidth,recDepth);
    translate(0,0,-recHeight);
    fill(face);
    rect(xOrig,yOrig,recWidth,recDepth);
    noFill();
    popMatrix();
//fill(0,0,255);
    pushMatrix();
    rotateY(-PI/2);
    translate(-xOrig,0,-xOrig);
    //translate(-recWidth,0,0);
    rect(xOrig,yOrig,recDepth,recHeight);
    translate(0,0,-recWidth);
    rect(xOrig,yOrig,recDepth,recHeight);
    popMatrix();
    
  }
}


