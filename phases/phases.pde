Phase p1 = new Phase(1000);
Phase p25 = new Phase(2500);
Phase p35 = new Phase(3500);
Phase p5 = new Phase(5000);
Phase p10 = new Phase(10000);

private static float l = 100;
private static float c = 30;

void setup()
{
  size(800, 800);
  rectMode(CORNERS);
  background(0);
  noStroke();
}

void draw()
{
  colorMode(RGB);
  fill(0,2);
  rect(0,0,width,height);
  
  pushMatrix();
    translate(width/2, height/2);
    rotate(-p25.r());
    
    colorMode(HSB, 255, 255, 255);
    
  //  fill(p5.b(p5.l()*p1.o())/2,p5.b(p25.i())/2, p5.b(p35.l())/2);
    fill(p5.b(p35.l())/2,0.25*p5.b(p1.i())+191, 190);
    
    pushMatrix();
      translate(0, -height/3);
      translate(width/8*p1.c(), height/8*p35.s());
      rect(-c/2, -c/2, c/2, c/2);
    popMatrix();
    
    colorMode(RGB);
    
//    fill(p5.b(),p5.b(p1.i()), p5.b(p1.l()));
    fill(p1.b(p1.i())/2+120,0,0);
    
  //  translate(0, height/4);
    
    pushMatrix();
      translate(-l,-l);
      drawWanderingSquares();
    popMatrix();
    
    drawWanderingSquares();
    
    fill(255,255,0);
    
    pushMatrix();
      rotate(-p10.r());
      rect(-l/8,-l/2,l/8,l/2);
    popMatrix();
//    
//    fill(p5.b(p5.l()*p1.o()),p5.b(p1.i()), p5.b(p1.l()));
//    
//    pushMatrix();
//      rotate(p5.r());
//      rect(-l/6,-l/6,l/6,l/6);
//    popMatrix();
  
  popMatrix();
  fill(255,10);
  drawWanderingSquares(min(height,width)-c, c);
}

void drawWanderingSquares()
{
  drawWanderingSquares(l, c);
}

void drawWanderingSquares(float l, float c)
{
  pushMatrix();
    translate(l*p1.p(), 0);
    rect(0,0,c,c);
  popMatrix();
  
  pushMatrix();
    translate(l,l);
    translate(0, -l*p1.n());
    rect(0,0,c,c);
  popMatrix();
  
  pushMatrix();
    translate(0,l);
    translate(l*p1.n(), 0);
    rect(0,0,c,c);
  popMatrix();
  
  pushMatrix();
    translate(0,l);
    translate(0, -l*p1.p());
    rect(0,0,c,c);
  popMatrix();
}
