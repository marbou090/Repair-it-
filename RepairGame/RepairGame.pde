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
  EL= minim.loadSnippet("EL.mp3");
  ELC= minim.loadSnippet("ELC.mp3");  
  NSEC= minim.loadSnippet("Nose.mp3");
  NSE= minim.loadSnippet("SU.mp3"); 
  SEC= minim.loadSnippet("clear.mp3");
  SEP = minim.loadSnippet("pai.mp3");
  TSE = minim.loadSnippet("ta.mp3");
  MAIN=minim.loadFile("Repair_main_loop.mp3", 2048);
  SUB=minim.loadFile("Repair_main_loop_another.mp3", 2048);

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
  Machine=loadImage("Machine.png");
  Pen=loadImage("Pen.png");
  EnemyRight=loadImage("fighter2.png");
  EnemyLeft=loadImage("fighter1.png");
  logo = loadImage("repair_logo.png");
  spanner = loadImage("spanner.png");
  Start = loadImage("Start.png");
  Mission1=loadImage("mission1.png");
  Mission2=loadImage("mission2.png");
  Mission3=loadImage("mission3.png");
  Mission4=loadImage("mission4.png");
  Mission5=loadImage("mission5.png");
  Mission6=loadImage("mission6.png");
  Mission7=loadImage("mission7.png");
  Mission8=loadImage("mission8.png");
  CharacterLeft1=loadImage("CharaLeft1.png");
  CharacterLeft2=loadImage("CharaLeft2.png");
  CharacterRight1=loadImage("CharaRight1.png");
  CharacterRight2=loadImage("CharaRight2.png");
  CharacterFront=loadImage("CharaFront1.png");
  Burret=loadImage("Burret.png");
  Success=loadImage("success.png");
  Finish=loadImage("Finish.png");
  Miss=loadImage("miss.png");
  CableUp = loadImage("CableUp.png");
  CableDown = loadImage("CableDown.png");
  DeadBattery = loadImage("DeadBattery.png");
  Charging = loadImage("Charging.png");
  NosePicture1 = loadImage("NoseAfter.png");
  NosePicture2 = loadImage("NoseBefore.png");
  Finger = loadImage("Finger.png");
  ManDefault = loadImage("ManDefault.png");
  ManLove = loadImage("ManLove.png");
  Present1 = loadImage("NormalPresent.png");
  Present2 = loadImage("GiriChocolate.png");
  Present3 = loadImage("LoveChocolate.png");
  Nat1 = loadImage("Screw1.png");
  Nat2 = loadImage("Screw2.png");
  WaterPicture =  loadImage("leakage.png");
  Pipe1 =  loadImage("Pipe1.png");
  Pipe2 =  loadImage("Pipe2.png");
  Rench1 =  loadImage("Rench1.png");
  Rench2 =  loadImage("Rench2.png");
  ScoreBar = loadImage("score.jpg");
  TV = loadImage("TV.png");
  TvTurnOn = loadImage("TvTurnOn.png");
  ArmBended = loadImage("ArmBended.png");
  ArmExtend = loadImage("ArmExtend.png");
  ResultRank1=loadImage("rankA.png");
  ResultRank2=loadImage("rankB.png");
  ResultRank3=loadImage("rankC.png");

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
