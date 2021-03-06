class OutOfInk extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      ink =new MasterOutOfInk();
      Initialize=false;
      ClearEff=false;
      EffectFlag=true;
      NowScreen=4;
    }
    ink.DoOutOfInk();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      if (DebugMode) controlP5.remove("Nextgame");
      Initialize=true;
      return new Electro();
    }
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      ClearEff=false;
      NextGame=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      return new Electro();
    }
    return this;
  }
}

class MasterOutOfInk {
  int ImageX, ImageY;
  float Distance;//マウスドラッグがどれくらい動いたか
  float DitanceSum;

  //コンストラクタ
  MasterOutOfInk() {
    ImageX=width/6;
    ImageY=height/2;
    Distance=0;
    DitanceSum=0;
    if (DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);

    for (int i = 0; i < 100; i++) {
      PVector loc = new PVector(width/2, height/2);
      PVector vec = new PVector(random(-1, 1)*12, random(-1, 1)*12);
      spot[i] = new Spot(loc, vec, random(10, 30));
    }
  }

  public void DoOutOfInk() {


    imageMode(CENTER);
    image(Pen, ImageX, ImageY);
    if (mousePressed&&mouseX>ImageX-160&&mouseX<ImageX+160&&mouseY>ImageY-70&&mouseY<ImageY+70) {
      ImageX=mouseX;
      ImageY=mouseY;
    }

    if (mousePressed==true&&abs(pmouseY-mouseY)>1) {
      Distance=Distance-(pmouseY-mouseY);
      println(Distance);
    }

    if (frameCount/1000%20==0) {
      DitanceSum=DitanceSum+abs(Distance);
      if (DitanceSum>10000) {
        ClearEff=true;
      }
    } else {
      DistanceSum=0;
    }

    //命令文側
    imageMode(CORNER);
    image(Mission3, width/2+28, 30, 633, 738);
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
      imageMode(CORNER);
      image(Success, width/2-250, height/2-94, 500, 188);
      if (millis()-SuccessTimer>2000) {
        NextGame=true;
      }
    }
  }
}
