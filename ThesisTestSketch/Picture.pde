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
     float editPicPositionX=width*.55;
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
    yPointOnPic=picHeight*.75;
  }
  
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
  
  void selectPic() {
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
  
  boolean closeToPic() {
     if(absPosn.dist(m) < picAlbum.grabRange){
      return true;
    }
    else return false;
  }
   
  
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
 
 PImage editCase(PImage input) {
        
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
 
 void selectCase(PImage input) {
   
        
        fill(255, 255, 255, 100);
        rotate(picAlbum.countAngle + startAngle);
        rect(picPosn.x,picPosn.y,picWidth,picHeight);
        image(input,picPosn.x,picPosn.y,picWidth,picHeight);         
 }
 
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
 
 void moveCase(PImage input) {
   
        picAlbum.grabRange=50;
        fill(255,255,255,100);
        rect(m.x-startX,m.y-startX,picWidth,picHeight);
        image(input,m.x-startX,m.y-startX,picWidth,picHeight);
        if(m.x>editBoundary && !mousePressed){
          state=3;
        }
   
 }
 
 void savePic(){
   
    albumPic.copy(enhancedPic,0,0,enhancedPic.width,enhancedPic.height,0,0,enhancedPic.width,enhancedPic.height);
    contrast=1;
    bright=0;
 }
 
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



