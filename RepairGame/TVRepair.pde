
class TVRepair extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      tv_re =new MasterTVRepair();
      Initialize=false;
      ClearEff=false;
      EffectFlag=true;
      NowScreen=5;
    }
    tv_re.DoTVRepair();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      Initialize=true;
      ClearEff=false;
      if (DebugMode) controlP5.remove("Nextgame");
      return new WaterPipe();
    }
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      ClearEff=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      return new WaterPipe();
    }
    return this;
  }
}

class MasterTVRepair {

  //コンストラクタ
  MasterTVRepair() {
    HitCheck=0;
    if (DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);

    for (int i = 0; i < 100; i++) {
      PVector loc = new PVector(width/2, height/2);
      PVector vec = new PVector(random(-1, 1)*12, random(-1, 1)*12);
      spot[i] = new Spot(loc, vec, random(10, 30));
    }
  }

  public void DoTVRepair() {

    if (HitCheck == 0) {
      imageMode(CORNER);
      image(TV, 80, 300, 300, 200);
    } else if ( HitCheck == 1 ) {
      ClearEff=true;
      image(TVR, 82, 300, 298, 200);
    }


    if (mousePressed == true) {
      image(ude2, mouseX - 200, mouseY - 60, 200, 200);
    } else if (mouseX <= width/2) {
      image(ude1, mouseX - 200, mouseY - 100, 200, 200);
    }
    //命令文側
    image(Mission4, width/2+28, 30, 633, 738);
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
