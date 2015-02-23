// Modified version of Dan shiffman's surface class
class Surface {
  
  ArrayList<Vec2> surface;

  Surface() {

    surface = new ArrayList<Vec2>();
    surface.add(new Vec2(-150, -151));       // 3 vertices in pixel coordinates
    surface.add(new Vec2(150, -151));
    surface.add(new Vec2(150, 151));
    surface.add(new Vec2(-150, 151));
    surface.add(new Vec2(-150, -151));

    ChainShape chain = new ChainShape();

    Vec2[] vertices = new Vec2[surface.size()];  // Make an array of Vec2 for the ChainShape.
    
                                                  
    for (int i = 0; i < vertices.length; i++) {       // Convert each vertex to Box2D World coordinates.
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));

    }

    chain.createChain(vertices, vertices.length);     // Create the ChainShape with array of Vec2.


    BodyDef bd = new BodyDef();                       // Attach the Shape to the Body.
    Body body = box2d.world.createBody(bd);
    body.createFixture(chain, 1);

  }
  
   void display() {
    strokeWeight(1);
    stroke(0);
    noFill();
    beginShape();               // Draw the ChainShape as a series of
    for (Vec2 v: surface) {     // vertices.
      vertex(v.x,v.y);
    }

    endShape();
  }
}
