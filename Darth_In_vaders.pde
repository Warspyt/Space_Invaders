import ddf.minim.*;

Minim minim;
AudioPlayer audioPlayer;
AudioPlayer audioShot;

//player
int pX = 400;
int pY = 500;
int pWidth = 50;
int pHeight = 30;
int pSpeed = 3;
boolean pDead = false;

//rocket

int r1X = pX;
int r1Y = pY;
int r1Position = 0;
int rWidth = 7;
int rHeight = 20;
int rSpeed = 5;
boolean isFired = false;

//alien
//aliens
int numAliens = 18;
int aliensAlive = numAliens;

int[] alX = new int[numAliens];
int[] alY = new int[numAliens];

boolean[] alienAlive = new boolean[numAliens];

int alWidth = 36;
int alHeight = 40;

float alienSpeed = 1.5;
int alienDirection = 1;   // 1 = derecha, -1 = izquierda
int alienDrop = 8;       // cuánto bajan

// Darth Vader (boss)

int vaderX = 400;
int vaderY = 140;

int vaderWidth = 75;
int vaderHeight = 75;
int vaderLife = 100;

float vaderSpeed = 3;
int vaderDirection = 1;
float probShot = 0.05;

// disparo de Vader
int vShotX;
int vShotY;
int vShotSpeed = 4;

boolean vaderFiring = false;

//counters
int score = 0;
int stage = 0;

//stage 0 = splash
//stage 1 = game
//stage 2 = win
//stage 3 = lose

//multimedia
//
PImage playerImage;
PImage soldierImage;
PImage darthVader;

PFont title;
PFont scoreFont;
PFont body;


void setup(){
  size(800,600);
  
  preload();
   
  //modes
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  
  minim = new Minim(this);
  audioPlayer = minim.loadFile("imperialMarch.mp3");
  audioPlayer.play();
  audioShot = minim.loadFile("lightsaber.mp3");
  
  
  scoreFont = createFont("Renegado-ABym.otf", 25);
  
  //aliens
  
  for(int i = 0; i < numAliens; i++){
  
    int row = i / 9;     // 3 filas
    int col = i % 9;     // 6 columnas
    
    alX[i] = 150 + col * 65;
    alY[i] = 200 + row * 80;
    
    alienAlive[i] = true;
  }
  
}

void draw(){
 
  if(stage == 0){
    splash();
  }
  if(stage == 1){
    game();
  }
  if(stage == 2){
    win();
  }
  if(stage == 3){
  lose();
  }
  if(mousePressed == true){
    stage = 1;
  }
  
}
void splash(){
  background(0);
  
  title = createFont("Renegado-ABym.otf", 80);
  body = createFont("Renegado-ABym.otf", 15);
  
  //board
  noFill();
  stroke(255,0,0);
  strokeWeight(random(2));
  rect(width/2, height/2, 700,500);
  noStroke();
  
  textFont(title);
  text("DARTH", width/2, 200);
  text("IN-VADERS", width/2, 300);
  
  textFont(body);
  text("PRESIONA LAS FLECHAS IZQUIERDA Y DERECHA PARA MOVERTE", width/2, 350);
  text("PRESIONA S PARA DISPARAR", width/2, 380);
  text("HAZ CLICK PARA EMPEZAR", width/2, 410);
  text("QUE LA FUERZA ESTÉ CONTIGO", width/2, 500);
  
}

void win(){
  background(255,0,0);
  
  title = createFont("Renegado-ABym.otf", 80);
  body = createFont("Renegado-ABym.otf", 15);
  //board
  noFill();
  stroke(255,0,0);
  rect(width/2, height/2, 700,500);
  noStroke();
  
  textFont(title);
  text("VICTORIA", width/2, 200);
  
  textFont(body);
  text("REFRESCA PARA JUGAR DE NUEVO", width/2, 250);
}

void lose(){
  background(0);

  textFont(title);
  text("DERROTA", width/2, 200);

  textFont(body);
  text("EL IMPERIO HA GANADO", width/2, 250);
}

void game(){
  
  keyPressed();
  keyTyped();
  
  background(0);
  
  //board
  noFill();
  stroke(255,0,0);
  rect(width/2, height/2, 700,500);
  noStroke();
  fill(255,0,0);
  rect(400,70, 700, 50);

  
  //player
  //fill(#FF9E00);
  image(playerImage,pX, pY, pWidth, pHeight);
  
  //Darth Vader
  image(darthVader, vaderX, vaderY, vaderWidth, vaderHeight);
  
  //alien 
  fill(255);
  
  
  for(int i = 0; i < numAliens; i++){
  
  if(alienAlive[i]){
    image(soldierImage, alX[i], alY[i], alWidth, alHeight);
  }
  
}

  moveVader();
  vaderShoot();
  moveAliens();
  fireRockets();
  
  //score bar
  fill(255);
  textSize(25);
  textFont(scoreFont);
  text("Score: ", 120,75);
  text(score, 190, 75);
  
  if(score >= 28){
   stage = 2; 
  }
  
   if(aliensAlive == 0){
     vShotSpeed = 8;
     probShot = 0.9;
     vaderSpeed = 6;
  }
  
}

void fireRockets(){
  // 0 = ready to be fired
  // 1 = moving 
  // 2 = collision
  

   
  if(isFired == true && r1Position == 0){
   r1Position = 1;

  }
  
  if(r1Position == 1){
   r1X = r1X;
   r1Y = r1Y - rSpeed;
   
   fill(#0AFF08);
   rect(r1X, r1Y, rWidth, rHeight);
   
   
   if(r1Y <= 0){
     r1Position = 2;
    }
  }
  else{
     r1Y = pY;
     r1X = pX;
   }
   
   if(r1Position == 2){
    r1Y = pY;
    r1X = pX;
    r1Position = 0;
   }
   
    for(int i = 0; i < numAliens; i++){
  
  if(alienAlive[i]){
    
    if(r1X >= alX[i]-alWidth/2 && 
       r1X <= alX[i]+alWidth/2 && 
       r1Y >= alY[i]-alHeight/2 && 
       r1Y <= alY[i]+alHeight/2){
       
      alienAlive[i] = false;
      r1Position = 2;
      score++;
      aliensAlive--; 
    }
    
  }
  }
}

void keyPressed(){

  if(keyCode == LEFT && keyPressed){
   pX = pX - pSpeed; 
      
  }
  
  if(keyCode == RIGHT && keyPressed){
   pX = pX + pSpeed; 
  }
}

void keyTyped(){
 
  if(key == 's' && keyPressed){
    isFired = true;   
     audioShot.play();
     audioShot.rewind();
  }
  else{
    isFired = false;
  }
}

void preload(){
  playerImage = loadImage("ship.png");
  soldierImage = loadImage("storm.png");
  darthVader = loadImage("Darth_Vader.png");
  darthVader = loadImage("darth.JPG");
  
  
}

void moveAliens(){

  alienSpeed = 1 + score/6;

  boolean changeDirection = false;

  for(int i = 0; i < numAliens; i++){

  if(alienAlive[i]){

    alX[i] += alienSpeed * alienDirection;

    if(alX[i] > width - 80 || alX[i] < 80){
      changeDirection = true;
    }

    // derrota 
    if(alY[i] + alHeight/2 >= pY){
      pDead = true;
      stage = 3;
    }

  }
}

  if(changeDirection){

    alienDirection *= -1;

    for(int i = 0; i < numAliens; i++){
      alY[i] += alienDrop;
    }

  }

}

void moveVader(){

  textFont(body);
  textSize(10);
  fill(255,0,0);
  text(vaderLife, vaderX, vaderY-20);
  
  vaderX += vaderSpeed * vaderDirection;

  if(vaderX > width - 90 || vaderX < 90){
    vaderDirection *= -1;
  }
  
  //collision
  if(r1X >= vaderX - vaderWidth/2 &&
       r1X <= vaderX + vaderWidth/2 &&
       r1Y >= vaderY - vaderHeight/2 &&
       r1Y <= vaderY + vaderHeight/2){
       
       if(vaderLife >= 10){
         score = score+1;
         vaderLife = vaderLife -10;
         r1Position = 2;
       }
       else{
         score = score+1;
        vaderSpeed = 0;
        vaderX = -1000;
        r1Position = 2;
       }
      }

}

void vaderShoot(){
  
  if(!vaderFiring && random(1) < probShot){
    
    vaderFiring = true;
    vShotX = vaderX;
    vShotY = vaderY;
    
  }

  if(vaderFiring){

    vShotY += vShotSpeed;

    fill(255,0,0);
    rect(vShotX, vShotY, 6, 20);

    if(vShotY > height){
      vaderFiring = false;
    }

    // colisión con el jugador
    if(vShotX >= pX - pWidth/2 &&
       vShotX <= pX + pWidth/2 &&
       vShotY >= pY - pHeight/2 &&
       vShotY <= pY + pHeight/2){

      stage = 3;
    }

  }

}