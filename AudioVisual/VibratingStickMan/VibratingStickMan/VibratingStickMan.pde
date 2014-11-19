Man man= new Man(150,400,200,200);
import ddf.minim.*;

Minim minim;
AudioPlayer groove;

void setup()
{
  size(1024, 1024);

  minim = new Minim(this);
  groove = minim.loadFile("04 Deja Vu.mp3", 1024);
  groove.loop();
}

void draw()
{
  background(0);
  translate(width/2,height/4);
  man.drawMan();
  stroke( 255 );
  
 /* // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value
  for(int i = 0; i < groove.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, groove.bufferSize(), 0, width );
    float x2 = map( i+1, 0, groove.bufferSize(), 0, width );
    line( x1, 50 + groove.left.get(i)*50, x2, 50 + groove.left.get(i+1)*50 );
    line( x1, 150 + groove.right.get(i)*50, x2, 150 + groove.right.get(i+1)*50 );
  }
}*/
  
}
