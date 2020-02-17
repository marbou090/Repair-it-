class PresentSelection extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      present =new MasterPresentSelection();
      Initialize=false;
      NowScreen=8;
      EffectFlag=true;
    }
    present.DoPresentSelection();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      Initialize=true;
      ClearEff=false;
      if (DebugMode) controlP5.remove("Nextgame");
      return new NoseRepair();
    }
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      ClearEff=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      return new NoseRepair();
    }
    return this;
  }
}


class MasterPresentSelection {


  //コンストラクタ
  MasterPresentSelection() {
    HitCheck = 0;
    if (DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);

    for (int i = 0; i < 100; i++) {
      PVector loc = new PVector(width/2, height/2);
      PVector vec = new PVector(random(-1, 1)*12, random(-1, 1)*12);
      spot[i] = new Spot(loc, vec, random(10, 30));
    }
  }

  public void DoPresentSelection() {
    if (HitCheck == 0) {
      image(ManDefault, 250, 100, 156, 288);
    } else if (HitCheck == 1) {
      ClearEff=true;
      image(ManLove, 200, 100, 280, 280);
    }

    image(Present2, 50, 450);
    image(Present3, 250, 450);
    image(Present1, 450, 450);

    //命令文側
    image(Mission7,28+width/2, 30, 633, 738);
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
