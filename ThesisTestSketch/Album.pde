

class Album {
  
  ArrayList<Picture> workingAlbum;
  boolean isRotating;
 
  float countAngle;
//  float startAngle;
  Picture testPic;
  
  Album(ArrayList<Picture> picArray) {
 
     workingAlbum=picArray;
     isRotating = true;
 
  }
  
  void pictureSpiral() {
  
  for(int i=0;i<workingAlbum.size();i++)
    {
     
     pushMatrix();
      translate(startAlbumPosnX,startAlbumPosnY);
     
      testPic = workingAlbum.get(i);
      testPic.startAngle=i*(2*PI/workingAlbum.size());
      
    //  rotateAlbum();
      testPic.Render();
       
      popMatrix();
    }
     
   
   
    
  }
  
  void rotateAlbum(){
    if(isRotating){
        testPic.countAngle+=(0.001%TWO_PI);
       // rotate(countAngle);
      
    }
  }
}
