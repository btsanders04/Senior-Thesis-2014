
import controlP5.*;

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



void setup() {
  size(1040,1040,P3D);
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

void draw() {

   background(backgroundImg);
  picAlbum.pictureSpiral();
  println(frameRate);
}


void keyPressed() {

   switch(key) {
     case 'q': if(contrast >= 0) 
         contrast-=0.01;
         bright+=1;
         break;
     
     case 'w': if(contrast <= 5) 
         contrast+=0.01;
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

