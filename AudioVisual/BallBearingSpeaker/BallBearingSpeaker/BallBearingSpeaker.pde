import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioInput song;
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
   song = minim.getLineIn();
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
}
 
void draw() {
  
  background(0);
  if(mousePressed){
     float sz = random(4, 8);
    particles.add(new Particle(mouseX, mouseY, sz, random(0,100)));
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
Vec2 v = new Vec2(0,song.mix.level()*70);
float targety=song.mix.level()*1000;
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

