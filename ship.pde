class Ship {
  PVector pos;
  PVector vel;
  float heading;
  float r;
  boolean thrusting;
  float turn;
  ArrayList<Laser> lasers;

  public Ship() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    heading = random(0, TWO_PI);
    r = 15;
    thrusting = false;
    turn = 0;
    lasers = new ArrayList<Laser>();
  }

  void update() {
    if (thrusting) {
      PVector accel = PVector.fromAngle(heading);
      accel.mult(0.1);
      vel.add(accel);
    }
    pos.add(vel);
    heading += turn;
    wrap();
    for (int i = lasers.size() - 1; i >= 0; i--) {
      lasers.get(i).update();
      if (lasers.get(i).isOffScreen()) {
        lasers.remove(i);
        continue;
      }
      for (int j = asteroids.size() - 1; j >= 0; j--) {
        if (lasers.get(i).colided(asteroids.get(j))) {
          Asteroid colided = asteroids.remove(j);
          asteroids.addAll(colided.split());
          lasers.remove(i);
          break;
        }
      }
    }
  }
  
  void wrap() {
    if (pos.x - r > width) {
      pos.x = 0;
    } else if (pos.x + r < 0) {
      pos.x = width;
    }
    
    if (pos.y - r > height) {
      pos.y = 0;
    } else if (pos.y + r < 0) {
      pos.y = height;
    }
  }

  void setTurn(float angle) {
    turn = angle;
  }

  void setThrusting(boolean thrust) {
    thrusting = thrust;
  }
  
  void fire() {
    lasers.add(new Laser(pos, heading));
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(heading + PI / 2);
    noFill();
    stroke(255);
    strokeWeight(3);
    beginShape();
    vertex(-r, r);
    vertex(0, -1.5*r);
    vertex(r, r);
    endShape();
    float offset = 0.2 * r;
    line(-(r-offset), r-offset, r-offset, r-offset);
    if (thrusting) {
      rect(-(r-offset), r-offset, -0.9*(2*offset - 2*r), 4*offset);
    }
    popMatrix();
    
    for (Laser l : lasers) {
      l.render();
    }
  }
}