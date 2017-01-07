Ship ship;
ArrayList<Asteroid> asteroids;
ArrayList<Explotion> explotions;

int numAsteroids = 7;
boolean displayHitboxes = false;
int score;
int level;

ArrayList<Ship> lives;
float livesPadding = 10;
int lineSize = 4;

int iFrames = 60 * 2;

void setup() {
  fullScreen();
  ship = new Ship();
  ship.iFrames = iFrames;
  asteroids = new ArrayList<Asteroid>();
  explotions = new ArrayList<Explotion>();
  for (int i = 0; i < numAsteroids; i++) {
    asteroids.add(new Asteroid());
  }
  score = 0;
  level = 1;
  lives = new ArrayList<Ship>();
  for (int i = 0; i < 3; i++) {
    increesLives();
  }
}


void draw () {
  background(0);
  int index = 0;
  for (Asteroid a : asteroids) {
    a.update();
    a.render();
    if (ship.checkColition(a)) {
      respawn();
      asteroids.addAll(a.split());
      asteroids.remove(index);
      break;
    }
    index++;
  }
  if (asteroids.size() == 0)
    nextLevel();
  textSize(40);
  fill(255);
  textAlign(CENTER, TOP);
  text(score, width / 2, 0);
  if (lives.size() > 0) {
    ship.render();
    ship.update();
  }
  textSize(15);
  fill(0, 255, 0);
  textAlign(RIGHT, TOP);
  text(round(frameRate), width - 5, 0);
  for (int i = explotions.size() - 1; i >= 0; i--) {
    explotions.get(i).update();
    explotions.get(i).render();
    if (explotions.get(i).isDone()) {
      explotions.remove(i);
    }
  }

  for (Ship s : lives) {
    s.render();
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
  
  if (keyCode == SHIFT) {
    ship.hyperSpace();
  }
  
  if (key == 'r') {
    setup();
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

void increesLives() {
  if (lives.size() < 15) {
    int numRows = lives.size() / lineSize;
    Ship s = new Ship();
    s.heading = - PI / 2;
    int i = lives.size() % lineSize;
    PVector pos;
    if (lives.size() != 0) {
      pos = new PVector(livesPadding + s.r + i * (2 * s.r + livesPadding), (1.5 * s.r + livesPadding) + numRows * (2.5 * s.r + livesPadding));
    } else {
      pos = new PVector(livesPadding + s.r + i * (2 * s.r + livesPadding), 1.5 * s.r + livesPadding);
    }
    s.pos = pos;
    lives.add(s);
  }
}

void respawn() {
  if (lives.size() > 0) {
    Ship s = lives.remove(lives.size() - 1);
    s.pos = new PVector(width / 2, height / 2);
    s.heading = random(0, TWO_PI);
    explotions.add(new Explotion(ship.pos));
    s.iFrames = iFrames;
    ship = s;
  }
}

void nextLevel() {
  for (int i = 0; i < numAsteroids + level; i++) {
    asteroids.add(new Asteroid());
  }
  level++;
}