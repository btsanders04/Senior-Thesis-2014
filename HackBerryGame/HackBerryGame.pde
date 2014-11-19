import java.util.*;


Board b;
Player p;
Lava l;
EndGame eg;
TextScreen ts;
int state=0;
int tileSize=0;
int numPlayers=0;
PFont f;

// Variable to store text currently being typed
String typing = "";

// Variable to store saved text when return is hit
String saved = "";

void setup(){
  size(500,500);
  f = createFont("Arial",16,true);

  ts = new TextScreen();
}

void draw(){
  background(255);

  switch(state){
    case(0): ts.drawStart();
    break;
    case(1): b= new Board(width,height);
             p= new Player(randomTile());
             l = new Lava(randomTile());
             eg = new EndGame(randomTile());
             b.setup();
             state=2;
    break;
    case(2): l.draw();
             b.draw();
             p.draw();
             
             eg.draw();
             if(eg.Eaten())
             state=3;
    break;
    case(3): b.draw();
             p.draw();
             ts.drawEnd();
    break;  
  }
}
  


void keyPressed(){
  if(state==0){
     if (key == '\n' ) {
    saved = typing;
    if(isNumeric(saved)){
    tileSize=Integer.parseInt(saved);
    state=1;
    }
    // A String can be cleared by setting it equal to ""
    typing = ""; 
    } 
    else {
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    typing = typing + key; 
    }
  }
   else if(state==2){
  if(key=='a'){
    p.moveLeft();
  }
  if(key=='s'){
    p.moveDown();
  }
  if(key=='d'){
    p.moveRight();
  }
  if(key=='w'){
    p.moveUp();
  }
 }
}

public static boolean isNumeric(String str)  
{  
  try  
  {  
    int i = Integer.parseInt(str);  
  }  
  catch(NumberFormatException nfe)  
  {  
    return false;  
  }  
  return true;  
}

PVector randomTile(){
  
  return b.tiles[new Random().nextInt(b.tiles.length)];
}
