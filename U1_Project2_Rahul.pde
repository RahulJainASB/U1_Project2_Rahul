/*

Hedgehog and Tree Screensaver by Rahul Jain

This project is a screensaver that moves a tree vertically (across the y-axis) from random positions on the x axis.and a hedgehog horizontaly (across the x-axis)  
This porject uses the translate function to move the image to its new position and draws the image.

 */


// Tree variables
PImage tree;                   
float  treeXPosition     = 50;    
float  treeYPosition     = 10;
int    treeXDisplacement = 0;
int    treeYDisplacement = 4;
int    treeWidth         = 300;
int    treeHeight        = 300;

// Hedgehog variables
PImage hedgehog;
float hedgehogXPosition   = width / 2;
float hedgehogYPosition   = 700;
int hedgehogXDisplacement = 0;
int hedgehogYDisplacement = 0;
int hedgehogWidth         = 200;
int hedgehogHeight        = 100;

void setup()
{
  fullScreen();
  tree     = loadImage("Tree.png");
  hedgehog = loadImage("Hedgehog.png");
}

void draw() 
{
  
  if( hedgehogHasBeenHit() == true)
  {
    background(200);
    textSize(32);
    text("I have been hit", 500, 300);
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
    }
    
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
  if( hedgehogXPosition > (treeXPosition + treeWidth) )
    return false;
    
  if( (hedgehogXPosition + hedgehogWidth) < treeXPosition)
    return false;
    
  if( hedgehogYPosition > (treeYPosition + treeHeight) )
    return false;
    
  if( (hedgehogYPosition + hedgehogHeight) < treeYPosition)
    return false;
  
  return true;
}