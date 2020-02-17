class ResultMenu extends State {
  void drawState() {
    if (Initialize) {
      result =new MasterMainResult();
      Initialize=false;
      NowScreen=10;
    }
    result.DoResult();
  }

  State decideState() {
    if (NextGame) {
      mouseKey=0;
      NextGame=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      return new MainMenu();
    }
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      return new MainMenu();
    }
    return this;
  }
}

class MasterMainResult {

  //コンストラクタ
  MasterMainResult() {
    if (DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);
  }

  public void DoResult() {

    if (ScoreResult<=60) {
      image(ResultRank1, 0, 0);
    } else if (ScoreResult<=120&&ScoreResult>60) {
      image(ResultRank2, 0, 0);
    } else {
      image(ResultRank3, 0, 0);
    }
    if(mouseKey==1){
      NextGame=true;
    }
    //fill(0);
    //textSize(40);
    //text("100おくまんてん！", width/2, height/3);
  }
}
