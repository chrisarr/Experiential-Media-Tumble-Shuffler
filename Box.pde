// Modified version of Dan shiffman's box class
class Box  {

  Body body;
  float w;
  float h;
  
  Box(int x_, int y_) {
//    w = random(4,16);
//    h = random(4,16);
    w = 10;
    h = 10;
    
    BodyDef bd = new BodyDef();  // Build body.
    
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(0,0));
    body = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape();  // Build shape.
    
    float box2dW = box2d.scalarPixelsToWorld(w/2);  // Box2d considers with from center
    float box2dH = box2d.scalarPixelsToWorld(h/2);   // out to edge, so half what we normally do.
    
    ps.setAsBox(box2dW, box2dH);    // Make this shape a box, with these sizes
    
    FixtureDef fd = new FixtureDef();  // Define the fixture
    fd.shape = ps;
    fd.density = 1;

    fd.friction = 0.3;    // Set physics parameters
    fd.restitution = 0.5;
    
    body.createFixture(fd);  // Attach the shape to body with the fixture
  }

void display() {
  Vec2 pos = box2d.getBodyPixelCoord(body);    // We need the Body’s location and angle.
  float a = body.getAngle();

  pushMatrix();
  translate(pos.x,pos.y);                       // Using the Vec2 position and float angle to
  rotate(-a);                                   // translate and rotate the rectangle

  fill(175);
  stroke(0);
  rectMode(CENTER);
  rect(0,0,w,h);
  popMatrix();
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
}
