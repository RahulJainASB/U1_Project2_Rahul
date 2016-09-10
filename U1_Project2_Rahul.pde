/*

Hedgehog and Tree Screensaver by Rahul Jain

This project is a screensaver that moves a tree vertically (across the y-axis) from random positions on the x axis.and a hedgehog horizontaly (across the x-axis)  
This porject uses the translate function to move the image to its new position and draws the image.

 */

// General variables
boolean showInstructions = true;
int score = 0;
int level = 1;
int treesFallen = 1;
Tree tree1 = new Tree(100,0);
Tree tree2 = new Tree(500,0);
Tree tree3 = new Tree(1000,0);
Hedgehog hedgehog = new Hedgehog();
boolean stop = false;


class Tree
{
  PImage tree;                   
  float  treeX;    
  float  treeY;
  int    treeXSpeed;
  int    treeYSpeed;
  int    treeWidth;
  int    treeHeight;
  boolean isTreeDisplayed;
  
  Tree(float x, float y)
   {
     treeX=x;
     treeY=y;
     treeXSpeed        = 0;
     treeYSpeed        = 7;
     treeWidth         = 200;
     treeHeight        = 200;
     isTreeDisplayed = false;
   }
   
  void draw()
  {
  // Translate to the position where to draw the tree
  //  translate(treeXPosition, treeYPosition);
  //  image(tree, 0, 0, 300, 300);
    image(tree, treeX, treeY,  treeWidth, treeHeight);
  }
  
  //
  boolean moveDown()
  {
    if (isTreeDisplayed == false) 
    {
      return false;
    }
    else
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
  
  //
  boolean hasHitHedgehog()
  {
    if( hedgehog.hedgehogX > (treeX + treeWidth) )
    {
      println ("met1",hedgehog.hedgehogX,"    ",treeX, "     ",treeWidth );
      return false;
    }
    
    if( ( hedgehog.hedgehogX +  hedgehog.hedgehogWidth) < treeX)
     {
      println ("met2",hedgehog.hedgehogX,"    ",hedgehog.hedgehogWidth, "     ",treeX );
       return false;
     }
    if(  hedgehog.hedgehogY > (treeY + treeHeight) )
    {
           println ("met3",hedgehog.hedgehogY,"    ",treeY, "     ",treeHeight );

      return false;
    } 
    if( ( hedgehog.hedgehogY +  hedgehog.hedgehogHeight) < treeY)
     {
                 println ("met4",hedgehog.hedgehogY,"    ",hedgehog.hedgehogHeight, "     ",treeY );

       return false;
     }
     println ("met5");
     printYourself();
     hedgehog.printYourself();
    return true;
  }

  void printYourself()
  {
    println (treeX,"     ", treeY,"     ", treeWidth,"     ", treeHeight);
  }
  
}  // End of Tree class

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
    hedgehogXSpeed = 50;
    hedgehogYSpeed = 0;
    hedgehogWidth         = 200;
    hedgehogHeight        = 100;
  }
  void draw()
  {
    if( hedgehogX > (width - (hedgehogWidth/2)) ) // If hedgehog is too far to the right, move it in
      hedgehogX = hedgehogWidth/4; //width - hedgehogWidth/5;
    else if( hedgehogX < hedgehogWidth/5 ) // If hedgehog is too far to the left, move it in
      hedgehogX = width - hedgehogWidth/2;  //hedgehogWidth/2;
    
    image( picture, hedgehogX, hedgehogY, hedgehogWidth, hedgehogHeight);
  }
  void moveHedgehog(boolean moveLeft, boolean moveRight) // move hedgehog left or right
  {
    if (moveLeft == true)  hedgehogX -= hedgehogXSpeed; 
    if (moveRight == true) hedgehogX += hedgehogXSpeed;
  }
  void printYourself()
  {
    println (hedgehogX,"     ", hedgehogY,"     ", hedgehogWidth,"     ", hedgehogHeight);
  }
    
  
} // End of Hedgehog class


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
  
  
  if( (stop == true) || (hedgehogHasBeenHit() == true))
  {
    background(0);
    textSize(32);
    text("Game Over. The hedgehog has been poisoned.", width/2 - 120, height/2);
    textSize(16);
    showScore();
    stop = true;
  }
  else
  {
    background(0);
    
    drawTrees();
    hedgehog.draw();
   
    moveTreesDown();

    updateScore(); // Updates the score and level
    showScore();
  }
}

void drawTrees()
{
  if (level >= 1)
  {
   tree1.draw();
   tree1.isTreeDisplayed = true;
  }
  if (level >= 2)
  {
   tree2.draw();
      tree2.isTreeDisplayed = true;

  }
  if (level >= 3)
  {
   tree3.draw();
      tree3.isTreeDisplayed = true;

  }
}



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
}

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
  /*
  if ((score>=0) && (score<10))
    level = 1
  if ((score>=10) && (score<20))
    level = 2;
  */
  
  float i = score / 10;
  int j = floor(i);
  
  level=1+j;
  /*
  if ((score % 10) == 0)
  {
    level++;
  }
  */
}

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