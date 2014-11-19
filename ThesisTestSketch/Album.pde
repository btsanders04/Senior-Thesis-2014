
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
  
  void pictureSpiral() {
 
     
      grabRange=50;
      testPicActive();
    inEditMode();
    if(stopRotation()) {
     countAngle+=(0.001%TWO_PI);
     drawPictures();
    }
   
    else 
    drawPictures();

}

void drawPictures(){
  
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
 
boolean stopRotation() { 
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
 
 
 
  void testPicActive() {
   for(int i=0;i<workingAlbum.size();i++){
    testPic=workingAlbum.get(i);
    if(testPic.state==2){
      picActive=true;
      break;
    }
    else picActive=false;
   }
  }
  
  void inEditMode() {
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

