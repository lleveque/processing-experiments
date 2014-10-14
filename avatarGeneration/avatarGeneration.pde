final float baseFreq = 1/3000.f;
final int NB_POINTS = 7;
final int NB_POINTS_CENTER = 2;
final int NB_PHASES = 1;

float[] f = new float[NB_PHASES];

// first ring
float[] p1r = new float[NB_POINTS];
float[] p1t = new float[NB_POINTS];
int[] p1p = new int[NB_POINTS];
// second ring
float[] p2r = new float[NB_POINTS];
float[] p2t = new float[NB_POINTS];
int[] p2p = new int[NB_POINTS];
// center
float[] p3r = new float[NB_POINTS_CENTER];
float[] p3t = new float[NB_POINTS_CENTER];
int[] p3p = new int[NB_POINTS_CENTER];

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
    p1r[i] = 150-(float)random(30);
    p1t[i] = i*2*PI/NB_POINTS;
    p1p[i] = (int)random(NB_PHASES);
    
    p2r[i] = 150-(float)random(50)-60;
    p2t[i] = i*2*PI/NB_POINTS;
    p2p[i] = (int)random(NB_PHASES);
  }
  
  for(int i=0; i<NB_POINTS_CENTER; i++)
  {
    p3r[i] = (float)random(30);
    p3t[i] = PI+i*2*PI/NB_POINTS_CENTER;
    p3p[i] = (int)random(NB_PHASES);
  }
}

void setup()
{
  size(200,200);
  initValues();
}

float now(float frequency)
{
  return 2*PI * (millis()%(1/frequency))*frequency;
}

void draw()
{
  background(255);
  fill(255,0);
//  pushMatrix();
//    translate(30, 30);
//    for(int i=0; i<f.length; i++)
//    {
//      pushMatrix();
//        rotate(now(f[i]));
//        line(10*i,0,10*i+10,0);
//      popMatrix();
//    }
//  popMatrix();
//  
//  pushMatrix();
//    translate(0, 30);
//    for(int i=0; i<f.length; i++)
//    {
//      line(10*i,45+15*sin(now(f[i])), (10*(i+1)), 45+15*sin(now(f[i])));
//    }
//  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  
//  stroke(0,70);
//  ellipse(0,0,300,300);
//  ellipse(0,0,180,180);
//  ellipse(0,0,80,80);
  
  stroke(0,0);
  for(int i=0; i<NB_POINTS; i++)
  {
    int alpha1=255,alpha2=128,alpha3=128,alpha4=255;
    
    int k = (i+1)%NB_POINTS;
    float xi = x(p1r[i],p1t[i]+0.314*sin(now(f[p1p[i]])));
    float yi = y(p1r[i],p1t[i]+0.314*sin(now(f[p1p[i]])));
    float xj = x(p2r[i],p2t[i]+0.314*sin(now(f[p2p[i]])));
    float yj = y(p2r[i],p2t[i]+0.314*sin(now(f[p2p[i]])));
    float xk = x(p1r[k],p1t[k]+0.314*sin(now(f[p1p[k]])));
    float yk = y(p1r[k],p1t[k]+0.314*sin(now(f[p1p[k]])));
    float xl = x(p2r[k],p2t[k]+0.314*sin(now(f[p2p[k]])));
    float yl = y(p2r[k],p2t[k]+0.314*sin(now(f[p2p[k]])));
    
    fill(255*sin(xi),yi,(sin(now(f[p1p[i]]))+1)*128,alpha1);
//    float seed = 1;
//    fill(seed*255,seed*102,0,70);
    triangle(xi,yi,xj,yj,xk,yk);
    fill(255*sin(xk),yk,(sin(now(f[p2p[k]]))+1)*128,alpha2);
    triangle(xk,yk,xj,yj,xl,yl);
    
    int m = i%NB_POINTS_CENTER;
    float xm = x(p3r[m],p3t[m]+0.314*sin(now(f[p3p[m]])));
    float ym = y(p3r[m],p3t[m]+0.314*sin(now(f[p3p[m]])));
    fill(255*sin(xi),yi,(sin(now(f[p1p[i]]))+1)*255,alpha3);
    triangle(xj,yj,xm,ym,xl,yl);
    
    int n = (m+1)%NB_POINTS_CENTER;
    float xn = x(p3r[n],p3t[n]+0.314*sin(now(f[p3p[n]])));
    float yn = y(p3r[n],p3t[n]+0.314*sin(now(f[p3p[n]])));
    fill(255*sin(xn),yn,(sin(now(f[p3p[n]]))+1)*255,alpha4);
    triangle(xm,ym,xl,yl,xn,yn);
  }
  
  noFill();
  stroke(0);
  strokeWeight(240);
  ellipse(0,0,400,400);
  strokeWeight(1);
  
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
