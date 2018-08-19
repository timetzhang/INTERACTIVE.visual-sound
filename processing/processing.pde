class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan;
  color[] colors = new color[]{
    #f3b31e, 
    #80ccda, 
    #e84244, 
    #752f88, 
    #971f2b
  };
  color c;
  Particle(PVector l) {
    loc = l.get();
    acc = new PVector(0, 0.2);
    vel = new PVector(random(-4, 4), random(-6, 0));
    lifespan = 255;
    c = colors[int(random(colors.length))];
  }

  void update() {
    vel.add(acc);
    loc.add(vel);
    lifespan-=1;
  }

  void display() {
    stroke(c, lifespan);
    fill(c, lifespan);
    ellipseMode(RADIUS);
    ellipse(loc.x, loc.y, 6, 6);
  }

  void checkEdge() {
    if (loc.y > height) {
      loc.y = height;
      vel.y = -vel.y;
    }
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }

  void run() {
    update();
    checkEdge();
    display();
  }
}

import java.util.Iterator;
import processing.serial.*;

ArrayList<Particle> plist = new ArrayList<Particle>();
Serial myPort;

void setup() {
  size(800, 600);
  String portName = Serial.list()[1];
  println(portName);
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(30);

  if (myPort.available()>0) {
    PVector startPos = new PVector(width/2, height/2);
    int v = myPort.read();
    println(v);
    ellipseMode(RADIUS);
    fill(255, 30);
    for (int i=0; i<v/2; i++) {
      plist.add(new Particle(startPos));
    }
  }

  Iterator<Particle> it = plist.iterator();

  while (it.hasNext()) {
    Particle p = it.next();
    p.run();
    if (p.isDead()) {
      it.remove();
    }
  }
}
