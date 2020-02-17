class ToothDecay extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      toothdecay =new MasterToothDecay();
      Initialize=false;
    }
    toothdecay.DoToothDecay();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      return new JigsawPuzzle();
    }
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      return new JigsawPuzzle();
    }
    return this;
  }
}

class MasterToothDecay {

  //コンストラクタ
  MasterToothDecay() {
    if (DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);
  }

  public void DoToothDecay() {
    fill(0);
    strokeWeight(1);
    noFill();
    h.setSeed(1234);
    h.rect(30, 30, width/2-60, height-60);
    
    Wall();
  }
}
