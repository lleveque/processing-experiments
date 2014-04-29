int 
// screen dimensions
w = 800,
h = 600,

// video dimensions
vw = 16,
vh = 5,

// rotation angle in degrees
rot=0
;


float 
// angle between diagonal and vertical in the video
//angle = atan2(vw, vh),
angle = atan((float)vw / (float)vh),
// angle between diagonal and vertical in the screen
//screenangle = d(atan2(w, h)),
screenangle = d(atan((float)w / (float)h)),
// length of the video diagonal (not used)
diag = sqrt(vw*vw+vh*vh)/2;

// returns radians from degrees
float r(int deg)
{
  return (float)(deg)/360.*2*PI;
}

// returns degrees from radians
int d(float rad)
{
  return (int)(rad/(2*PI)*360);
}

void setup()
{
  // initialize screen
  size(w, h);
}

void draw()
{
  background(127);
  
  stroke(0);
  strokeWeight(3);
  
  float d1 = diag, d2 = diag;
  
  // get distance to border in the angle of the diagonal
  d1=scaleDiag(rot-d(angle));
  d2=scaleDiag(rot+d(angle));
  
  // get the min of them to scale the video
  float l = min(d1,d2);
  
  // draw
  pushMatrix();
  translate(w/2, h/2);
    rotate(r(rot));
    
    stroke(0);
    strokeWeight(1); 
    // draw the video
    rectMode(CENTER);
    rect(0, 0, sin(angle)*l*2, cos(angle)*l*2);
    
    pushMatrix();
      // left
      stroke(255,0,0);
      rotate(-angle);
      line(0,0,0,l);
      
      // right
      stroke(0,255,0);
      rotate(2*angle);
      line(0,0,0,l);
      
      // vertical
      stroke(0);
      rotate(-angle);
      line(0,0,0,-cos(angle)*l);
      
    popMatrix();
    
  popMatrix();
  
  rot++;
  rot = rot%360;
}

float scaleDiag(int rotAngle)
{
  float l = 0;
  if(rotAngle < screenangle || rotAngle >= 360-screenangle)
  {
    // up
    //line(10,10,w-10,10);
    l = h/2/cos(abs(r(rotAngle)));
  }
  else if(rotAngle < 180 - screenangle)
  {
    // right
    //line(w-10,10,w-10,h-10);
    l = w/2/cos(abs(r(rotAngle-90)));
  }
  else if(rotAngle < 180 + screenangle)
  {
    // down
    //line(w-10,h-10,10,h-10);
    l = h/2/cos(abs(r(rotAngle-180)));
  }
  else if(rotAngle < 360 - screenangle)
  {
    // left
    //line(10,h-10,10,10);
    l = w/2/cos(abs(r(rotAngle-270)));
  }
  //l-=15;
  return l;
}
