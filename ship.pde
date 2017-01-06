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
    heading = 0;
    r = 15;
    thrusting = false;
    turn = 0;
  }

  void update() {
    if (thrusting) {
      PVector accel = PVector.fromAngle(heading);
      accel.mult(1);
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
    rotate(heading);
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
    popMatrix();
  }
}