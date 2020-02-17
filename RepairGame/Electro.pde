class Electro extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      electro =new MasterElectro();
      Initialize=false;
      ClearEff=false;
      EffectFlag=true;
      NowScreen=6;
    }
    electro.DoElectro();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      if (DebugMode) controlP5.remove("Nextgame");
      Initialize=true;
      return new TVRepair();
    }
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      return new TVRepair();
    }
    return this;
  }
}

class MasterElectro {

  //コンストラクタ
  MasterElectro() {
    if (DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);

    EffectFlag=true;
    if (DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);

    for (int i = 0; i < 100; i++) {
      PVector loc = new PVector(width/2, height/2);
      PVector vec = new PVector(random(-1, 1)*12, random(-1, 1)*12);
      spot[i] = new Spot(loc, vec, random(10, 30));
    }
  }

  public void DoElectro() {
    imageMode(CORNER);
    image(CableUp, width/2+50, 480, 180, 350);
    image(CableDown, width/2+50, -80, 180, 350);

    if ( G == 1 && R == 1 && B == 1 ) {
      image(Charging, width/2+300, 280, 300, 200);
      ELC.rewind();
      ELC.play();
      ELC.rewind();
      println(G, R, B);
    } else {
      image(DeadBattery, width/2+300, 280, 300, 200);
    }

    strokeWeight(10);

    L();
    Co();

    if (mousePressed == true && width/2 <= mouseX) {
      line(mouseX, mouseY, pmouseX, pmouseY);
    }

    fill(255);
    noStroke();
    rect(width/2, height-30, width/2, 40);
    rect(width/2, 0, width/2, 27);

    imageMode(CORNER);
    image(Mission5, 28, 30, 633, 738);
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

  void L() {
    if ( G == 1) {
      stroke(0, 180, 0);
      line(width/2+94, 490, width/2+188, 260);
    }

    if ( R == 1) {
      stroke(180, 0, 0);
      line(width/2+141.5, 490, width/2+141.5, 260);
    }

    if ( B == 1) {
      stroke(0);
      line(width/2+188, 490, width/2+94, 260);
    }
    if (B==1&&R==1&&G==1) {
      ClearEff=true;
    }
  }

  void Co() {

    switch( K ) {
    case 0:
      stroke(100);
      break;
    case 1:
      stroke(0, 180, 0);
      break;    
    case 2:
      stroke(180, 0, 0);
      break;
    case 3:
      stroke(0);
      break;
    }
  }
}
