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

//object to stream music
Minim minim;

//loads streaming URL
AudioPlayer song;


Box2DProcessing box2d;


//List of all the particles on the screen.
ArrayList<Particle> particles;


//used to smooth the creation of the ground
float y;
float easing =0.1;

//object that receives TUIO data from table
TuioProcessing tuioClient;

boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks


double maxintensity =0.2;
int bounce = 120;


void setup() {
  
  
  size(1000, 750);
  
  //create A box2D world allowing for physics of particles
  box2d = new Box2DProcessing(this);
  
  //setting the gravity centered downward at 10 m/s^2
  Vec2 gravity = new Vec2(0, -10);
  
  //creates the physics world with a global force of gravity that acts on everything within the world
  box2d.createWorld(gravity);
  
  //detects if any collisions happen
  box2d.listenForCollisions();
 
 //load Internet radio station to stream music for the particles to react to
  minim = new Minim(this);
  song = minim.loadFile("http://87.229.26.112:8070/live.mp3");
  song.play();


//drawing the left and right walls creating a well that traps the excited particles
  rectMode(CORNERS);
  Boundary leftwall=new Boundary(-1, height/2, 10, height, new Vec2(0, 0));
  Boundary rightwall=new Boundary(width, height/2, 10, height, new Vec2(0, 0));
  
  particles = new ArrayList<Particle>();
  tuioClient  = new TuioProcessing(this);
  
}

void draw() {

  background(0);
  
  //Gets all the current Tuios that have been sent from CCV
  ArrayList<TuioCursor> tuioCursorList = tuioClient.getTuioCursorList();
  for (int i=0; i<tuioCursorList.size (); i++) {
    TuioCursor tcur = tuioCursorList.get(i);
    float sz = random(4, 8);
    particles.add(new Particle(tcur.getScreenX(width), 
                               tcur.getScreenY(height), sz, random(0, 100)));

  //prevents the number of particles on the screen from being over 700 in order to maintain frame rate. kills the particles with the longest life
    if (particles.size()>700) {
      particles.get(0).killBody();
      particles.remove(0);
    }

  } 


//display the visual aspects of a particle
  for (Particle p : particles) {
    p.display();
  }

//the volume of the music turned into a velocity
  Vec2 v = new Vec2(0, song.mix.level()*bounce);
  float targety=song.mix.level()*10;
  float dy = targety - y;
  if (abs(dy) > 1) {
    y += dy * easing;
  }

//the bottom boundary of the well that actually changes its height and velocity with the volume of the music. This is what 
//causes the particles to shoot off because they are colliding with this ever changing ground, similiar to the membrane of a speaker.
// The louder the music the higher the ground and the larger the force accompanying it.
  Boundary ground = new Boundary(width/2, height, width+10, y, v);
  ground.display();
  
  //iterates the physics world to determine all new collisions, iteractions, recalculate velocities, etc.
  box2d.step();
  
  //once everything has been accounted for and all changes have taken place, previous ground is deleted for new ground to be drawn at the new volume level.
  //This happens fast enough to provide the effect of an oscillating invisible ground
  ground.killBody();
 
  fill(0);
  
  //debug to see how many processes can run before framerate drops
  //text("framerate: " + (int)frameRate, 12, 16);

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

