import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import java.util.*;
import java.io.*;
Minim minim;

//can either play a song streamed from the internet or off a playlist on the computer. AduioInput makes use of a virtual jack that connects the audio input
// jack to the audio output so it can both listen to the music being played as well as play the music through speakers

//AudioInput song;
AudioPlayer song;


//Beat objects based on the Audio Input or Audio Player
BeatDetect beat;


//starfield creation
ArrayList<Star> stars;
Star star;


//rotate the overall cube matrix
float rotationCountX, rotationCountY, rotationCountZ; 

//iterates through the color spectrum 
int randomColor;

//color of all of the stars
color starColor;

//loops the color spectrum back around
int colorRange=300;


Matrix r;

void setup(){
  
  size(1000,750,P3D);
  stars=new ArrayList<Star>();
  r = new Matrix();
  minim = new Minim(this);
  //song = minim.getLineIn();
  song = minim.loadFile("http://87.229.26.112:8070/live.mp3");
  song.play();
  //song.enableMonitoring();
  //song = minim.loadFile("02 Remember The Name (f. Styles Of B.mp3", 1024);
  //song.play();
  // a beat detection object that is FREQ_ENERGY mode that 
  // expects buffers the length of song's buffer size
  // and samples captured at songs's sample rate
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  // set the sensitivity to 50 milliseconds
  // After a beat has been detected, the algorithm will wait for 50 milliseconds 
  // before allowing another beat to be reported. You can use this to dampen the 
  // algorithm if it is giving too many false-positives. The default value is 10, 
  // which is essentially no damping. If you try to set the sensitivity to a negative value, 
  // an error will be reported and it will be set to 10 instead. 
  beat.setSensitivity(50); 
 

}

void draw() {
 background(0);
 fill(255);
 noFill();
 pushMatrix();
 translate(width/2,height/2);
 
 //rotates the entire cube pseudo randomly
 rotateX(rotationCountX);
 rotateY(rotationCountY);
 rotateZ(rotationCountZ);
 r.drawCube();
 popMatrix();
 pushMatrix();
 
 //adds stars to the star field at random positions starting far away from the viewer and flying towards them
 star= new Star(new PVector((int)random(0,width),(int)random(0,height),-100),.1);
 
 //add the stars to the starfield in order to update all of their positions based on the same acceleration
 stars.add(star);
 
 //removes stars if they travel past the screen meaning they are no longer in view
 for(int i=0;i<stars.size();i++){
    {
      if(1000 < stars.get(i).z){
        stars.remove(i);
      }
      else
      stars.get(i).draw();
      }
    }
 popMatrix();

//rotations and color iterations that change the spin and color of the overall cube matrix
 rotationCountX+=0.01;
 rotationCountY+=0.014;
 rotationCountZ+=0.008;
 randomColor= (randomColor+1) % colorRange;

 }

