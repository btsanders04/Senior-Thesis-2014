class Picture {
     PVector picPosn;
     PVector absPosn;
     PImage albumPic;
     int picWidth;
     int picHeight;
     PVector m;
     PVector v;
     PVector r;
     int state = 0;
     float countAngle;
     float startAngle;
     boolean isSelected;
     boolean isPickedUp;

    
  Picture(PImage rawPic) {
    picPosn = new PVector(20, 20);
    albumPic = rawPic;
    albumPic.resize(100,0);
    picWidth = albumPic.width;
    picHeight = albumPic.height; 
    isSelected = false;
  }
  
  void Render() {
   
    
    switch(state) {
      case 0: 
       
         pushMatrix();
      
         rotate(countAngle + startAngle);
         rotateY(PI/4);
         fill(0);
         image(albumPic,picPosn.x,picPosn.y,picWidth,picHeight);

         if (isSelected){
           fill(255, 255, 255, 100);
           pushMatrix();
           rotateY(-PI/4);
           rect(picPosn.x-5,picPosn.y,picWidth,picHeight);
           image(albumPic,picPosn.x-5,picPosn.y,picWidth,picHeight);
           popMatrix();
         }
         popMatrix();
         absPosn = new PVector(picPosn.x+picWidth/5, picPosn.y+(picHeight*.75));
         absPosn.rotate(countAngle + startAngle);
         absPosn.x += (startAlbumPosnX);
         absPosn.y += (startAlbumPosnY);
    //     println("absPosn.x= " + absPosn.x + ", absPosn.y= " + absPosn.y);
    
      break;
      
     case 1:

        image(albumPic,m.x-startAlbumPosnX,m.y-startAlbumPosnY,picWidth,picHeight);
        println(startAlbumPosnX + "," + startAlbumPosnY);
        
        break;
      }
    
     selectPic();
  }
  
  void selectPic() {
    m = new PVector(mouseX, mouseY); 
    
 //   println(picPosn.x + ", " + picPosn.y + " --> " + mouseX + ", " + mouseY);
        
    if(closeToPic() && state==0){
      picAlbum.isRotating = false;
      isSelected = true;
      mouseOn();
    }

    else if(!mousePressed){
      state=0;
      picAlbum.isRotating = true;
      isSelected = false;
    }
  }
    
  void mouseOn() {
    if(mousePressed) {
      
      state=1;
    }
    else {
      state=0;
    }
  }
  
  
  
  boolean closeToPic() {
     if(absPosn.dist(m) < 20){
      return true;
    }
    else return false;
  }
  
}

