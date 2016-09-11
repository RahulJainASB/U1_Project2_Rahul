/*
Hedgehog and Tree Game by Rahul Jain
This project is a game in which the user must move a picture to avoid a collision and lose the game.
 */

// General variables
boolean showInstructions  = true;
int     score             = 0;
int     level             = 1;
int     treesFallen       = 1;
Tree    tree1             = new Tree(100,0);
Tree    tree2             = new Tree(500,0);
Tree    tree3             = new Tree(1000,0);
Hedgehog hedgehog         = new Hedgehog();
boolean gameOver              = false;


void setup()
{
  fullScreen();
  hedgehog.picture    = loadImage("Hedgehog.png");
  tree1.picture       = loadImage("Tree.png");
  tree2.picture       = loadImage("Tree.png");
  tree3.picture       = loadImage("Tree.png");
}

void draw() 
{
  if (showInstructions == true)
  {
    displayInstructions();
  }
  else
  {
    if( (gameOver == true) || (hedgehogHasBeenHit() == true))
    {
      background(0);
      textSize(32);
      text("Game Over. The hedgehog has been poisoned.", width/2 - 120, height/2);
      textSize(16);
      showScore();
      gameOver = true;
    }
    else
    {
      background(0);
      drawTrees();
      hedgehog.draw();
      moveTreesDown();
      updateScore();   // Updates the score and level
      showScore();     // show the scores
    }
  }
}


// Responds to key presses
void keyPressed()
{
  if( key == CODED) {                  // check if key is CODED. This is for special keys
    if( keyCode == LEFT ) {            // if left key is pressed, move left
       hedgehog.moveHedgehog(true, false);
     }
     else if( keyCode == RIGHT ) {    // if right key is pressed, move right
       hedgehog.moveHedgehog(false,true);
     }
  }
  else if (key == ENTER || key == RETURN)
      showInstructions = false;        // This is set to false so that instructions are not showed again
}


// Draws the trees according to the level.
void drawTrees()
{
  if (level >= 1) 
  {
    tree1.draw();
    tree1.isTreeDisplayed = true;
  }
  if (level >= 2)                  // Show 2nd tree for level 2 or more
  {
    tree2.draw();
    tree2.isTreeDisplayed = true;
  }
  if (level >= 3)                  // Show 3rd tree for level 3 or more
  {
    tree3.draw();
    tree3.isTreeDisplayed = true;
  }
}


// Checks for collisions and ends the game if hedgehog has been bit by any tree
boolean hedgehogHasBeenHit()
{
  boolean hit = tree1.hasHitHedgehog();
  if (hit == false)
  {
    hit = tree2.hasHitHedgehog();
  }
  if (hit == false)
  {
    hit = tree3.hasHitHedgehog();
  }
  return hit;
}


// Display the welcome screen
void displayInstructions()
{
   background(0);
   textSize(32);
   text("This is the story of the hedgehog and evil trees.",                 (width/10), (height/2) - 100);
   text("The hedgehog must escape the forest.",                              (width/10), (height/2) - 50);
   text("If you go too close to the trees, you will be poisned and lose.",   (width/10), (height/2));
   text("Use the left and right arrow keys to move.",                        (width/10), (height/2) + 50);
   text("Press enter to begin the game.",                                    (width/10), (height/2) + 100);
}


// Show the user's score and level
void showScore()
{
  fill(255);
  textSize(14);
  text("Level: ",  width-280, 150);
  text (level,     width-230, 150);
  text("Score: " , width-280, 180);
  text (score,     width-230, 180);
}


// Updates score and level as game is played
void updateScore()
{
  //Update score
  score = treesFallen;

  // Update level
  int previousLevel = level;  // remember earlier level
  
  // Determine what the current level is based on the score. Level is increased as score increases by 10
  float s = score / 10;
  int l = floor(s);
  level=1+l;              // setting new level
  
  // Change the speed as level increases after level 3
  if( (level > previousLevel) && (level > 3))
  {
    tree1.treeYSpeed++;
    tree2.treeYSpeed++;
    tree3.treeYSpeed++;
  }
}


// This moves the trees down and counts how many trees have fallen so far
void moveTreesDown()
{
  boolean tree1ReachedBottom = tree1.moveDown();
  boolean tree2ReachedBottom = tree2.moveDown();
  boolean tree3ReachedBottom = tree3.moveDown();
  
  if (tree1ReachedBottom == true)
  {
    treesFallen++;
  }
  if (tree2ReachedBottom == true)
  {
    treesFallen++;
  }
  if (tree3ReachedBottom == true)
  {
    treesFallen++;
  }
}




//    This is Class Tree.                                 
//    It draws the tree and keeps all the data of the tree.
//    It also checks for collision with hedgehog.                                                     

class Tree
{
  PImage picture;                   
  float  treeX;    
  float  treeY;
  int    treeXSpeed;
  int    treeYSpeed;
  int    treeWidth;
  int    treeHeight;
  boolean isTreeDisplayed;
  
  
// This is the constructer to create the tree object
  Tree(float x, float y)
  {
    treeX             = x;
    treeY             = y;
    treeXSpeed        = 0;
    treeYSpeed        = 7;
    treeWidth         = 200;
    treeHeight        = 200;
    isTreeDisplayed   = false;
  }
   
  void draw()
  {
    image(picture, treeX, treeY,  treeWidth, treeHeight);
  }
  
  // Moves the tree down
  boolean moveDown()
  {
    if (isTreeDisplayed == false)         // Do not move the tree if it is not displayed
    {
      return false;
    }
    else
    {    
       treeY     += treeYSpeed;          // Move tree down
   
      if (treeY >= height )               // Reset tree position if tree reached the bottom of the screen
      {
        treeX = random(0,width);          // Get a new random X location at the top of the screen for the next tree
        
        if( treeX > (width - treeWidth/2) ) // If tree is too far to the right, move it in
          treeX = width - treeWidth/2;
          
        if( treeX < treeWidth/2 )         // If tree is too far to the left, move it in
          treeX = treeWidth/2;
          
        treeY = 0;                       // Move the tree to the top
        return true;
      }
      else
      {
        return false;                  // tree is still falling and has not reached the bottom
      }
    }
  }
  
  
  // Check for collision with hedgehog
  boolean hasHitHedgehog()
  {
    if( hedgehog.hedgehogX > (treeX + treeWidth) )                    // Check hedgehog's Left X and return false if there is no overlap
      return false;
    
    if( ( hedgehog.hedgehogX +  hedgehog.hedgehogWidth) < treeX)      // Check hedgehog's Right X and return false if there is no overlap
      return false;
     
    if(  hedgehog.hedgehogY > (treeY + treeHeight) )                  // Check hedgehog's top Left Y and return false if there is no overlap
      return false;
    
    if( ( hedgehog.hedgehogY +  hedgehog.hedgehogHeight) < treeY)     // Check hedgehog's bottom Right Y and return false if there is no overlap
      return false;
      
    return true;                                                      // Return true as there is overlap since the above 4 conditions are not met
  }

  // Print function to debug
  void printYourself()
  {
    println (treeX,"     ", treeY,"     ", treeWidth,"     ", treeHeight);
  }
  
}  // End of Tree class



//    This is Class Hedgehog.                                 
//    It draws the hedgehog and keeps all the data of the hedgehog.

class Hedgehog
{
  PImage picture;
  float hedgehogX;
  float hedgehogY;
  int hedgehogXSpeed;
  int hedgehogYSpeed;
  int hedgehogWidth;
  int hedgehogHeight;
    
  // This is the constructer to build the hedgehog
  Hedgehog()
  {
    hedgehogX          = width / 2;
    hedgehogY          = 700;
    hedgehogXSpeed     = 50;
    hedgehogYSpeed     = 0;
    hedgehogWidth      = 200;
    hedgehogHeight     = 100;
  }
  
  void draw()
  {
      // Check if hedgehog is off the screen before drawing
    if( hedgehogX > (width - (hedgehogWidth/2)) ) // If hedgehog is too far to the right, move it in
      hedgehogX = hedgehogWidth/4;
    else if( hedgehogX < hedgehogWidth/5 )        // If hedgehog is too far to the left, move it in
      hedgehogX = width - hedgehogWidth/2;
    
    image( picture, hedgehogX, hedgehogY, hedgehogWidth, hedgehogHeight); // draw the hedgehog
  }
  
  // Moves the hedgehog left of right depending on the arrow
  void moveHedgehog(boolean moveLeft, boolean moveRight) // move hedgehog left or right
  {
    if (moveLeft == true)  hedgehogX -= hedgehogXSpeed; 
    if (moveRight == true) hedgehogX += hedgehogXSpeed;
  }
  
  // print data to debug
  void printYourself()
  {
    println (hedgehogX,"     ", hedgehogY,"     ", hedgehogWidth,"     ", hedgehogHeight);
  }
    
} // End of Hedgehog class