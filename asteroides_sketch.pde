Ship ship;
Asteroid[] asteroids;

int numAsteroids = 10;

void setup() {
  //size(800, 600);
  fullScreen();
  ship = new Ship();
  asteroids = new Asteroid[numAsteroids];
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i] = new Asteroid();
  }
}


void draw () {
  background(0);
  ship.render();
  ship.update();
  for (Asteroid a : asteroids) {
    a.update();
    a.render();
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
}

void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) {
    ship.setTurn(0);
  }
  if (keyCode == UP) {
    ship.setThrusting(false);
  }
}