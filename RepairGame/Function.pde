int Timer (int StartTime) {
  return millis()/1000-StartTime;
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
  //TVゲーム用
  if (NowScreen==5) {

    TSE.rewind();
    TSE.play();
    TSE.rewind();

    if ( (535 <= mouseX && mouseX <= 555) && ( 185 <= mouseY && mouseY <= 205) ) {
      HitCheck = 1;
    } else if ( HitCheck == 0) {
      HitCheck = 0;
    }
  }

  //配線ゲーム用
  if (NowScreen==6&& 490 <= mouseY && mouseY <= 570 ) {
    if ( width/2+80 <= mouseX &&  mouseX <= width/2+105 ) {
      K = 1;
    } else if ( width/2+128 <= mouseX && mouseX <= width/2+155 ) { 
      K = 2;
    } else if ( width/2+175 <= mouseX && mouseX <= width/2+200 ) {
      K = 3;
    }
  } else if ( 180 <= mouseY && mouseY <= 260 ) {
    if ( width/2+80 <= mouseX && mouseX <= width/2+105 ) {
      K = 3;
    } else if ( width/2+128 <= mouseX && mouseX <= width/2+155 ) { 
      K = 2;
    } else if ( width/2+175 <= mouseX && mouseX <= width/2+200 ) {
      K = 1;
    }
  } else {
    K = 0;
  }

  //  鼻の骨折を治すゲーム用
  if (NowScreen==9&& ( 345 <= mouseY && mouseY <= 365) ) {
    HitCheck = 1;
    NSEC.rewind();
    NSEC.play();
    NSEC.rewind();
  } else if ( HitCheck == 0) {
    HitCheck = 0;
    NSE.rewind();
    NSE.play();
    NSE.rewind();
  }

  //  プレゼント選びゲーム用
  if (NowScreen==8&& (260 <= mouseX && mouseX <= 420) && (480 <= mouseY && mouseY <= 605) ) {
    HitCheck = 1;
    SEC.rewind();
    SEC.play();
    SEC.rewind();
  } else if (HitCheck == 0) {
    HitCheck = 0;
  }

  //水道管ゲーム用
  if (NowScreen==7) {
    SEP.rewind();
    SEP.play();
    SEP.rewind();

    if ( (width/2+405 <= mouseX && mouseX <= width/2+450) && ( 250 <= mouseY && mouseY <= 280) ) {
      HitCheck++;
    } else if ( HitCheck == 0) {
      HitCheck = 0;
    }
  }

  //クリック
  if (mouseButton == LEFT) mouseKey = 1;
}

void mouseDragged() {
  if (DoFigureMouse) {
    if (movingJoint >=0) {
      JointMove.get(movingJoint).x = mouseX;
      JointMove.get(movingJoint).y = mouseY;
    }
  }
}



//離す
void mouseReleased() {
  if (NowScreen==6) {
    if ( K == 1 ) {
      if ( ( (490 <= mouseY && mouseY <= 570) && (width/2+80 <= mouseX &&  mouseX <= width/2+105) ) || ( (180 <= mouseY && mouseY <= 260) ) && ( (width/2+175 <= mouseX && mouseX <= width/2+200) ) ) {
        G = 1;
        if ( (R == 1 && B == 0) || (R == 0 && B == 1) || (R == 0 && B == 0) ) {
          EL.rewind();
          EL.play();
          EL.rewind();
        }
      }
    }
    if ( K == 2 ) {
      if ( ( (490 <= mouseY && mouseY <= 570) && (width/2+128 <= mouseX && mouseX <= width/2+155) ) || ( (180 <= mouseY && mouseY <= 260) ) && ( (width/2+128 <= mouseX && mouseX <= width/2+155) ) ) {
        R = 1;
        if ( (G == 1 && B == 0) || (G == 0 && B == 1) || (G == 0 && B == 0)  ) {
          EL.rewind();
          EL.play();
          EL.rewind();
        }
      }
    }
    if ( K == 3 ) {
      if ( ( (490 <= mouseY && mouseY <= 570) && (width/2+175 <= mouseX && mouseX <= width/2+200) ) || ( (180 <= mouseY && mouseY <= 260) ) && ( (width/2+80 <= mouseX &&  mouseX <= width/2+105) ) ) {
        B = 1;
        if ( (R == 1 && G == 0) || (R == 0 && G == 1) || (R == 0 && G == 0)  ) {
          EL.rewind();
          EL.play();
          EL.rewind();
        }
      }
    }
  }
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
