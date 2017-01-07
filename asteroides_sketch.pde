Ship ship;
ArrayList<Asteroid> asteroids;
ArrayList<Explotion> explotions;

int numAsteroids = 10;
boolean displayHitboxes = false;
int hits = 0;
int score;

void setup() {
  fullScreen();
  ship = new Ship();
  asteroids = new ArrayList<Asteroid>();
  explotions = new ArrayList<Explotion>();
  for (int i = 0; i < numAsteroids; i++) {
    asteroids.add(new Asteroid());
  }
}


void draw () {
  background(0);
  for (Asteroid a : asteroids) {
    a.update();
    a.render();
    if (ship.checkColition(a)) {
      hits++;
    }
  }
  textSize(32);
  fill(255);
  text("HIT " + hits, 0, 64);
  ship.render();
  ship.update();
  textSize(32);
  fill(255);
  text(frameRate, 0, 32);
  for (int i = explotions.size() - 1; i >= 0; i--) {
    explotions.get(i).update();
    explotions.get(i).render();
    if (explotions.get(i).isDone()) {
      explotions.remove(i);
    }
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    ship.setTurn(-0.1);
  } else if (keyCode == RIGHT) {
    ship.setTurn(0.1);
  }
  if (keyCode == UP) {
    ship.setThrusting(true);
  }

  if (key == ' ') {
    ship.fire();
  }
}

void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) {
    ship.setTurn(0);
  }
  if (keyCode == UP) {
    ship.setThrusting(false);
  }
}