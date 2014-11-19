int rectX, rectY;      // Position of square button
int rectSize = 300;     // Diameter of rect
int trans=170;
int spacing=340;
color rectColor, baseColor;
color rectHighlight;
color currentColor;
boolean rectOver = false;


void setup(){
  size(1030,1030);
  background(255);
  rectColor = color(0);
  rectHighlight = color(51);
  baseColor = color(102);
  currentColor = baseColor;
  rectX = width/2-rectSize-10;
  rectY = height/2-rectSize/2;
  
}


void draw() {
 
   background(currentColor);
   
     
  pushMatrix();
  translate(trans,trans);
  smooth();
  
  for(int xRect=0;xRect<width;xRect+=spacing){
    for(int yRect=0;yRect<height;yRect+=spacing){
    
      update(mouseX-trans,mouseY-trans,xRect,yRect);
      if (rectOver) {
    fill(rectHighlight);
    } else {
    fill(rectColor);
    }
    stroke(255);
      rectMode(CENTER);
      rect(xRect,yRect,rectSize,rectSize,18);
    }
  }
  popMatrix();
 
}

void update(int x, int y, int xRect, int yRect) {
 if ( overRect(x, y, xRect, yRect, rectSize) ) {
    rectOver = true;
  } else {
 rectOver = false;
  }
}

void mousePressed() {
  if (rectOver) {
    currentColor = rectColor;
  }
}

boolean overRect(int xPos, int yPos, int x, int y, int rect)  {
  if (xPos >= x-rect/2 && xPos <= x+rect/2 && 
      yPos >= y-rect/2 && yPos <= y+rect/2) {
    return true;
  } else {
    return false;
  }
}


