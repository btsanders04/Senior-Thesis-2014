// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A circular particle

class Particle {

  
  //Box2D physics body for the particle
  Body body;
  
  //radius 
  float r;
  
  //brightness of the particle, changes with volume of the music
  float intensity=20;
  
  //color of the particle, created at random
  color col;
  float c;

  Particle(float x, float y, float r_, float c_) {
    r = r_;
    
    // This function puts the particle in the Box2d world
    makeBody(x, y, r);
    body.setUserData(this);
    colorMode(HSB,100);
    c=c_;
    col = color(c,100,intensity);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }


  // Is the particle ready for deletion?
  boolean done() {
    // Find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // If the particles somehow escapes the well through "tunneling" kill it
    //starting to sound like a bunch of electrons in multiple energy states
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }


  // 
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(col);
    stroke(0);
    strokeWeight(1);
 
 //volume of the music determines if particles light up or not
    if(song.mix.level()>maxintensity){
     intensity=100;
    }
    col=color(c,100,intensity);
    ellipse(0, 0, r*2, r*2);
    
    //decays particles back to original intensity after being "excited"
     intensity *= 0.95;
    if ( intensity < 20 ) intensity = 20;
    popMatrix();
  }

  // Here's our function that adds the particle to the Box2D world
  void makeBody(float x, float y, float r) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.6;

    // Attach fixture to body
    body.createFixture(fd);

    body.setAngularVelocity(random(-10, 10));
  }
}

