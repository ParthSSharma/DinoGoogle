PImage dinoRun1;
PImage dinoRun2;
PImage dinoJump;
PImage dinoDuck;
PImage dinoDuck1;
PImage smallCactus;
PImage bigCactus;
PImage manySmallCactus;
PImage bird;
PImage bird1;

ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Bird> birds = new ArrayList<Bird>();
ArrayList<Ground> grounds = new ArrayList<Ground>();

int obstacleTimer = 0;
int minTimeBetObs = 60;
int randomAddition = 0;
int groundCounter = 0;
float speed = 10;

int groundHeight = 50;
int playerXpos = 100;
int highScore = 0;

Player dino;

void setup(){
  size(800, 400);
  frameRate(60);
  
  dinoRun1 = loadImage("dinorun0000.png");
  dinoRun2 = loadImage("dinorun0001.png");
  dinoJump = loadImage("dinoJump0000.png");
  dinoDuck = loadImage("dinoduck0000.png");
  dinoDuck1 = loadImage("dinoduck0001.png");
  smallCactus = loadImage("cactusSmall0000.png");
  bigCactus = loadImage("cactusBig0000.png");
  manySmallCactus = loadImage("cactusSmallMany0000.png");
  bird = loadImage("berd.png");
  bird1 = loadImage("berd2.png");
  
  dino = new Player();
}

void draw(){
  background(250);
  stroke(0);
  strokeWeight(2);
  line(0, height - groundHeight - 30, width, height - groundHeight - 30);
  
  updateObstacles();
  
  if(dino.score > highScore){
    highScore = dino.score;
  }
  
  textSize(20);
  fill(0);
  text("Score: " + dino.score, 5, 20);
  text("High Score: " + highScore, width - (140 + (str(highScore).length() * 10)), 20);
}

void keyPressed(){
  switch(key){
    case ' ': dino.jump();
              break;
    case 's': if(!dino.dead){
                dino.ducking(true);
              }
              break;
  }
}

void keyReleased(){
  switch(key){
    case 's': if(!dino.dead){
                dino.ducking(false);
              }
              break;
    case 'r': if(dino.dead){
                reset();
              }
              break;
  }
}

void updateObstacles(){
  showObstacles();
  dino.show();
  if(!dino.dead){
    obstacleTimer++;
    speed += 0.002;
    if(obstacleTimer > minTimeBetObs + randomAddition){
      addObstacle();
    }
    groundCounter++;
    if(groundCounter > 10){
      groundCounter = 0;
      grounds.add(new Ground());
    }
    moveObstacles();
    dino.update();
  }
  else{
    textSize(32);
    fill(0);
    text("YOU DEAD! GIT GUD SCRUB!", 180, 200);
    textSize(16);
    text("(Press 'r' to restart!)", 330, 230);
  }
}

void showObstacles(){
  for(int i = 0; i < grounds.size(); i++){
    grounds.get(i).show();
  }
  for(int i = 0; i < obstacles.size(); i++){
    obstacles.get(i).show();
  }
  for(int i = 0; i < birds.size(); i++){
    birds.get(i).show();
  }
}

void addObstacle(){
  if(random(1) < 0.15){
    birds.add(new Bird(floor(random(3))));
  }
  else{
    obstacles.add(new Obstacle(floor(random(3))));
  }
  randomAddition = floor(random(50));
  obstacleTimer = 0;
}

void moveObstacles(){
  for(int i = 0; i < grounds.size(); i++){
    grounds.get(i).move(speed);
    if(grounds.get(i).posX < -playerXpos){
      grounds.remove(i);
      i--;
    }
  }
  for(int i = 0; i < obstacles.size(); i++){
    obstacles.get(i).move(speed);
    if(obstacles.get(i).posX < -playerXpos){
      obstacles.remove(i);
      i--;
    }
  }
  for(int i = 0; i < birds.size(); i++){
    birds.get(i).move(speed);
    if(birds.get(i).posX < -playerXpos){
      birds.remove(i);
      i--;
    }
  }
}

void reset(){
  dino = new Player();
  obstacles = new ArrayList<Obstacle>();
  birds = new ArrayList<Bird>();
  grounds = new ArrayList<Ground>();
  
  obstacleTimer = 0;
  randomAddition = floor(random(50));
  groundCounter = 0;
  speed = 10;
}
