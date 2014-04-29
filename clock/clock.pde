float SPEED = 1;

float SECOND_PERIOD = 1000/SPEED;
float MINUTE_PERIOD = 60*SECOND_PERIOD;
float HOUR_PERIOD = 60*MINUTE_PERIOD;
float TWELVE_HOURS_PERIOD = 12*HOUR_PERIOD;
float DAY_PERIOD = 24*HOUR_PERIOD;

int CLOCK_RADIUS = 600;
int CLOCK_PADDING = 10;

void setup() 
{
  size(2*(CLOCK_RADIUS+CLOCK_PADDING), 2*(CLOCK_RADIUS+CLOCK_PADDING));
  smooth();
}

float dphase = 0, tphase = 0, hphase = 0, mphase = 0, sphase = 0;

void draw()
{
  background(0);
  translate(CLOCK_RADIUS+CLOCK_PADDING, CLOCK_RADIUS+CLOCK_PADDING);
  
  dphase = (millis()%DAY_PERIOD)/DAY_PERIOD; // [0..1]
  tphase = (millis()%TWELVE_HOURS_PERIOD)/TWELVE_HOURS_PERIOD; // [0..1]
  hphase = (millis()%HOUR_PERIOD)/HOUR_PERIOD; // [0..1]
  mphase = (millis()%MINUTE_PERIOD)/MINUTE_PERIOD; // [0..1]
  sphase = (millis()%SECOND_PERIOD)/SECOND_PERIOD; // [0..1]
  
  // hours references
  pushMatrix();
    strokeWeight(2);
    stroke(#ffffff,127);
    for(int i=0; i<12; i++)
    {
      rotate(1./12.*2*PI);
        line(CLOCK_RADIUS*0.9,0,CLOCK_RADIUS,0);
    }
  popMatrix();
  
  // day ticker
  pushMatrix();
    translate(CLOCK_RADIUS/3,CLOCK_RADIUS/3);
      noFill();
      strokeWeight(1);
      stroke(#ffffff,32);
      ellipse(0,0,CLOCK_RADIUS/6+8,CLOCK_RADIUS/6+8);
      rotate(dphase*2*PI);
        strokeWeight(3);
        stroke(#ffffff,255);
        line(0,0,0,-CLOCK_RADIUS/12);
  popMatrix();
  
  // second ticker
  pushMatrix();
  translate(-CLOCK_RADIUS/3,CLOCK_RADIUS/3);
  stroke(#ffffff,32);
  strokeWeight(1);
  noFill();
  ellipse(0,0,CLOCK_RADIUS/6+8,CLOCK_RADIUS/6+8);
  rotate(sphase*2*PI);
  strokeWeight(3);
  stroke(#ffffff,255);
  line(0,0,0,-CLOCK_RADIUS/12);
  popMatrix();
  
  // seconds
  pushMatrix();
  stroke(#ff0000,255);
  rotate(mphase*2*PI);
  line(0,0,0,-CLOCK_RADIUS/6*5);
  popMatrix();
  
  // minutes
  pushMatrix();
  stroke(#ffffff,255);
  rotate(hphase*2*PI);
  line(0,0,0,-CLOCK_RADIUS/4*3);
  popMatrix();
  
  // hours
  pushMatrix();
  stroke(#808080,255);
  rotate(tphase*2*PI);
  line(0,0,0,-CLOCK_RADIUS/2);
  popMatrix();
  
}
