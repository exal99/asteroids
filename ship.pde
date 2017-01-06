class Ship {
  PVector pos;
  PVector vel;
  float heading;
  float r;
  boolean thrusting;
  float turn;

  public Ship() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    heading = random(0, TWO_PI);
    r = 15;
    thrusting = false;
    turn = 0;
  }

  void update() {
    if (thrusting) {
      PVector accel = PVector.fromAngle(heading);
      accel.mult(0.1);
      vel.add(accel);
    }
    pos.add(vel);
    heading += turn;
  }

  void setTurn(float angle) {
    turn = angle;
  }

  void setThrusting(boolean thrust) {
    thrusting = thrust;
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
  }
}