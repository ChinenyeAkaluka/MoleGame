/*
* COMP 1010   SECTION A03
* INSTRUCTOR: Dr. Hadi Hemmati
* NAME: Chinenye Akaluka
* ASSIGNMENT: Assignment 5
* QUESTION: Question 2
* PURPOSE:THIS PROGRAM CREATES A GAME WHERE MECHANICAL MOLES POP OUT OF HOLES AND THE
* PLAYER IS RESPONSIBLE FOR HITTING THE MOLE BEFORE THEY HIDE AGAIN.
*
*/

//=====================================================================================
//GLOBAL VARIABLES

int y=0;      //Y-coordinate of the rectangles
int length_G=200;  //length of the rectangles
int width_G=100;   //width of the rectangles
int[] x_Coord = { 0, 100, 200, 300, 400, 500, 600, 700, 800, 900};      //array of all the x-coordinates
boolean[] moleUp={false,false,false,false,false,false,false,false,false,false };   //boolean array of moles
PShape pic1;  //empty hole
PShape pic2;  //hole with mole
float smallValue=0.001;  
int timer;    //timer for seconds
int text_X=500;  
int text_Y=300;
int myScore=0;
boolean gameCheck=false;  //boolean to check if time is exhausted
float check_Formula;  //float value to check if mouse clicks the mole
float part_A;  //first part of formula
float part_B;  //second part of formula
boolean check_Ellipse=false;    //boolean value to check if mouse clicks the mole

//=====================================================================================

void setup(){
  size(1000,300);
  pic1 = loadShape("empty.svg");
  pic2 = loadShape("full.svg");
  timer = 1200;
}

void draw(){
  background(0);
  
  if(timer==0)
    {
       gameCheck=true;
    }
    
  //if time is not up, game functions properly
  
  if(gameCheck==false)
  {
    drawGame();
    updateArray(moleUp);
    drawMoles(moleUp);
    timer-=1;  //FRAME COUNT
    drawScore(myScore, timer);
  }
  else
  //if time is up, game stops.
  {
   drawGame(); 
   updateArray(moleUp);
   drawMoles(moleUp);
   text("GAME OVER! Final Score:"+myScore,text_X,text_Y);
   noLoop();
  }
  
}

void drawGame(){
/*This function draws the game area of ten rectangles using a for loop*/

 for(int i=0;i<x_Coord.length;i++)
  {
    fill(255);
    stroke(0);
    rect(x_Coord[i],y,width_G,length_G);
    shape(pic1,x_Coord[i],y,width_G,length_G);
  } 
}

void updateArray(boolean[] moleUp){
/*This function updates moleUp array when the updateNumber is less than the small value
* The small value also increases with time.
*This function accepts a boolean array. it has no return value.
*/  
  for(int i=0;i<moleUp.length;i++)
  {
      float updateNumber=(random(1));
    if(updateNumber<smallValue)
    {
      moleUp[i]=true;
      
    }
    
  }
 if(myScore>0) 
 smallValue=0.001*(myScore/2);
}

void drawMoles(boolean[] moleUp){
/*This function draws the moles if an index in the moleUp array is true
* This function also accepts moleUp array. it has no return value.
*/

  for(int i=0;i<moleUp.length;i++)
  {
    if(moleUp[i]==true)
    {
      shape(pic2,x_Coord[i],y,width_G,length_G); 
    }
  }
}

void drawScore(int score, int framesLeft){
/* This function draws the text at the bottom of the canvas
*It also updates the time in seconds
*/
  fill(255);
  textSize(40);
  textAlign(CENTER);
  text(" score:" +score+"***" +" Time Left: "+framesLeft/60+"s", text_X,text_Y);
  
}

boolean isInEllipse(float x, float y, float ellipseX, float ellipseY, float ellipseWidth, float ellipseHeight){
/* This is a boolean function. 
* It takes the following parameters: x,y,ellipseX,ellipseY,ellipseWidth, ellipseHeight
* It used these parameters in a formula. if the formula is less than 1, check_ellipse is true
* It returns a boolean variable.
*/
  part_A=(sq(x-ellipseX))/sq(ellipseWidth/2);
 part_B=(sq(y-ellipseY))/sq(ellipseHeight/2);
 
check_Formula=part_A+part_B;
if(check_Formula<=1)
{
  check_Ellipse=true;
}
else
{
 check_Ellipse=false; 
}

return check_Ellipse;
}

void mousePressed(){
/*This function allows the mouse to hit the mole. when the mouse hits the mole, it hides.
*/

for(int i=0;i<x_Coord.length;i++)
{
  if(isInEllipse(mouseX, mouseY, (0.5*width_G)+x_Coord[i], 0.835*length_G, width_G, length_G)==true);
  {
    int clickPos = floor(mouseX/width_G);
    moleUp[clickPos]=false;
    shape(pic1,x_Coord[i],y,width_G,length_G);  }
}
  myScore++;

}
//====================================================================================
//END OF PROGRAM