import org.jbox2d.dynamics.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import shiffman.box2d.*;

import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

// Empty arrays for our mess of boxes (+ world boundaries)
ArrayList<Box> boxes;
ArrayList<Boundary> boundaries;
// Create a new Box2D world, called box2d
Box2DProcessing box2d;
// Surface class will be responsible for drawing our boundary edges
Surface surface;


// This will be our arduino angle reading
float angle = 0;
int currentPosition;
boolean clockwise;

void setup() {
  frameRate(30);
  size(500,500);
  
  // Serial setup
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  
  // Empty arrays for our mess of boxes (+ world boundaries)
  boxes = new ArrayList<Box>(); 
  boundaries = new ArrayList<Boundary>();
  
  // Create a new Box2D world, called box2d
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Surface class will be responsible for drawing our boundary edges
  surface = new Surface();
  
  // Populate the world with n boxes
  for(int i=1; i<200; i++) {
    Box p = new Box(250, 250);
    boxes.add(p);
    };
    

}

void draw() {
  background(255);
  
  // Get that serial reading
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
  }

  // Rotation in Box2D is complex, given the aim is to simulate
  // physics of the real world. I wanted a much simpler effect here,
  // rotation with very little in the way of velocity/friction.
  
  // Here I am going to define the centerpoint, as Box2D uses top-left
  // 0,0 – I will be drawing and referencing the cartesian center for 
  // all of my objects in this sketch.
  translate(width/2,height/2);
  
  
  // I will jump to a new matrix to handle rotation and physics
  // computation. This will come in handy if I ever come back and
  // draw  UI on top of this, as it will be drawn on the prior
  // matrix layer, so as not to rotate with the rest of this.
  pushMatrix();

  // That simple effect I was speaking of will be the rotation of a 
  // drum full of cubes. Rather than making that drum an actual box2d entity
  // with a 'revolute' joint, I am just going to rotate the whole damn
  // canvas...
  angle = val;
  rotate(radians(angle)*-1); 
  
    // This will draw the surface boundary edges (the drum container)
  surface.display();
  
  // This tells the box2d world to calculate the next movements for all
  // of the worlds objects...
  box2d.step();
  
  // ... then draw them
  for(Box b: boxes) {
    b.display();
  }
  // Back to the default matrix layer
  popMatrix();

  // Here I am calculating the rotation of the gravity point to correspond
  // to the rotation of the world/drum layer...
  
  // Box2d uses a cartesian point to plot the angle and traj of the worlds
  // gravity, relative to the origin (0,0).
  
  // I am placing that point directly below my center origin, and rotating it
  // in an elliptical route, in counter velocity to the rotation of the main
  // world. This angle of rotation is calculated from the serial to Arduino
  float x=200*cos(radians(angle+90));
  float y=200*sin(radians(angle+90));
  
  // // This is a small cursor shape to locate the gravity point
  // rect(x, y, 30, 30, 11);
  
  // And finally, set the gravity point.
  box2d.setGravity(x, y*-1);
  
}
