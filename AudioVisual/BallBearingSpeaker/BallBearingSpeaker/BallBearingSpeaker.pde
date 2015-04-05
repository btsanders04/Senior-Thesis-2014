import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import ddf.minim.analysis.*;
import ddf.minim.*;

import TUIO.*;

Minim minim;
AudioPlayer song;
FFT fft;
float timeStep;
int velocityIterations;
int positionIterations;
Boundary bound;
Box2DProcessing box2d;
ArrayList<Ball> balls;
ArrayList<Particle> particles;
Boundary[] boundaries;
//Surface surface;
float y;
float easing =0.1;




TuioProcessing tuioClient;

boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks
double maxintensity =0.4;
int bounce = 20;
void setup() {
  size(1030,1030);
  box2d = new Box2DProcessing(this);
  Vec2 gravity = new Vec2(0,-10);
  box2d.createWorld(gravity);
  balls = new ArrayList<Ball>();
  box2d.listenForCollisions();
//  timeStep = 1.0f / 60.0f;
//  velocityIterations = 6;
//  positionIterations = 2;
  
//Make a Surface object.
//  surface = new Surface();
  
   minim = new Minim(this);
   song = minim.loadFile("http://87.229.26.112:8070/live.mp3");
   song.play();
  // loop the file
  // create an FFT object that has a time-domain buffer the same size as jingle's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be 1024. 
  // see the online tutorial for more info.
  //fft = new FFT(song.bufferSize(), song.sampleRate());
  // calculate averages based on a miminum octave width of 22 Hz
  // split each octave into three bands
  //fft.logAverages(22, 3);
  rectMode(CORNERS);
  //boundaries = new Boundary[fft.avgSize()];
 // int w = int(width/fft.avgSize());
 // for(int i=0;i<fft.avgSize();i++){
    //boundaries[i]= new Boundary((w+1)*i,height,w,10);
  //  boundaries[i].display();
// }
 
   Boundary leftwall=new Boundary(-1,height/2,10,height,new Vec2(0,0));
   Boundary rightwall=new Boundary(width,height/2,10,height,new Vec2(0,0));
   particles = new ArrayList<Particle>();
   
   tuioClient  = new TuioProcessing(this);
   
   
   
}
 
void draw() {
  
  background(0);
  ArrayList<TuioCursor> tuioCursorList = tuioClient.getTuioCursorList();
    for (int i=0;i<tuioCursorList.size();i++) {
      TuioCursor tcur = tuioCursorList.get(i);
       //if(mousePressed){
     float sz = random(4, 8);
    particles.add(new Particle(tcur.getScreenX(width),tcur.getScreenY(height), sz, random(0,100)));
 //   }
 
    if(particles.size()>400){
      particles.get(0).killBody();
      particles.remove(0);
      
    }
    //Ball p = new Ball();
   // balls.add(p);
  } 
  
    for(Particle p: particles){
      p.display();
    }
    
    
   //  fft.forward(song.mix);
     
    
  // avgWidth() returns the number of frequency bands each average represents
  // we'll use it as the width of our rectangles
  
  
 // for(int i = 0; i < fft.avgSize(); i++)
//  {
  //  boundaries[i].applyForce(new Vec2(0,0));
 //   boundaries[i].display();
    // draw a rectangle for each average, multiply the value by 5 so we can see it better
   // rect(i*w,height, i*w + w, height - fft.getAvg(i));
 //  Vec2 v = new Vec2(0,fft.getAvg(i)/4);
  // boundaries[i] = new Boundary(i*(w+1),height,w, constrain(fft.getAvg(i)*4,0,height), v);
 //  boundaries[i].display();
   // boundaries.add(bound);
//  }


//println(
Vec2 v = new Vec2(0,song.mix.level()*bounce);
float targety=song.mix.level()*10;
float dy = targety - y;
  if(abs(dy) > 1) {
    y += dy * easing;
  }
//float m =map(y,0,targety,10,200);
// println(v);
 Boundary ground = new Boundary(width/2,height,width+10,y,v);
 ground.display();
  box2d.step();
  ground.killBody();
 // for(int i=0;i<fft.avgSize();i++){
 //   boundaries[i].killBody();
 // }
 // boundaries.clear();
  fill(0);
 text("framerate: " + (int)frameRate,12,16);
//Draw the Surface.
//  surface.display();
}


// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
          +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}


