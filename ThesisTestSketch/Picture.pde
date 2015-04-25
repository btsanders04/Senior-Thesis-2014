class Picture {

     PImage albumPic;
     PImage rawPic;
     PImage enhancedPic;
    
     PVector picPosn;
     PVector absPosn;
     PVector m = new PVector(0,0);
     PVector v;
     PVector editPicPosn;
     
     
     float xPointOnPic;
     float yPointOnPic;
     float editPicPositionX=width*.55;
     float editPicPositionY=height/9;

     float startAngle;
     
     float startX;
     float startY;
     int state;
     int picWidth;
     int picHeight;
     int editBoundary=width/2;
     int resizedWidth=100;
     int resizedHeight=130;
     
     int xOriginAlbum = 20;
     int yOriginAlbum = 20;
     
     String textValue = "";

     boolean tuioActive;
    
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
    yPointOnPic=picHeight*.75;
  }
  
  
  //does the appropriate method for the picture based on the state it is in
  void Render() {
    
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
  
  
  //selects a pic if the TUIO cursor lands on it  
  void selectPic() {

    ArrayList<TuioCursor> tuioCursorList = tuioClient.getTuioCursorList();
    for(int i=0; i<tuioCursorList.size(); i++) {
      TuioCursor tcur = tuioCursorList.get(i);
      m = new PVector(tcur.getScreenX(width), tcur.getScreenY(height));
      tuioActive=true; 
    }  
      if(!tuioActive)
      {
        m= new PVector(0,0);
      }
     if(closeToPic() && state!=2 && !picAlbum.picActive){
        if(tuioActive && !picAlbum.beingEdited) state=2;
        else if(picAlbum.beingEdited && state==3 && tuioActive) state=2;
        else if(state!=3 && !picAlbum.beingEdited) state=1;
       }
   
      else if((tuioActive && state!=3  && state!=2) || state==1){
        state=0;
      }
      else if(state==3 && tuioActive){
        state=2;
      }
      if(state==2  && !tuioActive){
        state=0;
      }
      tuioActive=false;
  }   
 
 
 //determines if the TUIOcursor is close enough to a picture in order to grab it 
  boolean closeToPic() {
  
      if(absPosn.dist(m) < picAlbum.grabRange){
          return true;
          }
        
      return false;
  }
   
  //changes contrast and brightness while in editing mode
 void ContrastAndBrightness(PImage input, PImage output,float cont,float bright)
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
      
       color inColor = input.pixels[i];
     
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
 
 
 //case for the image to be edited. returns an enhanced img that will replace the default img if returned to the album
 PImage editCase(PImage input) {
        
        picAlbum.grabRange=200;
        fill(255,255,255,100);
        input.resize(0,height/2);
        rect(width/2-startX,-startX,input.width,input.height);
        absPosn = new PVector(picPosn.x+xPointOnPic, picPosn.y+yPointOnPic);
        absPosn.x=editPicPositionX + startX;
        absPosn.y=editPicPositionY + startX;
        
        PImage imgEnhanced = new PImage(albumPic.width,albumPic.height);
         ContrastAndBrightness(albumPic,imgEnhanced, contrast, bright);
        image(imgEnhanced,width/2-startX,-startX);
        
        return imgEnhanced;
 }
 
 //case for selecting the picture. stops the rotation of the album and shows what picture has been selected
 void selectCase(PImage input) {
   
        
        fill(255, 255, 255, 100);
        rotate(picAlbum.countAngle + startAngle);
        rect(picPosn.x,picPosn.y,picWidth,picHeight);
        image(input,picPosn.x,picPosn.y,picWidth,picHeight);         
 }
 
 
 //if picture is not selected it will remain in the default rotate state which is the whole of the album
 void rotateCase(PImage input) {
   
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
 
 //allows the user to move the picture anywhere on the screen as long as they are touching it
 void moveCase(PImage input) {
   
        picAlbum.grabRange=50;
        fill(255,255,255,100);
        rect(m.x-startX,m.y-startX,picWidth,picHeight);
        image(input,m.x-startX,m.y-startX,picWidth,picHeight);
        if(m.x>editBoundary && !tuioActive){
          state=3;
        }
   
 }
 
 //saves the edited picture to the album
 void savePic(){
   
    albumPic.copy(enhancedPic,0,0,enhancedPic.width,enhancedPic.height,0,0,enhancedPic.width,enhancedPic.height);
    contrast=1;
    bright=0;
 }
 
 
 //inverts the colors of the picture creating a negative
 void invertPic(PImage input, PImage output) {
  
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
      
       color inColor = input.pixels[i];
     
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



