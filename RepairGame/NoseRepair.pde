class NoseRepair extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      nose =new MasterNoseRepair();
      Initialize=false;
      EffectFlag=true;
      NowScreen=9;
    }
    nose.DoNoseRepair();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      Initialize=true;
      ClearEff=false;
      if (DebugMode) controlP5.remove("Nextgame");
      return new ResultMenu();
    }
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      ClearEff=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      return new ResultMenu();
    }
    return this;
  }
}

MasterNoseRepair nose;
class MasterNoseRepair {

  //コンストラクタ
  MasterNoseRepair() {
    HitCheck = 0;
    if (DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);

    for (int i = 0; i < 100; i++) {
      PVector loc = new PVector(width/2, height/2);
      PVector vec = new PVector(random(-1, 1)*12, random(-1, 1)*12);
      spot[i] = new Spot(loc, vec, random(10, 30));
    }
  }

  public void DoNoseRepair() {
    if (mousePressed == true) {
      image(Finger, width/2+150, mouseY - 65, 300, 200);
    } else {
      image(Finger, width/2+50, mouseY - 65, 300, 200);
    }

    if (HitCheck == 0) {
      image(NosePicture2, width/2+320, height/2 - 150, 300, 300);
    } else {
      ClearEff=true;
      image(NosePicture1, width/2+320, height/2 - 150, 300, 300);
    }

    imageMode(CORNER);
    image(Mission8, +28, 30, 633, 738);
    Wall();

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
}
