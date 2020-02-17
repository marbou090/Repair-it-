class JigsawPuzzle extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      puzzle =new MasterJigsawPuzzle();
      Initialize=false;
    }
    puzzle.DoJigsawPuzzle();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      if(DebugMode) controlP5.remove("Nextgame");
      Initialize=true;
      return new ResultMenu();
    }
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      Initialize=true;
      if(DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      return new ResultMenu();
    }
    return this;
  }
}

class MasterJigsawPuzzle {

  //コンストラクタ
  MasterJigsawPuzzle() {
    if(DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);
  }

  public void DoJigsawPuzzle() {
    fill(0);
    textFont(Font001, 40);
    text("", width/2, height/2);
    
    Wall();
  }
}
