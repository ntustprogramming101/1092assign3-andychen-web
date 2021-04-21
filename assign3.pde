final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;
final int block = 80;

int groundhogInitialX = block*4;
int groundhogInitialY = block*1;

int groundhogX = block*4;
int groundhogY = block*1;

int groundhogSpeed = 80;
int floor9 = 8*block+160;
int floor17 = 16*block+160;
int floor21 = 20*block+160;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil0,soil1,soil2,soil3,soil4,soil5,stone1,stone2;
PImage groundhogDown,groundhogIdle,groundhogLeft,groundhogRight, life;
int soilX;
int soilY;

// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	groundhogIdle=loadImage ("img/groundhogIdle.png");
  life = loadImage ("img/life.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
}

void draw() {
    /* ------ Debug Function ------ 
      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		
    case GAME_RUN:
    
        
		// Background
		image(bg, 0, 0);
    
    // Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50+cameraOffsetY,120,120);
      
		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil -----------------------
    int countX= width/block;
    int countY= 4;
    for (int y = 0; y<countY; y++){   //1-4 floors
      for (int x = 0; x<countX; x++){
      image(soil0, x*block, 160 + y*block);
      }
    }
    
    for (int y = 0; y<countY; y++){ //5-8 floors
      for (int x = 0; x<countX; x++){
      image(soil1, x*block, height + y*block); 
      }
    }
    
    for (int y = 0; y<countY; y++){ //9-12 floors
      for (int x = 0; x<countX; x++){
      int floor9 = 8*block+160;
      image(soil2, x*block, floor9 + y*block);
      }
    }
    
    for (int y = 0; y<countY; y++){ //13-16 floors
      for (int x = 0; x<countX; x++){
      int floor13 = 12*block+160;
      image(soil3, x*block, floor13 + y*block);
      }
    }
    
    for (int y = 0; y<countY; y++){ //17-20 floors
      for (int x = 0; x<countX; x++){
      int floor17 = 16*block+160;
      image(soil4, x*block, floor17 + y*block);
      }
    }
    for (int y = 0; y<countY; y++){ //21-24 floors
      for (int x = 0; x<countX; x++){
      image(soil5, x*block, floor21 + y*block);
      }
    }
    
    //stone 1~8 level
    int count= 8;
    int y=160;
    for (int x = 0;x<count;x++){
      image(stone1,x*block,y);
      y +=block;
    }
    
    //stone 9~16 level(part b)
    
    for (int x=block;x<width;x+=4*block){
      for (int yNew=floor9; yNew<floor9+9*block;yNew+=3*block){
      
        if(yNew==floor9+3*block){ 
        image(stone1,x,yNew+block);
        image(stone1,x+block,yNew+block);
        }
        if(yNew==floor9+6*block){
        yNew=floor9+7*block;
        }
        image(stone1,x,yNew);
        image(stone1,x+block,yNew);
      }
    }
    
    //stone 9~16 level(part a)
    for (int x=0;x<width;x+=3*block){
      for (int yNew=floor9+block; yNew<floor9+9*block;yNew+=4*block){
      
        if(x==3*block){ 
        image(stone1,x+block,yNew);
        image(stone1,x+block,yNew+block);
        }
        if(x==6*block){
        x=7*block;
        }
        image(stone1,x,yNew);
        image(stone1,x,yNew+block);
      }
    }
    //17~24
   //for(int i=0; i<count; i++ ){
   // for(int k=0; k<3; k++){
   //  for(int j=0; j<3; j++){
   //   float spacing= width/count;
   //   float stone1X= i*spacing;
   //   float stone1Y= 160+640+640+640-80-i*spacing;
   //   image(stone1,stone1X-240*k,stone1Y+240*j-a);
   //  }
   // }
   //}
    
    // Player
    image(groundhogIdle,groundhogX,groundhogY);  
    
		// Health UI

    for(int i=10 ;  i< 10+ 70*playerHealth; i+=70){
     image(life, i,10); //iInit=10,80 //i= 150...<10+70*5(maxHeart) 
    }
     
    break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;

			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
  if (cameraOffsetY > 0){
    cameraOffsetY =0;
  }

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
