import java.util.Iterator;
import processing.serial.*;

ArrayList<Particle> plist = new ArrayList<Particle>();
Serial myPort;

void setup() {
  fullScreen(P2D);
  String portName = Serial.list()[1];
  println(portName);
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(10);
  text(frameRate, 10, 20);
  //if (mousePressed) {
  if (myPort.available()>0) {
    int ballCount = int(myPort.readString().trim());
    for (int i=0; i<ballCount/30; i++) {
      plist.add(new Particle(new PVector(width/2, height/2)));
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
