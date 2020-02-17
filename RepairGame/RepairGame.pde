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

//デバッグ用のボタン配置に使う
import controlP5.*;
ControlP5 controlP5; 

//Handy用の宣言たち---------------------------------------------------//
import org.gicentre.handy.*; 
HandyRenderer h;      // This does the sketchy drawing.
ArrayList<PVector> joints;
int movingJoint; 
//--------------------------------------------------------------------//

//抽象クラス画面遷移用宣言
State state;

//各ゲームのクラス宣言
MasterMainMenu menu;
MasterMainResult result;
MasterInterception interception;
MasterJigsawPuzzle puzzle;
MasterOutOfInk ink;
MasterStickFigure figure;
MasterToothDecay toothdecay;

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

int StartTime;//そのゲームが開始した時間を記憶。タイマーに使う。
int mouseKey = 0;           //マウス
int KeyType=0;              //キーボード入力

PFont Font001, Font002;     //（フォントデータ）

PImage Machine, Pen, EnemyRight, EnemyLeft,CharacterLeft1,CharacterLeft2,CharacterRight1,CharacterRight2,CharacterFront,Burret;
PImage logo, Start, spanner,Success,Finish,Miss;
PImage Mission1,Mission2,Mission3,Mission4,Mission5,Mission6,Mission7;

void setup() {
  size(1366,768);

  state = new MainMenu();//最初にとぶのはメニュー画面
  h = new HandyRenderer(this);//Handy宣言
  controlP5 = new ControlP5(this);//デバッグ用宣言

  //初期化
  DoFigureMouse=false;//棒人間のゲームに入ったらtrueにして、出たら閉じる。
  Initialize=true;//画面遷移するごとに一度だけ通したいような処理のために使う。void setup()のように使える。
  DebugMode=false;
  GameMiss=false;
  ClearEff=false;
  EffectFlag=false;

  //各々のロード
  //フォント類
  Font001=createFont("游ゴシック Light", 24, true);
  Font002=createFont("AgencyFB-Bold-48", 24, true);
  //画像類
  Machine=loadImage("Machine.png");
  Pen=loadImage("Pen.png");
  EnemyRight=loadImage("fighter2.png");
  EnemyLeft=loadImage("fighter1.png");
  logo = loadImage("repair_logo.png");
  spanner = loadImage("spanner.png");
  Start = loadImage("Start.png");
  Mission1=loadImage("mission1.png");
  CharacterLeft1=loadImage("CharaLeft1.png");
  CharacterLeft2=loadImage("CharaLeft2.png");
  CharacterRight1=loadImage("CharaRight1.png");
  CharacterRight2=loadImage("CharaRight2.png");
  CharacterFront=loadImage("CharaFront1.png");
  Burret=loadImage("Burret.png");
  Success=loadImage("success.png");
  Finish=loadImage("Finish.png");
  Miss=loadImage("miss.png");
  
  //パーティクルの初期化
  for (int i = 0; i < 100; i++) {
    PVector loc = new PVector(width/2, height/2);
    PVector vec = new PVector(random(-1, 1)*12, random(-1, 1)*12);
    spot[i] = new Spot(loc, vec, random(10, 30));
  }
}

void draw() {
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
