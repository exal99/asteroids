class Saucer {
  PVector pos;
  PVector vel;
  float w, h;
  float minSpeed = 3;
  float maxSpeed = 7;
  
  Saucer() {
    int direction = floor(random(2));
    switch (direction) {
      case 0:
        pos = new PVector(0, random(0.1 * height, 0.9 * height));
        vel = new PVector(random(minSpeed,maxSpeed), 0);
        break;
      case 1:
        pos = new PVector(width, random(0.1 * height, 0.9 * height));
        vel = new PVector(-random(minSpeed,maxSpeed), 0);
        break;
      default:
        throw new RuntimeException();
    }
    w = 50;
    h = 20;
  }
  
  void update() {
    pos.add(vel);
    if (random(100) < 3) {
      println(degrees(vel.heading()) + " " + vel.heading() + " " + PI + " " + PI/2);
      if (pos.y < height/2 && vel.heading() == 0) {
        vel.rotate(PI/4);
      } else if (pos.y < height/2 && vel.heading() == PI) {
        vel.rotate(-PI/4);
      } else if (pos.y < height/2 && vel.heading() == PI/4) {
        vel.rotate(-PI/4);
      } else if (pos.y < height/2 && vel.heading() == PI - PI/4) {
        vel.rotate(PI/4);
      } else if (pos.y < height/2 && vel.heading() == -PI / 4) {
        vel.rotate(PI/4);
      } else if (pos.y < height/2 && vel.heading() == PI/4 + PI) {
        vel.rotate(-PI/4);
      }
      
      if (pos.y > height/2 && vel.heading() == 0) {
        vel.rotate(-PI/4);
      } else if (pos.y > height/2 && vel.heading() == PI) {
        vel.rotate(PI/4);
      } else if (pos.y > height/2 && vel.heading() == -PI/4) {
        vel.rotate(PI/4);
      } else if (pos.y > height/2 && vel.heading() == (PI + PI/4)) {
        vel.rotate(-PI/4);
      } else if (pos.y > height/2 && vel.heading() == PI/4) {
        vel.rotate(-PI/4);
      } else if (pos.y > height/2 && vel.heading() == PI - PI/4) {
        vel.rotate(PI/4);
      }
      println("CHANGE" + degrees(vel.heading()));
    }
  }
  
  void render() {
    strokeWeight(3);
    ellipse(pos.x, pos.y, w, h);
    line(pos.x - w/2, pos.y, pos.x + w/2, pos.y);
  }
}