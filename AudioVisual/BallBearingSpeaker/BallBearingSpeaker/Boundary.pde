class Boundary {
 
//A boundary is a simple rectangle with x, y, width, and height.
  float x,y;
  float w,h;
  Vec2 velocity;
  Body b;
 float box2dW;
 float box2dH;
  Boundary(float x_,float y_, float w_, float h_,Vec2 v_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    velocity=v_;
 
//Build the Box2D Body and Shape.
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x,y));
//Make it fixed by setting type to STATIC!
    bd.type = BodyType.STATIC;
    bd.setLinearVelocity(velocity);
    bd.bullet=true;
    b = box2d.createBody(bd);
  //  println(velocity);
 //   b.setLinearVelocity(velocity);
    box2dW = box2d.scalarPixelsToWorld(w/2);
    box2dH = box2d.scalarPixelsToWorld(h/2);
    PolygonShape ps = new PolygonShape();
//The PolygonShape is just a box.
    ps.setAsBox(box2dW, box2dH);
 
//Using the createFixture() shortcut
    b.createFixture(ps,1);
  }
 
 void killBody() {
    box2d.destroyBody(b);
    b = null;
  }
//Since we know it can never move, we can just draw it the old-fashioned way, using our original variables. No need to query Box2D.
  void display() {
     // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(b);
    // Get its angle of rotation
    float a = b.getAngle();

    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    noFill();
    noStroke();
  //  fill(175);
//stroke(0);
    rect(0, 0, w, h);
    popMatrix();
  }
  
//  void applyForce(Vec2 v){
//    b.applyLinearImpulse(v,b.getWorldCenter(),true);
//  }
 
}
