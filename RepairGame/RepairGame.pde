//----------------------------------------//
/*
各ゲームのまわる順番
 迎撃機
 ↓
 棒人間
 ↓
 インクがでないペン
 */
//----------------------------------------//
Minim minim;


//デバッグ用のボタン配置に使う
import controlP5.*;
ControlP5 controlP5; 

//Handy用の宣言たち
import org.gicentre.handy.*; 
HandyRenderer h;      // This does the sketchy drawing.
ArrayList<PVector> JointDraft;
ArrayList<PVector> JointMove;
int movingJoint; 

//SE,BGM関連
//音設定
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
AudioSnippet EL;
AudioSnippet ELC;
AudioSnippet NSE;
AudioSnippet NSEC;
AudioSnippet SEC;
AudioSnippet TSE;
AudioSnippet SEP;
AudioPlayer MAIN;
AudioPlayer SUB;



//配線ゲーム用宣言
PImage CableUp, CableDown, DeadBattery, Charging;
int K = 0;
int R, G, B;

//鼻の骨折を治すゲーム用宣言
PImage NosePicture1, NosePicture2, Finger;


//プレゼント選びのゲーム用宣言
PImage ManDefault, ManLove, Present1, Present2, Present3;

//水道管を治すゲーム用の宣言
PImage Nat1, Nat2, WaterPicture, Pipe1, Pipe2, Rench1, Rench2, ScoreBar;

//テレビゲーム用の宣言
PImage TV, TvTurnOn, ArmBended, ArmExtend;

//抽象クラス画面遷移用宣言
State state;

//各ゲームのクラス宣言
MasterMainMenu menu;
MasterMainResult result;
MasterInterception interception;
MasterElectro electro;
MasterOutOfInk ink;
MasterStickFigure figure;
MasterTVRepair tv_re;
MasterPresentSelection present;
MasterWaterPipe water;

//パーティクル用クラス宣言
Spot[] spot = new Spot[100];

//各種宣言
boolean NextGame;//次のゲームに行くためのフラグ
boolean Initialize;//画面遷移のときに使う一度だけ通る処理のためのフラグ
boolean DoFigureMouse;//棒人間のところでマウスドラッグが必要なのでそのためのフラグ
boolean DebugMode;
boolean GameMiss;//ミスしたときに画面をきしませる
boolean ClearEff;
boolean EffectFlag;
boolean Music;
boolean DoMusic;

int StartTime;//そのゲームが開始した時間を記憶。タイマーに使う。
int mouseKey = 0;           //マウス
int KeyType=0;              //キーボード入力
int SuccessTimer;
float DistanceSum;
int NowScreen;
int HitCheck = 0;
int ScoreResult;

PFont Font001, Font002;     //（フォントデータ）

PImage Machine, Pen, EnemyRight, EnemyLeft, CharacterLeft1, CharacterLeft2, CharacterRight1, CharacterRight2, CharacterFront, Burret;
PImage logo, Start, spanner, Success, Finish, Miss, ResultRank1, ResultRank2, ResultRank3;
PImage Mission1, Mission2, Mission3, Mission4, Mission5, Mission6, Mission7, Mission8;

void setup() {
  smooth(32);
  frameRate(60);
  //size(1366,768);
  fullScreen();

  state = new MainMenu();//最初にとぶのはメニュー画面
  h = new HandyRenderer(this);//Handy宣言
  controlP5 = new ControlP5(this);//デバッグ用宣言

  //音関連
  minim =new Minim(this);
  EL= minim.loadSnippet("Sound/EL.mp3");
  ELC= minim.loadSnippet("Sound/ELC.mp3");  
  NSEC= minim.loadSnippet("Sound/Nose.mp3");
  NSE= minim.loadSnippet("Sound/SU.mp3"); 
  SEC= minim.loadSnippet("Sound/clear.mp3");
  SEP = minim.loadSnippet("Sound/pai.mp3");
  TSE = minim.loadSnippet("Sound/ta.mp3");
  MAIN=minim.loadFile("Sound/Repair_main_loop.mp3", 2048);
  SUB=minim.loadFile("Sound/Repair_main_loop_another.mp3", 2048);

  //初期化
  DoFigureMouse=false;//棒人間のゲームに入ったらtrueにして、出たら閉じる。
  Initialize=true;//画面遷移するごとに一度だけ通したいような処理のために使う。void setup()のように使える。
  DebugMode=false;
  GameMiss=false;
  ClearEff=false;
  EffectFlag=false;
  Music=false;
  DoMusic=false;

  //各々のロード
  //画像類
  Machine=loadImage("Picture/Machine.png");
  Pen=loadImage("Picture/Pen.png");
  EnemyRight=loadImage("Picture/fighter2.png");
  EnemyLeft=loadImage("Picture/fighter1.png");
  logo = loadImage("Picture/repair_logo.png");
  spanner = loadImage("Picture/spanner.png");
  Start = loadImage("Picture/Start.png");
  Mission1=loadImage("Picture/mission1.png");
  Mission2=loadImage("Picture/mission2.png");
  Mission3=loadImage("Picture/mission3.png");
  Mission4=loadImage("Picture/mission4.png");
  Mission5=loadImage("Picture/mission5.png");
  Mission6=loadImage("Picture/mission6.png");
  Mission7=loadImage("Picture/mission7.png");
  Mission8=loadImage("Picture/mission8.png");
  CharacterLeft1=loadImage("Picture/CharaLeft1.png");
  CharacterLeft2=loadImage("Picture/CharaLeft2.png");
  CharacterRight1=loadImage("Picture/CharaRight1.png");
  CharacterRight2=loadImage("Picture/CharaRight2.png");
  CharacterFront=loadImage("Picture/CharaFront1.png");
  Burret=loadImage("Picture/Burret.png");
  Success=loadImage("Picture/success.png");
  Finish=loadImage("Picture/Finish.png");
  Miss=loadImage("Picture/miss.png");
  CableUp = loadImage("Picture/CableUp.png");
  CableDown = loadImage("Picture/CableDown.png");
  DeadBattery = loadImage("Picture/DeadBattery.png");
  Charging = loadImage("Picture/Charging.png");
  NosePicture1 = loadImage("Picture/NoseAfter.png");
  NosePicture2 = loadImage("Picture/NoseBefore.png");
  Finger = loadImage("Picture/Finger.png");
  ManDefault = loadImage("Picture/ManDefault.png");
  ManLove = loadImage("Picture/ManLove.png");
  Present1 = loadImage("Picture/NormalPresent.png");
  Present2 = loadImage("Picture/GiriChocolate.png");
  Present3 = loadImage("Picture/LoveChocolate.png");
  Nat1 = loadImage("Picture/Screw1.png");
  Nat2 = loadImage("Picture/Screw2.png");
  WaterPicture =  loadImage("Picture/leakage.png");
  Pipe1 =  loadImage("Picture/Pipe1.png");
  Pipe2 =  loadImage("Picture/Pipe2.png");
  Rench1 =  loadImage("Picture/Rench1.png");
  Rench2 =  loadImage("Picture/Rench2.png");
  ScoreBar = loadImage("Picture/score.jpg");
  TV = loadImage("Picture/TV.png");
  TvTurnOn = loadImage("Picture/TvTurnOn.png");
  ArmBended = loadImage("Picture/ArmBended.png");
  ArmExtend = loadImage("Picture/ArmExtend.png");
  ResultRank1=loadImage("Picture/rankA.png");
  ResultRank2=loadImage("Picture/rankB.png");
  ResultRank3=loadImage("Picture/rankC.png");

  ScoreResult=0;
}

void draw() {
  DebugMode=true;
  background(255);
  state=state.doState();
  if (GameMiss) Viberation();
}

abstract class State {

  State() {
  }

  State doState() {
    drawState();
    return decideState();
  }

  abstract void drawState();    // 状態に応じた描画を行う
  abstract State decideState(); // 次の状態を返す
}

void keyPressed() {
  if ( key == 'k' ) {
    print(1);
    if (SUB.isPlaying()) {
      SUB.pause();
    }
    MAIN.loop();
    Music=true;
  }
  if (Music&&NowScreen==10&& key == 'l' ) {
    if (MAIN.isPlaying()) {
      MAIN.pause();
    }
    SUB.loop();
    Music=false;
  }
}
