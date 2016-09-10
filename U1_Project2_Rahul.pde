/*

Hedgehog and Tree Screensaver by Rahul Jain

This project is a screensaver that moves a tree vertically (across the y-axis) from random positions on the x axis.and a hedgehog horizontaly (across the x-axis)  
This porject uses the translate function to move the image to its new position and draws the image.

 */

// General variables
boolean showInstructions = true;
int score = 0;
int level = 1;

// Tree variables
PImage tree;                   
float  treeXPosition     = 50;    
float  treeYPosition     = 10;
int    treeXDisplacement = 0;
int    treeYDisplacement = 40;
int    treeWidth         = 300;
int    treeHeight        = 300;
int    treesFallen       = 0;

// Hedgehog variables
PImage hedgehog;
float hedgehogXPosition   = width / 2;
float hedgehogYPosition   = 700;
int hedgehogXDisplacement = 0;
int hedgehogYDisplacement = 0;
int hedgehogWidth         = width*2;
int hedgehogHeight        = height;

void setup()
{
  fullScreen();
  tree     = loadImage("Tree.png");
  hedgehog = loadImage("Hedgehog.png");
}

void draw() 
{
  if (showInstructions == true)
  {
    //displayInstructions();
    //showInstructions = false;
}
  
  
  if( hedgehogHasBeenHit() == true)
  {
    background(200);
    textSize(32);
    text("I have been hit", width/2 - 120, height/2);
  }
  else
  {
    background(0);
    
    drawTrees();
    drawHedgehog();
    
    treeYPosition     += treeYDisplacement;      // Move tree down
    hedgehogXPosition += hedgehogXDisplacement;  // Move hedgehog
  
    if (treeYPosition >= height )               // Reset tree position if tree reached the bottom of the screen
    {
      treeXPosition = random(0,width);
      
      if( treeXPosition > (width - treeWidth/2) ) // If tree is too far to the right, move it in
        treeXPosition = width - treeWidth/2;
        
      if( treeXPosition < treeWidth/2 ) // If tree is too far to the left, move it in
        treeXPosition = treeWidth/2;
        
      treeYPosition = 0;   
 //     hedgehogXPosition = 1;
 
      treesFallen++;
      updateScore(); // Updates the score and level
    }
    showScore();
    hedgehogXDisplacement = 0;  // Reset displacement to 0 so hedgehog will stay at its place if arrow keys are not pressed
  }
}

void drawTrees()
{
// Translate to the position where to draw the tree
//  translate(treeXPosition, treeYPosition);
//  image(tree, 0, 0, 300, 300);
  image(tree, treeXPosition, treeYPosition,  treeWidth, treeHeight);
}

void drawHedgehog()
{
// Translate to the position where hedgehog will be placed
//  translate(-treeXPosition + hedgehogXPosition + hedgehogXDisplacement, -treeYPosition + hedgehogYPosition + hedgehogYDisplacement);
//  image(hedgehog, 0, 0, 200, 100);

  image( hedgehog, hedgehogXPosition, hedgehogYPosition, hedgehogWidth, hedgehogHeight);
}

void keyPressed()
{
  if( key == CODED) {                  // check if key is CODED. This is for special keys
    if( keyCode == LEFT ) {            // if left key is pressed, move left
       hedgehogXDisplacement = -20;
     }
     else if( keyCode == RIGHT ) {    // if right key is pressed, move right
       hedgehogXDisplacement = +20;
     }
  }
}

boolean hedgehogHasBeenHit()
{
  return false;
  /*
  if( hedgehogXPosition > (treeXPosition + treeWidth) )
    return false;
    
  if( (hedgehogXPosition + hedgehogWidth) < treeXPosition)
    return false;
    
  if( hedgehogYPosition > (treeYPosition + treeHeight) )
    return false;;
    
  if( (hedgehogYPosition + hedgehogHeight) < treeYPosition)
    return false;
  
  return true;
  */
}

void displayInstructions()
{
   //background(50, 50, 50);
   //textSize(32);
   //text("testing", 50, 50);
   //String story = "This is the story of the hedgehog and evil trees. The hedgehog must escape the forest. If you go too close to the trees, you will be poisned and lose. Use the left and right arrow keys to move.";
   //text(story, width/2 - 120, height/2);
   //delay(3000);
}

void showScore()
{
 // fill(0);
//  rect(width-350, 100, 300, 100);
  fill(255);
  text("Level: ", width-280, 150);
  text (level, width-230, 150);
  text("Score: " , width-280, 180);
  text (score, width-230, 180);
}

void updateScore()
{
  score = treesFallen;
  if (score % 10 == 0)
  {
    level++;
  }
}