Ship ship;
ArrayList<Asteroid> asteroids;

int numAsteroids = 10;
boolean displayHitboxes = false;

void setup() {
  //size(800, 600);
  fullScreen();
  ship = new Ship();
  asteroids = new ArrayList<Asteroid>();
  for (int i = 0; i < numAsteroids; i++) {
    asteroids.add(new Asteroid());
  }
}


void draw () {
  background(0);

  for (Asteroid a : asteroids) {
    a.update();
    a.render();
  }
  ship.render();
  ship.update();
  textSize(32);
  fill(255);
  text(frameRate, 0, 32);
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