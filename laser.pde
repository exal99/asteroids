class Laser {
  PVector pos;
  PVector vel;

  Laser(PVector pos, float heading) {
    this.pos = pos.copy();
    vel = PVector.fromAngle(heading);
    vel.mult(6);
  }

  void update() {
    pos.add(vel);
  }

  boolean isOffScreen() {
    return pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0;
  }

  void render() {
    strokeWeight(5);
    point(pos.x, pos.y);
  }

  boolean colided(Asteroid asteroid) {
    return dist(pos.x, pos.y, asteroid.pos.x, asteroid.pos.y) < asteroid.r;
  }
}