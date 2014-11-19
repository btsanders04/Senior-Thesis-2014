class Ball {
  
  Body body;
  float r=5;
  
 Ball() {
 
//Build body.
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.bullet=true;
    bd.position.set(box2d.coordPixelsToWorld(mouseX,mouseY));
    body = box2d.createBody(bd);
 
//Build shape.
    CircleShape cs = new CircleShape();
//Box2D considers the width and height of a rectangle to be the distance from the center to the edge (so half of what we normally think of as width or height).
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
   // fd.density = 1;
//Set physics parameters.
    fd.friction = 0.1;
    fd.restitution = .6;
    fd.density=.8;
 
//Attach the Shape to the Body with the Fixture.
    body.createFixture(fd);
 }
  
  void display() {
//We need the Body’s location and angle.
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
 
    pushMatrix();
//Using the Vec2 position and float angle to translate and rotate the rectangle
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    ellipse(0,0,r*2,r*2);
    popMatrix();
  }
} 
