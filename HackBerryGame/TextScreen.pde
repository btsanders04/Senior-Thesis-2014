class TextScreen{
  
  
  int tileSize;
  
  void drawStart(){
     int indent = 25;
  
  // Set the font and fill for text
  textFont(f);
  fill(0);
  
  // Display everything
  text("Welcome to HackBerry, Use WASD to move. \nYour objective is to find and eat the HackBerries. Good Luck! \nPress enter a tile Size then press Enter to start.", indent, 40);
  text(typing,indent,120);
  text(saved,indent,150);
  }
  
   void drawEnd(){
     int indent = 25;
  
  // Set the font and fill for text
  textFont(f);
  fill(0);
  
  // Display everything
  text("Congratulations!  You won! Try again on a harder difficulty.", indent, 40);
  }
}
