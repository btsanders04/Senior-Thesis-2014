package processing.test.thesistestsketch;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ThesisTestSketch extends PApplet {




PImage img1;
PImage img2;
PImage img3;
PImage img4;
PImage img5;
PImage img6;
PImage img7;
PImage img8;
PImage img9;
PImage img10;
float contrast;
float bright;
PImage backgroundImg;

int numPics;
ArrayList<Picture> picArray = new ArrayList<Picture>();
Album picAlbum = new Album(picArray);



public void setup() {
 
  picAlbum.startAlbumPosnX=200;
  picAlbum.startAlbumPosnY=200;
  img1=loadImage("test1.JPG");
  img2=loadImage("test2.JPG");
  img3=loadImage("test3.JPG");
  img4=loadImage("test4.JPG");
  img5=loadImage("test5.JPG");
  img6=loadImage("test6.JPG");
  img7=loadImage("test7.PNG");
  backgroundImg=loadImage("WoodBackground.jpg");
  backgroundImg.resize(1040,1040);
 // img8=loadImage("testpic8.JPG");
//  img9=loadImage("testpic9.JPG");
//  img10=loadImage("testpic10.JPG");
     contrast = 1;
     bright = 0;

    picArray.add(new Picture(img1));
    picArray.add(new Picture(img2));
    picArray.add(new Picture(img3));
    picArray.add(new Picture(img4));
    picArray.add(new Picture(img5));
    picArray.add(new Picture(img6));
    picArray.add(new Picture(img7));

//    picArray.add(new Picture(img8));
//    picArray.add(new Picture(img9));
//    picArray.add(new Picture(img10));
  
  background(backgroundImg);
  println("All images initalized");
}

public void draw() {

   background(backgroundImg);
  picAlbum.pictureSpiral();
  println(frameRate);
}


public void keyPressed() {

   switch(key) {
     case 'q': if(contrast >= 0) 
         contrast-=0.01f;
         bright+=1;
         break;
     
     case 'w': if(contrast <= 5) 
         contrast+=0.01f;
         bright-=1;
         break;
         
     case 'e': if(bright >= -128)
         bright+= 1;
         break;
     
     case 'd': if(bright <= 128)
         bright-= 1;
         break;
         
     case 'r':  contrast=1;
                bright=0;
                
         break;
     
     case 's': 
     
       for(int i=0; i<picAlbum.workingAlbum.size();i++){
         Picture tempPic = picAlbum.workingAlbum.get(i);
         if(tempPic.state==3) 
         {
           tempPic.savePic();
         }
       }
      
       break;
       
     case 'n':
     
        for(int i=0; i<picAlbum.workingAlbum.size();i++){
         Picture tempPic = picAlbum.workingAlbum.get(i);
         PImage imgOutput = new PImage(tempPic.albumPic.width,tempPic.albumPic.height);
         if(tempPic.state==3) 
         {
           tempPic.invertPic(tempPic.albumPic, imgOutput );
           tempPic.albumPic=imgOutput;
        
         }
       }
       
       break;
     
     default:
       break;  
   }
}   


class Album {
  
  ArrayList<Picture> workingAlbum;
  boolean isRotating;
  boolean picActive;
  boolean beingEdited;
  int grabRange;
  
  float startAlbumPosnX;
  float startAlbumPosnY;
  Picture testPic;
  int state = 0;
  float countAngle;
  
  Album(ArrayList<Picture> picArray) {
 
     workingAlbum=picArray;
     isRotating = true;
 
  }
  
  public void pictureSpiral() {
 
     
      grabRange=50;
      testPicActive();
    inEditMode();
    if(stopRotation()) {
     countAngle+=(0.001f%TWO_PI);
     drawPictures();
    }
   
    else 
    drawPictures();

}

public void drawPictures(){
  
    for(int i=0;i<workingAlbum.size();i++)
    {
       
   pushMatrix();
   translate(startAlbumPosnX,startAlbumPosnY);
      
   testPic = workingAlbum.get(i);
   testPic.startAngle=i*(2*PI/workingAlbum.size());
   testPic.Render();      
   popMatrix();
    }
 }
 
public boolean stopRotation() { 
  for(int i=0;i<workingAlbum.size();i++){
    testPic=workingAlbum.get(i);
    if(testPic.state==1)
    {
    isRotating=false;
    break;
  }
    else isRotating=true;
 }
 return isRotating;
 
}
 
 
 
  public void testPicActive() {
   for(int i=0;i<workingAlbum.size();i++){
    testPic=workingAlbum.get(i);
    if(testPic.state==2){
      picActive=true;
      break;
    }
    else picActive=false;
   }
  }
  
  public void inEditMode() {
    for(int i=0;i<workingAlbum.size();i++){
    testPic=workingAlbum.get(i);
    if(testPic.state==3){
      beingEdited=true;
      break;
    }
    else beingEdited=false;
   }
  }
}

class Picture {

     PImage albumPic;
     PImage rawPic;
     PImage enhancedPic;
    
     PVector picPosn;
     PVector absPosn;
     PVector m;
     PVector v;
     PVector editPicPosn;
     
     
     float xPointOnPic;
     float yPointOnPic;
     float editPicPositionX=width*.55f;
     float editPicPositionY=height/9;

     float startAngle;
     
     float startX;
     float startY;
     int state=0;
     int picWidth;
     int picHeight;
     int editBoundary=width/2;
     int resizedWidth=100;
     int resizedHeight=130;
     
     int xOriginAlbum = 20;
     int yOriginAlbum = 20;
     
     String textValue = "";

     
    
  Picture(PImage p) {
    picPosn = new PVector(xOriginAlbum, yOriginAlbum);
    rawPic = new PImage(p.width,p.height,RGB);
    rawPic.copy(p,0,0,p.width,p.height,0,0,p.width,p.height);
    
    albumPic = p;
    albumPic.resize(resizedWidth,resizedHeight);
    
    startX=picAlbum.startAlbumPosnX;
    startY=picAlbum.startAlbumPosnY;

    picWidth = albumPic.width;
    picHeight = albumPic.height; 
    xPointOnPic=picWidth/5;
    yPointOnPic=picHeight*.75f;
  }
  
  public void Render() {
   
    
    switch(state) {
      case 0: 
      
      rotateCase(albumPic);  


    
      break;
     
     case 1: 
     
       selectCase(albumPic);
          
         
      break;
      
     case 2:
     
        moveCase(albumPic);
        
        break;
      
      
      case 3:
        
        enhancedPic = editCase(albumPic);
       
        
      
      break;
    }

     selectPic();
  }
  
  public void selectPic() {
    m = new PVector(mouseX, mouseY); 
    
    if(closeToPic()&& state!=2 && !picAlbum.picActive){
      if(mousePressed && !picAlbum.beingEdited) state=2;
      else if(picAlbum.beingEdited && state==3 && mousePressed) state=2;
      else if(state!=3 && !picAlbum.beingEdited) state=1;
    }

    else if(!mousePressed && state!=3){
      state=0;
     
    }   
  }
  
  public boolean closeToPic() {
     if(absPosn.dist(m) < picAlbum.grabRange){
      return true;
    }
    else return false;
  }
   
  
 public void ContrastAndBrightness(PImage input, PImage output,float cont,float bright)
 {
   int w = input.width;
   int h = input.height;
   
  
   if(w != output.width || h != output.height)
   {
     println("error: image dimensions must agree");
     return;
   }
   
   input.loadPixels();
   output.loadPixels();
      
   for(int i = 0; i < w*h; i++)
   {  
      
       int inColor = input.pixels[i];
     
       int r = (inColor >> 16) & 0xFF; //like calling the function red(), but faster
       int g = (inColor >> 8) & 0xFF;
       int b = inColor & 0xFF;      
       
       r = (int)(r * cont + bright); //floating point aritmetic so convert back to int with a cast (i.e. '(int)');
       g = (int)(g * cont + bright);
       b = (int)(b * cont + bright);
       
       r = r < 0 ? 0 : r > 255 ? 255 : r;
       g = g < 0 ? 0 : g > 255 ? 255 : g;
       b = b < 0 ? 0 : b > 255 ? 255 : b;
       
       output.pixels[i]= 0xff000000 | (r << 16) | (g << 8) | b; //this does the same but faster
   
   }
   
   input.updatePixels();
   output.updatePixels();
 }
 
 public PImage editCase(PImage input) {
        
        picAlbum.grabRange=200;
        fill(255,255,255,100);
        input.resize(0,height/2);
        rect(width/2-startX,-startX,input.width,input.height);
    //    picAlbum.grabRange=200;
        absPosn = new PVector(picPosn.x+xPointOnPic, picPosn.y+yPointOnPic);
        absPosn.x=editPicPositionX + startX;
        absPosn.y=editPicPositionY + startX;
        
        PImage imgEnhanced = new PImage(albumPic.width,albumPic.height);
         ContrastAndBrightness(albumPic,imgEnhanced, contrast, bright);
        image(imgEnhanced,width/2-startX,-startX);
        
        return imgEnhanced;
 }
 
 public void selectCase(PImage input) {
   
        
        fill(255, 255, 255, 100);
        rotate(picAlbum.countAngle + startAngle);
        rect(picPosn.x,picPosn.y,picWidth,picHeight);
        image(input,picPosn.x,picPosn.y,picWidth,picHeight);         
 }
 
 public void rotateCase(PImage input) {
   
         picAlbum.grabRange=50;
         rotate(picAlbum.countAngle + startAngle);
         rotateY(PI/4);
         fill(0);
         
         image(input,picPosn.x,picPosn.y,picWidth,picHeight);
  
         absPosn = new PVector(picPosn.x+xPointOnPic, picPosn.y+yPointOnPic);
         absPosn.rotate(picAlbum.countAngle + startAngle);
         absPosn.x += (startX);
         absPosn.y += (startX);
 }
 
 public void moveCase(PImage input) {
   
        picAlbum.grabRange=50;
        fill(255,255,255,100);
        rect(m.x-startX,m.y-startX,picWidth,picHeight);
        image(input,m.x-startX,m.y-startX,picWidth,picHeight);
        if(m.x>editBoundary && !mousePressed){
          state=3;
        }
   
 }
 
 public void savePic(){
   
    albumPic.copy(enhancedPic,0,0,enhancedPic.width,enhancedPic.height,0,0,enhancedPic.width,enhancedPic.height);
    contrast=1;
    bright=0;
 }
 
 public void invertPic(PImage input, PImage output) {
  
   int w = input.width;
   int h = input.height;
   
  
   if(w != output.width || h != output.height)
   {
     println("error: image dimensions must agree");
     return;
   }
   
   input.loadPixels();
   output.loadPixels();
      
   for(int i = 0; i < w*h; i++)
   {  
      
       int inColor = input.pixels[i];
     
       int r = (inColor >> 16) & 0xFF; //like calling the function red(), but faster
       int g = (inColor >> 8) & 0xFF;
       int b = inColor & 0xFF;      
       
       r = (int)(255-r); //floating point aritmetic so convert back to int with a cast (i.e. '(int)');
       g = (int)(255-g);
       b = (int)(255-b);
       
       r = r < 0 ? 0 : r > 255 ? 255 : r;
       g = g < 0 ? 0 : g > 255 ? 255 : g;
       b = b < 0 ? 0 : b > 255 ? 255 : b;
       
       output.pixels[i]= 0xff000000 | (r << 16) | (g << 8) | b; //this does the same but faster
   
   }
   
   input.updatePixels();
   output.updatePixels();
 }

}




  public int sketchWidth() { return 1040; }
  public int sketchHeight() { return 1040; }
  public String sketchRenderer() { return P3D; }
}
