/*

Hedgehog and Tree Screensaver by Rahul Jain

This project is a screensaver that moves a tree vertically (across the y-axis) from random positions on the x axis.and a hedgehog horizontaly (across the x-axis)  
This porject uses the translate function to move the image to its new position and draws the image.

 */

// General variables
boolean showInstructions = true;
int score = 0;
int level = 1;
int treesFallen = 0;
Tree tree1 = new Tree(100,0);
Tree tree2 = new Tree(500,0);
Tree tree3 = new Tree(1000,0);
Hedgehog hedgehog = new Hedgehog();


class Tree
{
  PImage tree;                   
  float  treeX;    
  float  treeY;
  int    treeXSpeed;
  int    treeYSpeed;
  int    treeWidth;
  int    treeHeight;
  
  Tree(float x, float y)
   {
     treeX=x;
     treeY=y;
     treeXSpeed        = 0;
     treeYSpeed        = 20;
     treeWidth         = 200;
     treeHeight        = 200;

   }
   
  void draw()
  {
  // Translate to the position where to draw the tree
  //  translate(treeXPosition, treeYPosition);
  //  image(tree, 0, 0, 300, 300);
    image(tree, treeX, treeY,  treeWidth, treeHeight);
  }
  
  boolean moveDown()
  {
     treeY     += treeYSpeed;      // Move tree down
  
    if (treeY >= height )               // Reset tree position if tree reached the bottom of the screen
    {
      treeX = random(0,width);
      
      if( treeX > (width - treeWidth/2) ) // If tree is too far to the right, move it in
        treeX = width - treeWidth/2;
        
      if( treeX < treeWidth/2 ) // If tree is too far to the left, move it in
        treeX = treeWidth/2;
        
      treeY = 0;   
      return true;
    }
    else
    {
      return false;
    }
   
  }
}

class Hedgehog
{
  PImage picture;
  float hedgehogX;
    float hedgehogY;
    int hedgehogXSpeed;
    int hedgehogYSpeed;
    int hedgehogWidth;
    int hedgehogHeight;
    
  Hedgehog()
  {
    hedgehogX   = width / 2;
    hedgehogY   = 700;
    hedgehogXSpeed = 0;
    hedgehogYSpeed = 0;
    hedgehogWidth         = width*2;
    hedgehogHeight        = height;
  }
  void draw()
  {
    image( picture, hedgehogX, hedgehogY, hedgehogWidth, hedgehogHeight);
  }
  void moveHedgehog()
   {
     hedgehogX += hedgehogXSpeed;  // Move hedgehog
   }
}


void setup()
{
  fullScreen();
  hedgehog.picture = loadImage("Hedgehog.png");
  tree1.tree     = loadImage("Tree.png");
  tree2.tree     = loadImage("Tree.png");
  tree3.tree     = loadImage("Tree.png");

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
    hedgehog.draw();
    
    boolean tree1ReachedBottom = tree1.moveDown();
    boolean tree2ReachedBottom = tree2.moveDown();
    boolean tree3ReachedBottom = tree3.moveDown();
    
    if (tree1ReachedBottom)
    {
      treesFallen++;
    }
    if (tree2ReachedBottom)
    {
      treesFallen++;
    }
    if (tree3ReachedBottom)
    {
      treesFallen++;
    }

    updateScore(); // Updates the score and level
    showScore();
    /*
    
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
  } */
  
}
}

void drawTrees()
{
  if (level >= 1)
  {
   tree1.draw();
  }
  if (level >= 2)
  {
   tree2.draw();
  }
  if (level >= 3)
  {
   tree3.draw();
  }
}



void keyPressed()
{
  if( key == CODED) {                  // check if key is CODED. This is for special keys
    if( keyCode == LEFT ) {            // if left key is pressed, move left
       hedgehog.hedgehogXSpeed = -30;
     }
     else if( keyCode == RIGHT ) {    // if right key is pressed, move right
       hedgehog.hedgehogXSpeed = +30;
     }
     hedgehog.moveHedgehog();
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