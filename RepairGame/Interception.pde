class Interception extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      interception =new MasterInterception();
      Initialize=false;
    }
    interception.DoInterception();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      if (DebugMode) controlP5.remove("Nextgame");
      Initialize=true;
      EffectFlag=false;
      return new StickFigure();
    }
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      EffectFlag=false;
      return new StickFigure();
    }
    return this;
  }
}

class MasterInterception {
  int InterceptionGage;//迎撃機の修理メーター。MAXで９４になる。
  int EnemyPositionX;
  int EnemySetting;
  int EnemyVector;
  int CharacterPositionX;
  int BurretPositionY;
  int StartTimer;

  //コンストラクタ
  MasterInterception() {
    InterceptionGage=0;
    EnemyPositionX=width/2/2;
    EnemySetting=0;
    EnemyVector=0;
    CharacterPositionX=width/4;
    BurretPositionY=height/5;
    EffectFlag=true;
    if (DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);
  }

  public void DoInterception() {
    Backcolor(#40bfc1, #47e4bb, 30, width/2-60);//3c9d9b
    //----------------------メーターの増加判定-----------------------------------------------//
    /*
　    これをこの場所に置かないとKeyTypeが４で固定されて死にます。
     */
    if (mouseKey==1&&mouseX>1100&&mouseX<1270&&mouseY>580&&mouseY<680) {
      InterceptionGage=InterceptionGage+10;
      mouseKey=0;
    }
    //-------------------------------------------------------------------------------------//

    //城-----------------------------------------------------------------------------------//
    for (int i=0; i<5; i++) {
      noStroke();
      fill(#719192);
      rect(35/2+(width/2/5)*i+10, height/2, 80, (height-38)/2/4);
      fill(#5f6769);
      rect(40/2+(width/2/5)*i+12, height/2+5, 70, (height-38)/2/4-10);
    }
    fill(#719192);
    rect(30, height/2+80, width/2-60, height);
    for (int i=0; i<20; i++) {
      fill(#5f6769);
      rect(85*(i%10)-30*((int((i)/10)+1)%2), height/2+85*(int((i)/10)+1), 80, (height-38)/2/4-10);
    }


    //---------------------------------------------------------------------------------------//


    //-------------------------迎撃機-----------------------------------------------------------//
    tint(255);
    image(Machine, width/4+100, height/4*3-10);
    //迎撃メーター
    stroke(0);
    strokeWeight(1.5);
    fill(255);
    rect(width/4+100, height/4*3-40, 100, 20);
    fill(#6decb9);
    rect(width/4+103, height/4*3-37, InterceptionGage, 14);

    //--------------------------------------------------------------------------------------//

    //----------------------------機械工--------------------------------------------------------//

    if (mouseKey==1&&mouseX>800&&mouseX<890&&mouseY>580&&mouseY<670) {
      if (frameCount/20%2==1) {
        image(CharacterLeft1, CharacterPositionX, height/4*3-20);
      } else if (frameCount/20%2==0) {
        image(CharacterLeft2, CharacterPositionX, height/4*3-20);
      }
      CharacterPositionX=CharacterPositionX-3;
    } else if (mouseKey==1&&mouseX>920&&mouseX<1020&&mouseY>590&&mouseY<670) {
      if (frameCount/20%2==1) {
        image(CharacterRight1, CharacterPositionX, height/4*3-20);
      } else if (frameCount/20%2==0) {
        image(CharacterRight2, CharacterPositionX, height/4*3-20);
      }
      CharacterPositionX=CharacterPositionX+3;
    } else {
      image(CharacterFront, CharacterPositionX, height/4*3-20);
    }

    //--------------------------------------------------------------------------------------------//



    //----------------------------敵機----------------------------------------------------//
    if (EnemyVector==1) {
      image(EnemyRight, EnemyPositionX, height/5);
      EnemyPositionX=EnemyPositionX+5;
    } else if (EnemyVector==0) {
      image(EnemyLeft, EnemyPositionX, height/5);
      EnemyPositionX=EnemyPositionX-5;
    }
    if (EnemyPositionX>=width/2-140) {
      EnemyVector=0;
    } else if (EnemyPositionX<=60) {
      EnemyVector=1;
    }
    //-------------弾---------------//

    //------------------------------//
    //--------------------------------------------------------------------------------------//

    //端っこではみでないように白い箱を置いて隠す----------------------------------------------------------//
    noStroke();
    fill(255);
    rect(0, 0, 30, height);
    rect(0, height-30, width/2, 30);
    rect((width/2)-30, 0, 60, height);
    //---------------------------------------------------------------------------------------------//

    //命令文側
    image(Mission1, width/2+28, 30, 633, 738);
    //枠
    Wall();
    //ぽこぽこしてゲージ溜まったら次へ
    if (InterceptionGage>=94) {
      InterceptionGage=94;
      ClearEff=true;
    }

    if (ClearEff) {
      if (EffectFlag) {
        StartTimer=millis();
        EffectFlag=false;
      }
      for (int i = 0; i < 100; i++) {
        spot[i].move();
        spot[i].display();
        spot[i].fade();
      }
      Success.resize(500, 188);
      image(Success, width/2-250, height/2-94, 500, 188);
      if (millis()-StartTimer>3000) {
        NextGame=true;
      }
    }
  }
}
