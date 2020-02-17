int Timer (int StartTime) {
  return millis()/1000-StartTime;
}

void keyPressed() {
  if (key == CODED) {      // コード化されているキーが押された
    if (keyCode == RIGHT) {    // キーコードを判定
      KeyType = 1;
    } else if (keyCode == LEFT) {
      KeyType=2;
    }
  }
  if (key==' ') {
    KeyType=3;
  }
}

boolean FrameCounter(int minute) {
  if (frameCount/minute%2==1) {
    return true;
  } else {
    return false;
  }
}

void mousePressed()
{

  /////////////
  //デバッグ用

  //GameMiss=true;
  ///////////////


  //クリック
  if (mouseButton == LEFT) mouseKey = 1;

  if (DoFigureMouse) {
    // Find nearest joint to mouse position.
    float minDist = MAX_FLOAT;
    for (int i=0; i<joints.size(); i++)
    {
      float currentDist = dist(mouseX, mouseY, joints.get(i).x, joints.get(i).y);
      if (currentDist < minDist)
      {
        minDist = currentDist;
        movingJoint = i;
      }
    }
  }
}

void mouseDragged(){
  if (DoFigureMouse) {
    if (movingJoint >=0){
      joints.get(movingJoint).x = mouseX;
      joints.get(movingJoint).y = mouseY;
    }
  }
}



//離す
void mouseReleased() {
  /////////////
  //デバッグ用
  GameMiss=false;
  ///////////////
  if (mouseButton == LEFT) mouseKey = 0;
}

//グラデーションを作るよ
void Backcolor(color c1, color c2, int rect1, int rect2) {
  noStroke();
  for (float w = 30; w < height-30; w += 5) {
    float r = map(w, 0, height, red(c1), red(c2));
    float g = map(w, 0, height, green(c1), green(c2));
    float b = map(w, 0, height, blue(c1), blue(c2));
    fill(r, g, b);
    rect(rect1, w, rect2, 5);
  }
}

void Wall() {
  /*
  fill(255);
   noStroke();
   rect(0, 0, 30, height);
   rect(0, 0, width, 30);
   rect(0, height-30, width, height);
   rect(width-30, 0, width, height);
   rect((width/2)-30, 0, 60, height);
   */

  noFill();
  stroke(0);
  strokeWeight(2);
  h.setSeed(1234);
  h.rect(30+width/2, 30, width/2-60, height-60);
  h.rect(30, 30, width/2-60, height-60);
}

void Viberation() {
  if (GameMiss) {
    noFill();
    stroke(0);
    strokeWeight(2);
    h.setSeed(int(random(0, 100)));
    h.rect(30+width/2, 30, width/2-60, height-60);
    h.rect(30, 30, width/2-60, height-60);
  }
}

void BackSpanner() {
  pushMatrix();
  translate(frameCount%256, -frameCount%256);
  for (int i=-50; i*48 < width*2; i++ ) {
    for (int j=-50; j*48 < height*2; j++) {
      tint(240, 100);
      image(spanner, 12+i*128, 24+j*128, 64, 64);
    }
  }
  popMatrix();
}
