class MainMenu extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      NextGame=false;
      menu =new MasterMainMenu();
      Initialize=false;
      DebugMode=false;//
      mouseKey=0;
    }
    menu.DoMenu();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      Initialize=true;
      controlP5.remove("DebugMode");
      return new Interception();
    }
    return this;
  }
}


class MasterMainMenu {
  float logo_scale = 1.5;
  
  //コンストラクタ
  MasterMainMenu() {
    controlP5.addButton("DebugMode").setLabel("Debug").setPosition(width-70, height-70).setSize(50, 50);
  }

  public void DoMenu() {
    
    //背景のスパナー
    pushMatrix();
    translate(frameCount%256, -frameCount%256);
    for (int i=-50; i*48 < width*2; i++ ) {
      for (int j=-50; j*48 < height*2; j++) {
        tint(240, 256);
        image(spanner, 12+i*128, 24+j*128, 64, 64);
      }
    }
    popMatrix();
    //ロゴと、クリックの表示
    tint(240, 256);
    image(logo, width/2-240*logo_scale, height/3-90*logo_scale, 480*logo_scale, 180*logo_scale);
    tint(240, 64+sin(radians(frameCount%180*2)*4)*191);
    image(Start, width/2-420, height/3*2-60, 840, 120);

    //Debugのフラグを判定する
    if (mouseKey==1&&mouseX>width-70&&mouseX<width-20&&mouseY>height-70&&mouseY<height-20) {
      DebugMode=true;
    }
    //次のゲームに行く判定
    if (mouseKey==1) {
      NextGame=true;
    }
  }
}
