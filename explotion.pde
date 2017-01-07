class Explotion {
  Particle[] particles;
  float timer;

  Explotion(PVector pos) {
    particles = new Particle[floor(random(20, 50))];
    timer = 255;
    for (int i = 0; i < particles.length; i++) {
      PVector vel = PVector.random2D();
      vel.mult(random(5, 25));
      particles[i] = new Particle(vel, pos.copy());
    }
  }

  void update() {
    for (Particle p : particles) {
      p.update();
    }
    timer -= 10;
  }

  void render() {
    for (Particle p : particles) {
      p.render(timer);
    }
  }

  boolean isDone() {
    return timer <= 0;
  }


  class Particle {
    PVector vel;
    PVector pos;

    Particle(PVector vel, PVector pos) {
      this.vel = vel;
      this.pos = pos;
    }

    void update() {
      pos.add(vel);
      vel.mult(0.9);
    }
    void render(float alpha) {
      strokeWeight(3);
      stroke(255, 255, 255, alpha);
      point(pos.x, pos.y);
    }
  }
}