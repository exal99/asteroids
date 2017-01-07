import java.util.Comparator;
import java.util.Arrays;

class Asteroid {
  PVector vel;
  PVector pos;
  float[][] vertexes;
  float r;
  float childSize;

  Asteroid() {
    pos = new PVector(random(0, width), random(0, height));
    r = 80;
    init();
  }

  Asteroid(PVector pos, float size) {
    this.pos = pos.copy();
    r = size;
    init();
  }

  void init() {

    vertexes = new float[floor(random(5, 15))][];
    float maxDist = 0;
    float sum = 0;
    for (int i = 0; i < vertexes.length; i++) {
      float angle = TWO_PI/vertexes.length * i;
      float dist = random(r/2, 1.5*r);
      maxDist = (dist > maxDist) ? dist : maxDist;
      sum += dist;
       float[] cord = {dist * cos(angle), dist * sin(angle)};
      vertexes[i] = cord;
    }
    childSize = sum/(2*vertexes.length);
    r = maxDist;
    vel = PVector.random2D();
    vel.mult(log(800/r));
}

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    noFill();
    stroke(255);
    strokeWeight(1);
    beginShape();
    for (int i = 0; i < vertexes.length; i++) {
      vertex(vertexes[i][0], vertexes[i][1]);
    }
    endShape(CLOSE);
    if (displayHitboxes) {
      fill(255, 255, 255, 50);
      ellipse(0, 0, r*2, r*2);
    }
    popMatrix();
  }

  void update() {
    pos.add(vel);
    wrap();
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

  ArrayList<Asteroid> split() {
    int livesBefore = score / 10000;
    if (r >= 100) {
      //large
      score += 20;
    } else if (r >= 50) {
      //medium
      score += 50;
    } else {
      //small
      score += 100;
    }
    if ((int) (score / 10000) > livesBefore) {
      increesLives();
    }
    ArrayList<Asteroid> toReturn = new ArrayList<Asteroid>();
    if (childSize > 15) {
      toReturn.add(new Asteroid(pos, childSize));
      toReturn.add(new Asteroid(pos, childSize));
    }
    explotions.add(new Explotion(pos));
    return toReturn;
  }
}