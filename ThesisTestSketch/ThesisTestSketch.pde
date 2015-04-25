import TUIO.*;
TuioProcessing tuioClient;
boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks


//dummy images loaded into the sketch
PImage img1;
PImage img2;
PImage img3;
PImage img4;
PImage img5;
PImage img6;
PImage img7;

//changing variables for editing
float contrast;
float bright;

//background Img
PImage backgroundImg;


//List of Pictures
int numPics;
ArrayList<Picture> picArray = new ArrayList<Picture>();
Album picAlbum = new Album(picArray);



void setup() {
  size(1000,750,P3D);
  
  //determines where to start the rotating album on the screen
  picAlbum.startAlbumPosnX=200;
  picAlbum.startAlbumPosnY=200;
  
  //load in all the sample pictues
  img1=loadImage("DSC_0036.JPG");
  img2=loadImage("DSC_0053.JPG");
  img3=loadImage("DSC_0059.JPG");
  img4=loadImage("DSC_0270.JPG");
  img5=loadImage("DSC_0278.JPG");
  img6=loadImage("DSC_0287.JPG");
  img7=loadImage("DSC_0326.JPG");
  backgroundImg=loadImage("backgroundImg.png");
  backgroundImg.resize(1000,750);

  //set initial contrast and brightness
  contrast = 1;
  bright = 0;

  picArray.add(new Picture(img1));
  picArray.add(new Picture(img2));
  picArray.add(new Picture(img3));
  picArray.add(new Picture(img4));
  picArray.add(new Picture(img5));
  picArray.add(new Picture(img6));
  picArray.add(new Picture(img7));
  
  background(backgroundImg);
  println("All images initalized");
  
  //start TUIO listening
  tuioClient = new TuioProcessing(this);
}

void draw() {
  background(backgroundImg);

  //everything is done through the picture album so the only method called is pictureSpiral()
  picAlbum.pictureSpiral();

}


//used to edit the pictures once they are in the editing state
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


// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
          +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}

