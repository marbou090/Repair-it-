class StickFigure extends State {
  void drawState() {
    if (Initialize) {
      StartTime=millis()/1000;
      figure =new MasterStickFigure();
      Initialize=false;
      DoFigureMouse=true;
    }
    figure.DoStickFigure();
  }

  State decideState() {
    if (NextGame) {
      NextGame=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
      DoFigureMouse=false;
      return new OutOfInk();
    }

    //デバッグ用のボタンが押されたら
    if (DebugMode&&mouseKey==1&&mouseX>width/8&&mouseX<width/8+50&&mouseY>height/8&&mouseY<height/8+50) {
      mouseKey=0;
      NextGame=false;
      Initialize=true;
      if (DebugMode) controlP5.remove("Nextgame");
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

    //Handyの棒人間--------------------------------------------------------------------------------------------------------
    movingJoint = -1;
    /*
    joints = new ArrayList<PVector>();
     joints.add(new PVector(width/4*3+10, height/2-20));  // head
     joints.add(new PVector(width/4*3, height/2));        // Neck
     joints.add(new PVector(width/4*3, height/2+50));     // Pelvis
     joints.add(new PVector(width/4*3+2, height/2+90));   // Left knee
     joints.add(new PVector(width/4*3+20, height/2+90));  // Right knee
     joints.add(new PVector(width/4*3-20, height/2+130)); // Left ankle
     joints.add(new PVector(width/4*3+20, height/2+130)); // Right ankle
     joints.add(new PVector(width/4*3-10, height/2+130)); // Left toe
     joints.add(new PVector(width/4*3+30, height/2+130)); // Right toe
     joints.add(new PVector(width/4*3-20, height/2+35));  // Left elbow
     joints.add(new PVector(width/4*3+10, height/2+40));  // Right elbow
     joints.add(new PVector(width/4*3-15, height/2+70));  // Left wrist
     joints.add(new PVector(width/4*3+40, height/2+70));  // Right wrist
     joints.add(new PVector(width/4*3-12, height/2+70));  // Left finger  
     joints.add(new PVector(width/4*3+42, height/2+70));  // Right finger
     */
    joints = new ArrayList<PVector>();
    joints.add(new PVector(1033.0, 324));  // head
    joints.add(new PVector(1023.0, 234));        // Neck
    joints.add(new PVector(1023.0, 374.0));     // Pelvis
    joints.add(new PVector(1096.0, 462.0));   // Left knee
    joints.add(new PVector( 976.0, 528.0));  // Right knee
    joints.add(new PVector(width/4*3-20, height/2+130)); // Left ankle
    joints.add(new PVector(width/4*3+20, height/2+130)); // Right ankle
    joints.add(new PVector(width/4*3-10, height/2+130)); // Left toe
    joints.add(new PVector(width/4*3+30, height/2+130)); // Right toe
    joints.add(new PVector(width/4*3-20, height/2+35));  // Left elbow
    joints.add(new PVector(width/4*3+10, height/2+40));  // Right elbow
    joints.add(new PVector(width/4*3-15, height/2+70));  // Left wrist
    joints.add(new PVector(width/4*3+40, height/2+70));  // Right wrist
    joints.add(new PVector(width/4*3-12, height/2+70));  // Left finger  
    joints.add(new PVector(width/4*3+42, height/2+70));  // Right finger
    //-------------------------------------------------------------------------------------------------------------
  }

  public void DoStickFigure() {
    //Handyの棒人間------------------------------------------------------------------------------------------------------------------
    background(255);
    stroke(0);
    strokeWeight(4);
    noFill();
    h.setSeed(1234);      // Set this if you don't wish to see minor varations on each redraw.

    h.rect(30+width/2, 30, width/2-60, height-60);

    float tilt = atan2(joints.get(1).x-joints.get(0).x, joints.get(1).y-joints.get(0).y);
    pushMatrix();
    translate(joints.get(1).x, joints.get(1).y);
    rotate(-tilt);
    h.ellipse(0, 80, 50*2.5, 60*2.5);  // Head
    popMatrix();

    h.line(joints.get(1).x, joints.get(1).y, joints.get(2).x, joints.get(2).y);     // Body
    h.line(joints.get(2).x, joints.get(2).y, joints.get(3).x, joints.get(3).y);     // Left femur
    h.line(joints.get(2).x, joints.get(2).y, joints.get(4).x, joints.get(4).y);     // Right femur
    h.line(joints.get(3).x, joints.get(3).y, joints.get(5).x, joints.get(5).y);     // Left shin
    h.line(joints.get(4).x, joints.get(4).y, joints.get(6).x, joints.get(6).y);     // Right shin
    h.line(joints.get(5).x, joints.get(5).y, joints.get(7).x, joints.get(7).y);     // Left foot
    h.line(joints.get(6).x, joints.get(6).y, joints.get(8).x, joints.get(8).y);     // Right foot
    h.line(joints.get(1).x, joints.get(1).y, joints.get(9).x, joints.get(9).y);     // Left upper arm
    h.line(joints.get(1).x, joints.get(1).y, joints.get(10).x, joints.get(10).y);   // Right upper arm
    h.line(joints.get(9).x, joints.get(9).y, joints.get(11).x, joints.get(11).y);   // Left lower arm
    h.line(joints.get(10).x, joints.get(10).y, joints.get(12).x, joints.get(12).y); // Right lower arm
    h.line(joints.get(11).x, joints.get(11).y, joints.get(13).x, joints.get(13).y); // Left hand
    h.line(joints.get(12).x, joints.get(12).y, joints.get(14).x, joints.get(14).y); // Right hand
    //------------------------------------------------------------------------------------------------------------------
      print("\n");
      print(joints);
      print("\n");
    
    Wall();
  }
}
