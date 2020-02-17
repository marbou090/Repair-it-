
class WaterPipe extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      water =new MasterWaterPipe();
      Initialize=false;
      ClearEff=false;
      EffectFlag=true;
      NowScreen=7;
    }
    water.DoWaterPipe();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      Initialize=true;
      ClearEff=false;
      if (DebugMode) controlP5.remove("Nextgame");
      return new PresentSelection();
    }
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      ClearEff=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      return new PresentSelection();
    }
    return this;
  }
}

class MasterWaterPipe {

  //コンストラクタ
  MasterWaterPipe() {
    HitCheck=0;
    if (DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);

    for (int i = 0; i < 100; i++) {
      PVector loc = new PVector(width/2, height/2);
      PVector vec = new PVector(random(-1, 1)*12, random(-1, 1)*12);
      spot[i] = new Spot(loc, vec, random(10, 30));
    }
  }

  public void DoWaterPipe() {
    image(ScoreBar, width/2+10, 10, 0+HitCheck*10, 50);

    image(Pipe2, width/2+280, 350, 300, 120);
    image(WaterPicture, width/2+270, 120, 200, 200);

    if ( width/2+180 <= mouseX) {
      if (mousePressed == true) {
        image(Rench2, mouseX-180, mouseY+100, 350, 350);
      } else {
        image(Rench1, mouseX-180, mouseY-180, 350, 350);
      }
    } else {
      if (mousePressed == true) {
        image(Rench2, width/2, mouseY+100, 350, 350);
      } else {
        image(Rench1, width/2, mouseY-180, 350, 350);
      }
    }

    R();
    image(Pipe1, width/2+30, 350, 300, 120);

    imageMode(CORNER);
    image(Mission6, 28, 30, 633, 738);
    Wall();

    if (HitCheck>50) {
      ClearEff=true;
    }

    if (ClearEff) {
      if (EffectFlag) {
        SuccessTimer=millis();
        EffectFlag=false;
      }
      for (int i = 0; i < 100; i++) {
        spot[i].move();
        spot[i].display();
        spot[i].fade();
      }
      Success.resize(500, 188);
      image(Success, width/2-250, height/2-94, 500, 188);
      if (millis()-SuccessTimer>2000) {
        NextGame=true;
      }
    }
  }

  void R() {

    if (HitCheck % 2 == 0) {
      image(Nat1, width/2+215, 330, 150, 150);
    } else {
      image(Nat2, width/2+215, 330, 150, 150);
    }
  }
}
