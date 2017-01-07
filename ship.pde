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
    if (displayHitboxes) {
      for (PVector[] line : getLines()) {
        line(line[0].x, line[0].y, line[1].x, line[1].y);
      }
    }

    for (Laser l : lasers) {
      l.render();
    }
  }

  PVector[][] getLines() {
    PVector p1 = rotatePoint(new PVector(-r, r), heading + PI / 2);
    p1.add(pos);
    PVector p2 = rotatePoint(new PVector(0, -1.5*r), heading + PI / 2);
    p2.add(pos);
    PVector p3 = rotatePoint(new PVector(r, r), heading + PI / 2);
    p3.add(pos);
    PVector[][] lines = new PVector[3][2];
    PVector[] l1 = {p1, p2};
    PVector[] l2 = {p2, p3};
    PVector[] l3 = {p3, p1};
    lines[0] = l1;
    lines[1] = l2;
    lines[2] = l3;
    return lines;
  }

  boolean checkColition(Asteroid a) {
    if (dist(a.pos.x, a.pos.y, pos.x, pos.y) < a.r + 2*r) {
      for (PVector[] line : getLines()) {
        for (int i = 0; i < a.vertexes.length; i++) {
          float[] start = a.vertexes[i];
          float[] end = a.vertexes[(i != a.vertexes.length - 1) ? i + 1 : 0];
          PVector astLineStart = new PVector(start[0], start[1]);
          astLineStart.add(a.pos);
          PVector astLineEnd = new PVector(end[0], end[1]);
          astLineEnd.add(a.pos);
          if (linesTouching(line[0], line[1], astLineStart, astLineEnd)) {
            return true;
          }
        }
      }
      return false;
    } else {
      return false;
    }
  }

  boolean linesTouching(PVector fromL1, PVector toL1, PVector fromL2, PVector toL2) {
    float x1 = fromL1.x;
    float y1 = fromL1.y;

    float x2 = toL1.x;
    float y2 = toL1.y;

    float x3 = fromL2.x;
    float y3 = fromL2.y;

    float x4 = toL2.x;
    float y4 = toL2.y;

    float denominator = ((x2 - x1) * (y4 - y3)) - ((y2 - y1) * (x4 - x3));
    float numerator1 = ((y1 - y3) * (x4 - x3)) - ((x1 - x3) * (y4 - y3));
    float numerator2 = ((y1 - y3) * (x2 - x1)) - ((x1 - x3) * (y2 - y1));

    // Detect coincident lines (has a problem, read below)
    if (denominator == 0) return numerator1 == 0 && numerator2 == 0;

    float r = numerator1 / denominator;
    float s = numerator2 / denominator;

    return (r >= 0 && r <= 1) && (s >= 0 && s <= 1);
  }

  PVector rotatePoint(PVector point, float a) {
    float x = point.x;
    float y = point.y;
    return new PVector(x * cos(a) - y * sin(a), x * sin(a) + y * cos(a));
  }
}