Ship ship;

void setup() {
  size(800, 600);
  ship = new Ship();
}


void draw () {
  background(0);
  ship.render();
  ship.update();
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