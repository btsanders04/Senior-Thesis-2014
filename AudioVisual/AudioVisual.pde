import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import java.util.*;
import java.io.*;
Minim minim;
AudioInput song;
AudioPlayer source;
BeatDetect beat;
BeatListener bl;
ArrayList<Star> stars;
Star star;
float kickSize, snareSize, hatSize, kickC, snareC, hatC, randomColor2, randomColor3, rotationCountX, rotationCountY, rotationCountZ; 
int randomColor;
int zChange=-500;
boolean randomColorDirection;
color starColor;
int colorRange=300;
BeatListener b1;
Matrix r;
void setup(){
  
  size(1030,1030,P3D);
  stars=new ArrayList<Star>();
  r = new Matrix();
  minim = new Minim(this);
  song = minim.getLineIn();
  //song.enableMonitoring();
  //song = minim.loadFile("02 Remember The Name (f. Styles Of B.mp3", 1024);
  //song.play();
  // a beat detection object that is FREQ_ENERGY mode that 
  // expects buffers the length of song's buffer size
  // and samples captured at songs's sample rate
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  // set the sensitivity to 300 milliseconds
  // After a beat has been detected, the algorithm will wait for 300 milliseconds 
  // before allowing another beat to be reported. You can use this to dampen the 
  // algorithm if it is giving too many false-positives. The default value is 10, 
  // which is essentially no damping. If you try to set the sensitivity to a negative value, 
  // an error will be reported and it will be set to 10 instead. 
  beat.setSensitivity(50);  
  kickSize = snareSize = hatSize = 16;

  // make a new beat listener, so that we won't miss any buffers for the analysis
//  bl = new BeatListener(beat, song);  
}

void draw() {
 background(0);
 fill(255);
 text("framerate: " + (int)frameRate,12,16);
 noFill();
 pushMatrix();
 translate(width/2,height/2);
 rotateX(rotationCountX);
 rotateY(rotationCountY);
 rotateZ(rotationCountZ);
 r.drawCube();
 popMatrix();
 pushMatrix();
 
 
 star= new Star(new PVector((int)random(0,width),(int)random(0,height),-100),.1);
 stars.add(star);
 for(int i=0;i<stars.size();i++){
    {
   //   println(stars.get(i).z + " " + stars.get(i).x);
      if(1000 < stars.get(i).z){
       // println("Made it");
        stars.remove(i);
      }
      else
      stars.get(i).draw();
      }
    }
 popMatrix();


 rotationCountX+=0.01;
 rotationCountY+=0.014;
 rotationCountZ+=0.008;
 randomColor= (randomColor+1) % colorRange;

 }

