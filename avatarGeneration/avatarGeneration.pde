final float baseFreq = 0.001f;
final int NB_POINTS = 14;
final int NB_PHASES = 3;

float[] f = new float[NB_PHASES];

float[] pr = new float[NB_POINTS];
float[] pt = new float[NB_POINTS];
int[] pp = new int[NB_POINTS];

void initValues()
{ 
  float seed;
  for(int i=0; i<NB_PHASES; i++)
  {
    seed = 1+9*(float)Math.random();
    f[i] = baseFreq/seed;
//    println(f[i]);
  }
  
  for(int i=0; i<NB_POINTS; i++)
  {
    pr[i] = 150-(float)random(50)-(i%2==0?60:0);
    pt[i] = i*2*PI/NB_POINTS;
    pp[i] = (int)random(NB_PHASES);
  }
}

void setup()
{
  size(400,400);
  initValues();
}

float now(float frequency)
{
  return 2*PI * (millis()%(1/frequency))*frequency;
}

void draw()
{
  background(255);
  
  pushMatrix();
    translate(30, 30);
    for(int i=0; i<f.length; i++)
    {
      pushMatrix();
        rotate(now(f[i]));
        line(10*i,0,10*i+10,0);
      popMatrix();
    }
  popMatrix();
  
  pushMatrix();
    translate(0, 30);
    for(int i=0; i<f.length; i++)
    {
      line(10*i,45+15*sin(now(f[i])), (10*(i+1)), 45+15*sin(now(f[i])));
    }
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  
  ellipse(0,0,300,300);
  ellipse(0,0,180,180);
  ellipse(0,0,80,80);
  
  for(int i=0; i<NB_POINTS; i++)
  {
    int j = (i+1)%NB_POINTS;
    float xi = x(pr[i],pt[i]+0.314*sin(now(f[pp[i]])));
    float yi = y(pr[i],pt[i]+0.314*sin(now(f[pp[i]])));
    float xj = x(pr[j],pt[j]+0.314*sin(now(f[pp[j]])));
    float yj = y(pr[j],pt[j]+0.314*sin(now(f[pp[j]])));
    line(xi,yi,xj,yj);
  }
  
  popMatrix();
}

void mousePressed()
{
  initValues();
}

float x(float r, float t) {return r * cos(t);}
float y(float r, float t) {return r * sin(t);}
float r(float x, float y) {return sqrt(x*x + y*y);}
float t(float x, float y) {return (float)Math.atan2(y, x);}
