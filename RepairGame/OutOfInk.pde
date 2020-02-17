class OutOfInk extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      ink =new MasterOutOfInk();
      Initialize=false;
    }
    ink.DoOutOfInk();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      if(DebugMode) controlP5.remove("Nextgame");
      Initialize=true;
      return new ToothDecay();
    }
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      Initialize=true;
      if(DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      return new ToothDecay();
    }
    return this;
  }
}

class MasterOutOfInk {
  int ImageX,ImageY;

  //コンストラクタ
  MasterOutOfInk() {
    ImageX=width/6;
    ImageY=height/2;
    if(DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);
  }

  public void DoOutOfInk() {
    imageMode(CENTER);
    image(Pen,ImageX,ImageY);
    if(mousePressed&&mouseX>ImageX-160&&mouseX<ImageX+160&&mouseY>ImageY-70&&mouseY<ImageY+70){
      ImageX=mouseX;
      ImageY=mouseY;
    }
    Wall();
  }
}
