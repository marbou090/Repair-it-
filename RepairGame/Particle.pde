class Spot {
  // プロパティ
  PVector location; //位置 (ベクトル!)
  PVector velocity;   //速度 (ベクトル!)
  float diameter;   //直径
  float Color = 120 - random(0, 5)*20;
  Spot(PVector _location, PVector _velocity, float _diameter) {
    location = _location;
    diameter = _diameter;
    velocity = _velocity;
  }
  void move() {
    //位置ベクトル + 速度ベクトル = 次フレーム位置ベクトル
    location.add(velocity);
  }
  // 描画
  void display() {
    colorMode(HSB);
    stroke(Color, 100, 256, 200);
    strokeWeight(3);
    fill(Color, 256, 256);
    if (diameter>0) {
      ellipse(location.x, location.y, diameter, diameter);
    }
    if (diameter<0) {
     //NextGame=true;
    }
    colorMode(RGB);
  }
  void fade() {
    diameter -= 0.9;
  }

  void Doparticle() {
    for (int i = 0; i < 100; i++) {
      spot[i].move();
      spot[i].display();
      spot[i].fade();
    }
  }
}
