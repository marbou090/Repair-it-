class StickFigure extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      figure =new MasterStickFigure();
      Initialize=false;
      DoFigureMouse=true;
      ClearEff=false;
      EffectFlag=true;
      DistanceSum=100;
      NowScreen=3;
    }
    figure.DoStickFigure();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      controlP5.remove("ForceNext");
      DoFigureMouse=false;
      return new OutOfInk();
    }

    //デバッグ用のボタンが押されたら
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      controlP5.remove("ForceNext");
      DoFigureMouse=false;
      return new OutOfInk();
    }
    return this;
  }
}

class MasterStickFigure {



  //コンストラクタ
  MasterStickFigure() {
    //デバッグ用に追加してみる。強制的に次に飛ばすボタン。
    if (DebugMode) controlP5.addButton("Nextgame").setLabel(">").setPosition(width/8, height/8).setSize(50, 50);
    controlP5.addButton("ForceNext").setLabel("!").setPosition(width/4*3-width/12, height/4*3+30).setSize(width/6, 60);
    //Handyの棒人間--------------------------------------------------------------------------------------------------------
    movingJoint = -1;

    JointDraft = new ArrayList<PVector>();
    JointDraft.add(new PVector(1033.0, 324));  // head
    JointDraft.add(new PVector(1023.0, 234));        // Neck
    JointDraft.add(new PVector(1023.0, 374.0));     // Pelvis
    JointDraft.add(new PVector(1096.0, 462.0));   // Left knee
    JointDraft.add(new PVector( 976.0, 528.0));  // Right knee
    JointDraft.add(new PVector(1088, 568)); // Left ankle
    JointDraft.add(new PVector(834.0, 515.0)); // Right ankle
    JointDraft.add(new PVector(1115, 563.0)); // Left toe
    JointDraft.add(new PVector(823.0, 544.0)); // Right toe
    JointDraft.add(new PVector(894.0, 342.0));  // Left elbow
    JointDraft.add(new PVector(1128.0, 366.0));  // Right elbow
    JointDraft.add(new PVector(914.0, 390.0));  // Left wrist
    JointDraft.add(new PVector(1162.0, 329.0));  // Right wrist
    JointDraft.add(new PVector(945.0, 397.0));  // Left finger  
    JointDraft.add(new PVector(1160.0, 317.0));  // Right finger


    JointMove = new ArrayList<PVector>();
    JointMove.add(new PVector(1033.0, 324));  // head
    JointMove.add(new PVector(1023.0, 234));        // Neck
    JointMove.add(new PVector(1023.0, 374.0));     // Pelvis
    JointMove.add(new PVector(1029.0, 548.0));   // Left knee
    JointMove.add(new PVector( 963.0, 556.0));  // Right knee
    JointMove.add(new PVector(1088, 568)); // Left ankle
    JointMove.add(new PVector(834.0, 515.0)); // Right ankle
    JointMove.add(new PVector(1115, 563.0)); // Left toe
    JointMove.add(new PVector(823.0, 544.0)); // Right toe
    JointMove.add(new PVector(879.0, 355.0));  // Left elbow
    JointMove.add(new PVector(1096.0, 371.0));  // Right elbow
    JointMove.add(new PVector(914.0, 390.0));  // Left wrist
    JointMove.add(new PVector(1162.0, 329.0));  // Right wrist
    JointMove.add(new PVector(894.0, 392.0));  // Left finger  
    JointMove.add(new PVector(1160.0, 317.0));  // Right finger
    //-------------------------------------------------------------------------------------------------------------

    for (int i = 0; i < 100; i++) {
      PVector loc = new PVector(width/2, height/2);
      PVector vec = new PVector(random(-1, 1)*12, random(-1, 1)*12);
      spot[i] = new Spot(loc, vec, random(10, 30));
    }
  }

  public void DoStickFigure() {
    //Handyの棒人間------------------------------------------------------------------------------------------------------------------
    background(255);
    h.setSeed(1234);      // Set this if you don't wish to see minor varations on each redraw.

    h.rect(30+width/2, 30, width/2-60, height-60);

    float tilt = atan2(JointDraft.get(1).x-JointDraft.get(0).x, JointDraft.get(1).y-JointDraft.get(0).y);
    pushMatrix();
    translate(JointDraft.get(1).x, JointDraft.get(1).y);
    rotate(-tilt);
    h.ellipse(0, 80, 50*2.5, 60*2.5);  // Head
    popMatrix();

    stroke(0);
    strokeWeight(4);
    noFill();
    h.line(JointMove.get(1).x, JointMove.get(1).y, JointMove.get(2).x, JointMove.get(2).y);     // Body
    h.line(JointMove.get(2).x, JointMove.get(2).y, JointMove.get(3).x, JointMove.get(3).y);     // Left femur
    h.line(JointMove.get(2).x, JointMove.get(2).y, JointMove.get(4).x, JointMove.get(4).y);     // Right femur
    h.line(JointMove.get(3).x, JointMove.get(3).y, JointMove.get(5).x, JointMove.get(5).y);     // Left shin
    h.line(JointMove.get(4).x, JointMove.get(4).y, JointMove.get(6).x, JointMove.get(6).y);     // Right shin
    h.line(JointMove.get(5).x, JointMove.get(5).y, JointMove.get(7).x, JointMove.get(7).y);     // Left foot
    h.line(JointMove.get(6).x, JointMove.get(6).y, JointMove.get(8).x, JointMove.get(8).y);     // Right foot
    h.line(JointMove.get(1).x, JointMove.get(1).y, JointMove.get(9).x, JointMove.get(9).y);     // Left upper arm
    h.line(JointMove.get(1).x, JointMove.get(1).y, JointMove.get(10).x, JointMove.get(10).y);   // Right upper arm
    h.line(JointMove.get(9).x, JointMove.get(9).y, JointMove.get(11).x, JointMove.get(11).y);   // Left lower arm
    h.line(JointMove.get(10).x, JointMove.get(10).y, JointMove.get(12).x, JointMove.get(12).y); // Right lower arm
    h.line(JointMove.get(11).x, JointMove.get(11).y, JointMove.get(13).x, JointMove.get(13).y); // Left hand
    h.line(JointMove.get(12).x, JointMove.get(12).y, JointMove.get(14).x, JointMove.get(14).y); // Right hand

    stroke(0, 20);
    strokeWeight(4);
    noFill();
    h.line(JointDraft.get(1).x, JointDraft.get(1).y, JointDraft.get(2).x, JointDraft.get(2).y);     // Body
    h.line(JointDraft.get(2).x, JointDraft.get(2).y, JointDraft.get(3).x, JointDraft.get(3).y);     // Left femur
    h.line(JointDraft.get(2).x, JointDraft.get(2).y, JointDraft.get(4).x, JointDraft.get(4).y);     // Right femur
    h.line(JointDraft.get(3).x, JointDraft.get(3).y, JointDraft.get(5).x, JointDraft.get(5).y);     // Left shin
    h.line(JointDraft.get(4).x, JointDraft.get(4).y, JointDraft.get(6).x, JointDraft.get(6).y);     // Right shin
    h.line(JointDraft.get(5).x, JointDraft.get(5).y, JointDraft.get(7).x, JointDraft.get(7).y);     // Left foot
    h.line(JointDraft.get(6).x, JointDraft.get(6).y, JointDraft.get(8).x, JointDraft.get(8).y);     // Right foot
    h.line(JointDraft.get(1).x, JointDraft.get(1).y, JointDraft.get(9).x, JointDraft.get(9).y);     // Left upper arm
    h.line(JointDraft.get(1).x, JointDraft.get(1).y, JointDraft.get(10).x, JointDraft.get(10).y);   // Right upper arm
    h.line(JointDraft.get(9).x, JointDraft.get(9).y, JointDraft.get(11).x, JointDraft.get(11).y);   // Left lower arm
    h.line(JointDraft.get(10).x, JointDraft.get(10).y, JointDraft.get(12).x, JointDraft.get(12).y); // Right lower arm
    h.line(JointDraft.get(11).x, JointDraft.get(11).y, JointDraft.get(13).x, JointDraft.get(13).y); // Left hand
    h.line(JointDraft.get(12).x, JointDraft.get(12).y, JointDraft.get(14).x, JointDraft.get(14).y); // Right hand

    if (mousePressed) {
      // Find nearest joint to mouse position.
      float minDist = MAX_FLOAT;
      for (int i=0; i<JointDraft.size(); i++)
      {
        float currentDist = dist(mouseX, mouseY, JointDraft.get(i).x, JointDraft.get(i).y);
        if (currentDist < minDist)
        {
          minDist = currentDist;
          movingJoint = i;
        }
      }
    }


    for (int i=0; i<14; i++) {
      if (i==0) {
        DistanceSum=0;
      }
      float Distance=sqrt(sq(abs(JointDraft.get(1).x-JointMove.get(2).x))+sq(abs(JointDraft.get(1).y-JointMove.get(2).y)));
      DistanceSum=DistanceSum+Distance;
    }

    //(width/4*3-width/12, height/4*3+30).setSize(width/6, 60)
    if (mouseKey==1&&mouseX>width/4*3-width/12&&mouseX<width/4*3-width/12+width/6&&mouseY>height/4*3+30&&mouseY<height/4*3+90) {
      ClearEff=true;
    }

    //命令文側
    image(Mission2, 28, 30, 633, 738);
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

    stroke(0);
    strokeWeight(4);
    noFill();
    //------------------------------------------------------------------------------------------------------------------
  }
}
