//---input for load & play music---
import ddf.minim.*;
Minim minim;
AudioPlayer player;

//---load image---
PImage img;

//---日本語表示---
String testText;
PFont font;
boolean textDraw = true;

//---for output the data---
PrintWriter output;

String ID = "guest";
char letter;

//---Cursor position---
int x; //mouseX
int y; //mouseY
int nScene = 0 ; // Scene#
int MusicNum = 0; //playlist number
int rank = 0;

//---Flags---
boolean createCSV = true;
boolean Btn1_over = false; // Button#1 Mouse Over Check Flag
boolean BtnPlay_over = false; //play music again
boolean BtnPlay_click = false; //play music again
boolean Color_choose = false; //choosing colors
boolean Choose_1 = false;
boolean Choose_2 = false;
boolean inTask = false;
boolean Choosing = false;

// ---Size settings---
int Btn1_w = 200; // Button #1
int Btn1_h = 75 ; // Button #1

//--------
// Setup
//--------

void setup() {
  frameRate(500);
  
  println("------------------");
  println("Experiment Start");
  println("------------------");
  
  size(displayWidth, displayHeight);//full screen
  
  //---日本語表示設定---
  font = loadFont("Osaka-24.vlw");
  textFont(font);
  
  //---window size adjustable---
  if(frame !=null) {
    surface.setResizable(true);
  }
  
  //---create the input stream---
  minim = new Minim(this);
  player = minim.loadFile("music-" + MusicNum +".mp3");
  println("Audio length is approximately" + player.length()/1000 + "s.");
  
  }
  
  //------
// Draw
//------

void draw() {
  background(0);
  
  //-------------------------------
  // Scene#0: Starting Experiment
  //-------------------------------
  if (nScene == 0) {
   cursor(HAND);
   //---Instructions---
   fill(0, 255, 0);
   textSize(40);
   textAlign(CENTER, CENTER);
   text("MME班実験プログラムへようこそ！", displayWidth/2, displayHeight/5); 
   fill(255);
   textSize(20);
   text("↑IDを入力してください↑", displayWidth/2, displayHeight*2/5+60);
   
   //---subject ID---
   textSize(30);
   text(ID, displayWidth/2, displayHeight*2/5);
   
   //---ID box---
   stroke(255);
   noFill();
   rect(displayWidth/2-120, displayHeight*2/5-30, 240, 60);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("実験スタート", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/2, displayHeight*9.5/10);
   
  }//---End of Scene#0---
  
  //------------------------------------
  // Scene#1-1: Play music
  //------------------------------------
  else if (nScene == 1){
   cursor(HAND);
   
   //---play music---
   if(!player.isPlaying()) {
     player.play();
   }
   
   fill(255);
    textSize(50);
    text("まず初めに、この音楽を聞いてください。", displayWidth/2, displayHeight/5);
    
   fill(255);
   textSize(20);
   text("再生が終了したら右下のボタンをクリックしてください。", displayWidth/2, displayHeight/5+60);
   
   //---play again button---
   if (player.isPlaying() && (BtnPlay_over == true)) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/3, displayHeight*9.5/10);
  
  }//---End of Scene#1-1---
  
  //------------------------------------
  // Scene#2-1: choosing adjective task
  //------------------------------------
  else if (nScene == 2) {
    cursor(HAND);
    
    if (createCSV) {
      String filename = ID + "_" + nf(year(),4) + nf(month(),2) + nf(day(),2) + nf(hour(),2) + nf(minute(),2) ;
      output = createWriter( filename + ".csv");   
      output.println( "mouse X, mouse Y" );
      createCSV = false;
    }
    
    fill(255);
    textSize(40);
    text("この曲を聞いてどのように感じましたか？", displayWidth/2, displayHeight/10-30);
    textSize(20);
    text("最も当てはまると思う位置をクリックしてください", displayWidth/2, displayHeight/10+10);
    
    //---感情チャート---
   img = loadImage("hyoka_circle.png");
   image(img, displayWidth/2-(1881/8), displayHeight/2-(1831/8), 1881/4, 1831/4); 
   
   //CSVデータ書き込み
   if (mousePressed) {
      output.println( (mouseX - displayWidth/2 ) +  "," + (mouseY - displayHeight/2)); 
    }
    
    img = loadImage("star.png");
    image(img, x-12, y-12, 24, 24);
    
   //---play again button---
   if (BtnPlay_over == true) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
  
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/2, displayHeight*9.5/10);
  
  }//---End of Scene#2-1---
  
  //------------------------------------
  // Scene#1-2: Play music
  //------------------------------------
  else if (nScene == 3){
   cursor(HAND);
   
   //---play music---
   if(!player.isPlaying()) {
     player.play();
   }
   
   fill(255);
    textSize(50);
    text("続いて、この音楽を聞いてください。", displayWidth/2, displayHeight/5);
    
   fill(255);
   textSize(20);
   text("再生が終了したら右下のボタンをクリックしてください。", displayWidth/2, displayHeight/5+60);
   
   //---play again button---
   if (player.isPlaying() && (BtnPlay_over == true)) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/3, displayHeight*9.5/10);
  
  }//---End of Scene#1-2---
  
  //------------------------------------
  // Scene#2-2: choosing adjective task
  //------------------------------------
  else if (nScene == 4) {
    cursor(HAND);
  
    fill(255);
    textSize(40);
    text("この曲を聞いてどのように感じましたか？", displayWidth/2, displayHeight/10-30);
    textSize(20);
    text("最も当てはまると思う位置をクリックしてください", displayWidth/2, displayHeight/10+10);
    
    //---感情チャート---
   img = loadImage("hyoka_circle.png");
   image(img, displayWidth/2-(1881/8), displayHeight/2-(1831/8), 1881/4, 1831/4); 
   
   //CSVデータ書き込み
   if (mousePressed) {
      output.println( "mouse X2, mouse Y2" );
      output.println( (mouseX - displayWidth/2 ) +  "," + (mouseY - displayHeight/2)); 
    }
    
    img = loadImage("star.png");
    image(img, x-12, y-12, 24, 24);
    
   //---play again button---
   if (BtnPlay_over == true) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
  
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/2, displayHeight*9.5/10);
  
  }//---End of Scene#2-2---
  
  //------------------------------------
  // Scene#1-3: Play music
  //------------------------------------
  else if (nScene == 5){
   cursor(HAND);
   
   //---play music---
   if(!player.isPlaying()) {
     player.play();
   }
   
   fill(255);
    textSize(50);
    text("続いて、この音楽を聞いてください。", displayWidth/2, displayHeight/5);
    
   fill(255);
   textSize(20);
   text("再生が終了したら右下のボタンをクリックしてください。", displayWidth/2, displayHeight/5+60);
   
   //---play again button---
   if (player.isPlaying() && (BtnPlay_over == true)) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/3, displayHeight*9.5/10);
  
  }//---End of Scene#1---
  
  //------------------------------------
  // Scene#2-3: choosing adjective task
  //------------------------------------
  else if (nScene == 6) {
    cursor(HAND);
 
    fill(255);
    textSize(40);
    text("この曲を聞いてどのように感じましたか？", displayWidth/2, displayHeight/10-30);
    textSize(20);
    text("最も当てはまると思う位置をクリックしてください", displayWidth/2, displayHeight/10+10);
    
    //---感情チャート---
   img = loadImage("hyoka_circle.png");
   image(img, displayWidth/2-(1881/8), displayHeight/2-(1831/8), 1881/4, 1831/4); 
   
   //CSVデータ書き込み
   if (mousePressed) {
      output.println( "mouse X3, mouse Y3" );
      output.println( (mouseX - displayWidth/2 ) +  "," + (mouseY - displayHeight/2)); 
    }
    
    img = loadImage("star.png");
    image(img, x-12, y-12, 24, 24);
    
   //---play again button---
   if (BtnPlay_over == true) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
  
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/2, displayHeight*9.5/10);
  
  }//---End of Scene#2-3---

  //------------------------------------
  // Scene#1-4: Play music
  //------------------------------------
  else if (nScene == 7){
   cursor(HAND);
   
   //---play music---
   if(!player.isPlaying()) {
     player.play();
   }
   
   fill(255);
    textSize(50);
    text("続いて、この音楽を聞いてください。", displayWidth/2, displayHeight/5);
    
   fill(255);
   textSize(20);
   text("再生が終了したら右下のボタンをクリックしてください。", displayWidth/2, displayHeight/5+60);
   
   //---play again button---
   if (player.isPlaying() && (BtnPlay_over == true)) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/3, displayHeight*9.5/10);
  
  }//---End of Scene#1-4---
  
  //------------------------------------
  // Scene#2-4: choosing adjective task
  //------------------------------------
  else if (nScene == 8) {
    cursor(HAND);
    
    fill(255);
    textSize(40);
    text("この曲を聞いてどのように感じましたか？", displayWidth/2, displayHeight/10-30);
    textSize(20);
    text("最も当てはまると思う位置をクリックしてください", displayWidth/2, displayHeight/10+10);
    
    //---感情チャート---
   img = loadImage("hyoka_circle.png");
   image(img, displayWidth/2-(1881/8), displayHeight/2-(1831/8), 1881/4, 1831/4); 
   
   //CSVデータ書き込み
   if (mousePressed) {
      output.println( "mouse X4, mouse Y4" );
      output.println( (mouseX - displayWidth/2 ) +  "," + (mouseY - displayHeight/2)); 
    }
    
    img = loadImage("star.png");
    image(img, x-12, y-12, 24, 24);
    
   //---play again button---
   if (BtnPlay_over == true) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
  
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/2, displayHeight*9.5/10);
  
  }//---End of Scene#2-4---
  
  //------------------------------------
  // Scene#1-5: Play music
  //------------------------------------
  else if (nScene == 9){
   cursor(HAND);
   
   //---play music---
   if(!player.isPlaying()) {
     player.play();
   }
   
   fill(255);
    textSize(50);
    text("続いて、この音楽を聞いてください。", displayWidth/2, displayHeight/5);
    
   fill(255);
   textSize(20);
   text("再生が終了したら右下のボタンをクリックしてください。", displayWidth/2, displayHeight/5+60);
   
   //---play again button---
   if (player.isPlaying() && (BtnPlay_over == true)) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/3, displayHeight*9.5/10);
  
  }//---End of Scene#1-5---
  
  //------------------------------------
  // Scene#2-5: choosing adjective task
  //------------------------------------
  else if (nScene == 10) {
    cursor(HAND);
  
    fill(255);
    textSize(40);
    text("この曲を聞いてどのように感じましたか？", displayWidth/2, displayHeight/10-30);
    textSize(20);
    text("最も当てはまると思う位置をクリックしてください", displayWidth/2, displayHeight/10+10);
    
    //---感情チャート---
   img = loadImage("hyoka_circle.png");
   image(img, displayWidth/2-(1881/8), displayHeight/2-(1831/8), 1881/4, 1831/4); 
   
   //CSVデータ書き込み
   if (mousePressed) {
      output.println( "mouse X5, mouse Y5" );
      output.println( (mouseX - displayWidth/2 ) +  "," + (mouseY - displayHeight/2)); 
    }
    
    img = loadImage("star.png");
    image(img, x-12, y-12, 24, 24);
    
   //---play again button---
   if (BtnPlay_over == true) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
  
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/2, displayHeight*9.5/10);
  
  }//---End of Scene#2-5---
  
  //------------------------------------
  // Scene#1-6: Play music
  //------------------------------------
  else if (nScene == 11){
   cursor(HAND);
   
   //---play music---
   if(!player.isPlaying()) {
     player.play();
   }
   
   fill(255);
    textSize(50);
    text("続いて、この音楽を聞いてください。", displayWidth/2, displayHeight/5);
    
   fill(255);
   textSize(20);
   text("再生が終了したら右下のボタンをクリックしてください。", displayWidth/2, displayHeight/5+60);
   
   //---play again button---
   if (player.isPlaying() && (BtnPlay_over == true)) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/3, displayHeight*9.5/10);
  
  }//---End of Scene#1-6---
  
  //------------------------------------
  // Scene#2-6: choosing adjective task
  //------------------------------------
  else if (nScene == 12) {
    cursor(HAND);
  
    fill(255);
    textSize(40);
    text("この曲を聞いてどのように感じましたか？", displayWidth/2, displayHeight/10-30);
    textSize(20);
    text("最も当てはまると思う位置をクリックしてください", displayWidth/2, displayHeight/10+10);
    
    //---感情チャート---
   img = loadImage("hyoka_circle.png");
   image(img, displayWidth/2-(1881/8), displayHeight/2-(1831/8), 1881/4, 1831/4); 
   
   //CSVデータ書き込み
   if (mousePressed) {
      output.println( "mouse X6, mouse Y6" );
      output.println( (mouseX - displayWidth/2 ) +  "," + (mouseY - displayHeight/2)); 
    }
    
    img = loadImage("star.png");
    image(img, x-12, y-12, 24, 24);
    
   //---play again button---
   if (BtnPlay_over == true) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
  
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/2, displayHeight*9.5/10);
  
  }//---End of Scene#2-6---
  
  //------------------------------------
  // Scene#1-7: Play music
  //------------------------------------
  else if (nScene == 13){
   cursor(HAND);
   
   //---play music---
   if(!player.isPlaying()) {
     player.play();
   }
   
   fill(255);
    textSize(50);
    text("続いて、この音楽を聞いてください。", displayWidth/2, displayHeight/5);
    
   fill(255);
   textSize(20);
   text("再生が終了したら右下のボタンをクリックしてください。", displayWidth/2, displayHeight/5+60);
   
   //---play again button---
   if (player.isPlaying() && (BtnPlay_over == true)) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/3, displayHeight*9.5/10);
  
  }//---End of Scene#1-7---
  
  //------------------------------------
  // Scene#2-7: choosing adjective task
  //------------------------------------
  else if (nScene == 14) {
    cursor(HAND);
  
    fill(255);
    textSize(40);
    text("この曲を聞いてどのように感じましたか？", displayWidth/2, displayHeight/10-30);
    textSize(20);
    text("最も当てはまると思う位置をクリックしてください", displayWidth/2, displayHeight/10+10);
    
    //---感情チャート---
   img = loadImage("hyoka_circle.png");
   image(img, displayWidth/2-(1881/8), displayHeight/2-(1831/8), 1881/4, 1831/4); 
   
   //CSVデータ書き込み
   if (mousePressed) {
      output.println( "mouse X7, mouse Y7" );
      output.println( (mouseX - displayWidth/2 ) +  "," + (mouseY - displayHeight/2)); 
    }
    
    img = loadImage("star.png");
    image(img, x-12, y-12, 24, 24);
    
   //---play again button---
   if (BtnPlay_over == true) {
   fill(0, 100, 100);
   } else {
   stroke(255);
   noFill();
   }
   rect(displayWidth/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("もう一度再生する", displayWidth/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2);
   
   //---Button 1---
   if (Btn1_over == true) {
     fill(100, 100, 0);
   } else {
     stroke(255);
     noFill();
   }
   rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
   
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("次へ", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
  
   textSize(15);
   textAlign(CENTER, CENTER);
   fill(255);
   text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/2, displayHeight*9.5/10);
  
  }//---End of Scene#2-7---
  
 //------------------------------------
  // Scene#3: end of the experiment
  //------------------------------------
  else if (nScene == 15) {
    cursor(HAND);
    
    textSize(40);
    textAlign(CENTER, CENTER);
    text("お疲れ様でした！", displayWidth/2, displayHeight/5+60);
    
   //---Button 1---
   if (Btn1_over == true) {
      fill(100,100,0);
    } 
    else {
      stroke(255);
      noFill();
    }
    rect(displayWidth*3/4-Btn1_w/2, displayHeight*8.5/10-Btn1_h/2, Btn1_w, Btn1_h);
    
    textSize(15);
    textAlign(CENTER,CENTER);
    fill(255);
    text("実験終了", displayWidth*3/4 - Btn1_w/2+Btn1_w/2, displayHeight*8.5/10 - Btn1_h/2+Btn1_h/2); 
  
    textSize(15);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Keio SFC Fujii Lab. Music Mind Emortion Project", displayWidth/2, displayHeight*9.5/10);
  
  }//---End of Scene#3---
}

//-----------
// Functions
//-----------

void mousePressed(){
  if (nScene == 0 && Btn1_over) { //ID
      nScene = 1 ;
  }
  else if (nScene == 1 && Btn1_over) { //Music-0
    nScene = 2 ;
    player.close();
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
  else if (nScene == 2 && Btn1_over) {
    nScene = 3;
    player.close();
    output.flush(); // Writes the remaining data to the file
    MusicNum += 1;
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
   else if (nScene == 3 && Btn1_over) { //Music-1
    nScene = 4 ;
    player.close();
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
  else if (nScene == 4 && Btn1_over) {
    nScene = 5;
    player.close();
    output.flush(); // Writes the remaining data to the file
    MusicNum += 1;
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
  else if (nScene == 5 && Btn1_over) { //Music-2
    nScene = 6;
    player.close();
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
   else if (nScene == 6 && Btn1_over) {
    nScene = 7;
    player.close();
    MusicNum += 1;
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
   else if (nScene == 7 && Btn1_over) { //Music-3
    nScene = 8;
    player.close();
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
   else if (nScene == 8 && Btn1_over) {
    nScene = 9;
    player.close();
    MusicNum += 1;
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
   else if (nScene == 9 && Btn1_over) { //Music-4
    nScene = 10;
    player.close();
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
   else if (nScene == 10 && Btn1_over) {
    nScene = 11;
    player.close();
    MusicNum += 1;
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
   else if (nScene == 11 && Btn1_over) { //Music-5
    nScene = 12;
    player.close();
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
   else if (nScene == 12 && Btn1_over) {
    nScene = 13;
    player.close();
    MusicNum += 1;
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
   else if (nScene == 13 && Btn1_over) { //Music-6
    nScene = 14;
    player.close();
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
   else if (nScene == 14 && Btn1_over) {
    nScene = 15;
    player.close();
    player = minim.loadFile("music-" + MusicNum +".mp3");
  }
  else if (nScene == 15 && Btn1_over) {
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    exit(); // Stops the program 
  }
  
  if ((nScene <= 16 ) && BtnPlay_click) {
    player.rewind();
    player.play();
  }
  
   if (nScene == 2 || nScene == 4 || nScene == 6 || nScene == 8 || nScene == 10 || nScene == 12 || nScene == 14 &&
      mouseX > displayWidth/2 && mouseX < (displayWidth/2 + 471) && 
      mouseY > displayWidth/2-(1881/4) && mouseY < (displayWidth/2-(1881/4) +471) ) {
    Choosing = true;
  } else {
    Choosing = false;
  }

}

void mouseMoved() { 
  checkButtons(); 
}

// ---Mouse Dragged Function---
void mouseDragged() {
  checkButtons(); 
}

// ---Check Buttons---
void checkButtons() {
  
  // Scene #0,1,3,4: check the Button#1
  if ((nScene <= 16) && 
       mouseX > displayWidth*3/4-Btn1_w/2 && mouseX < (displayWidth*3/4-Btn1_w/2 + Btn1_w) && 
       mouseY > displayHeight*8.5/10-Btn1_h/2 && mouseY < (displayHeight*8.5/10-Btn1_h/2 + Btn1_h)) {
    Btn1_over = true;   
  } else {
    Btn1_over = false;
  }
  if ((nScene <= 16) && 
      mouseX > displayWidth/4-Btn1_w/2 && mouseX < (displayWidth/4-Btn1_w/2 + Btn1_w) && 
      mouseY > displayHeight*8.5/10-Btn1_h/2 && mouseY < (displayHeight*8.5/10-Btn1_h/2 + Btn1_h)) {
   BtnPlay_over = true;   
  } else {
   BtnPlay_over = false;
  }
  if ((nScene <= 16) && 
      mouseX > displayWidth/4-Btn1_w/2 && mouseX < (displayWidth/4-Btn1_w/2 + Btn1_w) && 
      mouseY > displayHeight*8.5/10-Btn1_h/2 && mouseY < (displayHeight*8.5/10-Btn1_h/2 + Btn1_h)) {
   BtnPlay_click = true;   
  } else {
   BtnPlay_click = false;
  }
  
  if (nScene == 2 || nScene == 4 || nScene == 6 || nScene == 8 || nScene == 10 || nScene == 12 || nScene == 14&&
      mouseX > displayWidth/4-Btn1_w/2 && mouseX < (displayWidth/4-Btn1_w/2 + Btn1_w) && 
      mouseY > displayHeight*8.5/10-Btn1_h/2 && mouseY < (displayHeight*8.5/10-Btn1_h/2 + Btn1_h)){
        Choose_1 = true;
  } else {
        Choose_1 = false;
  }
  if (nScene == 2 || nScene == 4 || nScene == 6 || nScene == 8 || nScene == 10 || nScene == 12 || nScene == 14 &&
      mouseX > displayWidth/4-Btn1_w/2 && mouseX < (displayWidth/4-Btn1_w/2 + Btn1_w) && 
      mouseY > displayHeight*8.5/10-Btn1_h/2 && mouseY < (displayHeight*8.5/10-Btn1_h/2 + Btn1_h)){ 
        Choose_2 = true;
      } else {
        Choose_2 = false;
      }
   if (nScene == 2 || nScene == 4 || nScene == 6 || nScene == 8 || nScene == 10 || nScene == 12 || nScene == 14 &&
    mouseX > displayWidth/2 && mouseX < (displayWidth/2 + 471) && 
    mouseY > displayWidth/2-(1881/4) && mouseY < (displayWidth/2-(1881/4) +471) ) {
   Choosing = true;
    }else {
   Choosing = false;
    }
}

//---Menu ID Function---
void keyPressed(){
  if(nScene>=1 && key == ESC ){
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    exit(); // Stops the program              
  }
  else if (((key>='A')&&(key<='Z')) || ((key>='a')&&(key<='z')) || ((key>='0')&&(key<='9')) ) {
    letter = key;
    ID = ID + key;
    // Write the letter to the console
    println(ID);
  }
  else if (key == BACKSPACE || key == DELETE) {
   // Write the letter to the console
   int lID = ID.length();
   ID = ID.substring(0, lID-1);
   println(ID);
  }
  
  if (nScene == 2 || nScene == 4 && Choosing) {
    output.flush(); // Writes the remaining data to the file
    }
  
}

//---for Scene#2&#3---
void mouseClicked() {
    x = mouseX;
    y = mouseY;
 
}