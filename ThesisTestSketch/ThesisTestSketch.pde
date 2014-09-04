PImage img;
PImage img2;
int numPics;
ArrayList<Picture> picArray = new ArrayList<Picture>();
Picture pic;
Picture pic2;
Picture pic3;
Picture pic4;
Picture pic5;
Picture pic6;
Picture pic7;
Picture pic8;
Picture pic9;
Picture pic10;
Album picAlbum = new Album(picArray);
  float startAlbumPosnX;
  float startAlbumPosnY;



void setup() {
  size(1040,1040,P3D);
  startAlbumPosnX=200;
  startAlbumPosnY=200;
  img = loadImage("testPic1.jpg");
  img2=loadImage("testpic2.jpg");
  pic = new Picture(img);
  pic2 = new Picture(img2);
  pic3= new Picture(img);
  pic4 = new Picture(img2);
  pic5= new Picture(img);
  pic6 = new Picture(img2);
  pic7= new Picture(img);
  pic8 = new Picture(img2);
  pic9= new Picture(img);
  pic10 = new Picture(img2);

  
      picArray.add(pic);
      picArray.add(pic2);
      picArray.add(pic3);
      picArray.add(pic4);
      picArray.add(pic5);
      picArray.add(pic6);
      picArray.add(pic7);
      picArray.add(pic8);
      picArray.add(pic9);
      picArray.add(pic10);
  
  background(255);

}

void draw() {
   background(255);
  picAlbum.pictureSpiral();
//  println(frameRate);
}




//void pictureSpiral() {
  
//  background(255);
  
 /* for(int i=0;i<picArray.size();i++)
    {
      int picWidth = picArray.get(i).width;
      int picHeight = picArray.get(i).height;
      float startAngle=i*(2*PI/picArray.size());
    pushMatrix();
    translate(400,400);
    rotate(countAngle + startAngle);
    rotateY(PI/4);
   image(picArray.get(i),20,20,picWidth,picHeight);
   
    PVector v = new PVector(picWidth,picHeight);
    PVector m = new PVector(mouseX,mouseY);
    PVector r = new PVector(screenX(v.x,v.y),screenY(v.x,v.y));
    noFill();
    noStroke();
    }
    if(r.dist(m)<40)
      {

        
        rotateY(-PI/4);
        
        countAngle=0;
        startAngle=0;
       
       if(mousePressed) {
         pushMatrix();
         fill(255);
         rotateY(PI/4);
         noStroke();
         rect(20,20,picWidth,picHeight);
         popMatrix();
         
         translate(-r.x,-r.y);
         image(picArray.get(i),mouseX,mouseY,picWidth,picHeight);
       }
    }
    else {
      }
      
    ellipse(v.x-30,v.y,picWidth,picHeight/2);
    popMatrix();
  
    }
  countAngle = (countAngle+0.005)%TWO_PI;
  println(frameRate);*/
//}
