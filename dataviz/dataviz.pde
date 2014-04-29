int w = 800;
int h = 600;

int rTime = 5; // sweep time in seconds
float angle = PI/4; // sweep angle in radians

// data
float[] x = new float[25];
float[] y = new float[25];
float[] t = new float[25];
color[] colors = new color[5];

//internals
PFont font;
int delay = 40; // between frames when animate
long startTime = 0;
int state = 0;
int cubeSize = (int)(0.5*min(w,h));
int unit = (int)(0.1*cubeSize);

int minZspan = cubeSize/5;
int maxZspan = cubeSize;
int minZstep = 0;
int maxZstep = minZspan;

float xstep = cubeSize/5; // base this on data
float ystep = cubeSize/5;
float zstep = maxZstep;
float zspan;


void setup(){
  size(w,h,OPENGL);
  font = loadFont("AmericanTypewriter-20.vlw");
  textFont(font,20);
  
  // generate data
  for(int l=0; l<25; l++){
    x[l] = (random(50)/10.-2.5); // -2.5 < x < 2.5
    y[l] = (random(50)/10.-2.5); // -2.5 < y < 2.5
    t[l] = (random(5*3600)/(3600.)); // 0 < t < 5
      
  }
  
  // throw random colors for days
  for(int r=0; r<5; r++){
    colors[r] = color(100+random(5)*20,100+random(5)*20,100+random(5)*20,100);
  }
}

void draw(){
  
  animate();
  
  background(0);
  // set the camera in front of the cube
  translate(width/2,height/2,-cubeSize);
  // sweep
  rotateY(sin(millis()%(rTime*1000)/((float)(rTime*1000.))*2*PI)*angle-angle);
  //rotateY(-PI/2); // side view
  
  for(int i=0; i<5; i++){
    pushMatrix();
      
      // draw daywise frames
      stroke(colors[i]);
      noFill();
      translate(0,0,((5-i)-1)*(zstep));
      rectMode(CORNERS);
      rect(-cubeSize/2,-cubeSize/2,cubeSize/2,cubeSize/2);
      
      fill(colors[i]);
      textFont(font,cubeSize/7.5);
      text((i+1),(cubeSize/7.5*i),-cubeSize/2-10);
      
      // draw legends on first daywise frame
      if(i==0){
        fill(255);
        textFont(font,15);
        text("Days",-cubeSize/2,-cubeSize/2-10);
        text("Energy",0,cubeSize/2+cubeSize/7.5+10);
        rotateZ(-PI/2);
        text("Mood",0,-cubeSize/2-10);
      } 
      if(state==0 && i==4){
        rotateY(PI/2);
        fill(255);
        textFont(font,15);
        text("Time of week",-cubeSize/2,cubeSize/2+cubeSize/7.5+10);
        rotateZ(-PI/2);
        text("Mood",-cubeSize/2,cubeSize/4+cubeSize/7.5+10);
      }     
      if(state==2 && i==4){
        rotateY(PI/2);
        fill(255);
        textFont(font,15);
        text("Time of day",-cubeSize/2,cubeSize/2+cubeSize/7.5+10);
        rotateZ(-PI/2);
        text("Mood",-cubeSize/2,cubeSize/4+cubeSize/7.5+10);
      }     
    popMatrix();
  }
  
  // draw datapoints
  for(int j=0; j<25; j++){
    pushMatrix();
      
      // get color
      int mday = (int)(t[j]);
      fill(colors[mday]);
      noStroke(); 
      
      // move to correct day
      translate(0,0,zstep*((5-mday)-2));
      // move to correct hour
      translate(xstep*x[j],ystep*y[j],zspan*(t[j]-mday));
      
      box(unit);
      
    popMatrix();  
  }
  
}

void keyPressed() {
  state = nextState(state);
}

int nextState(int current){
  current++;
  if(current>3){
    current = 0;
  }
  return current;
}

void animate(){
 
  switch(state){
     case 0:
       zspan = minZspan;
       zstep = maxZstep;
       break;
       
     case 1:
       // grow Z span for each day and ungrow Z step between days
       if(millis()-startTime>delay){
         if(zspan<maxZspan){
           zspan+=(maxZspan-minZspan)/25.;
         }
         if(zstep>minZstep){
           zstep-=(maxZstep-minZstep)/25.;
           println("bla");
         }
         
         startTime=millis();
       }
       if(zspan>=maxZspan && zstep<=minZstep){
         state = nextState(state);
       }
       break;
       
     case 2:
       zspan = maxZspan;
       zstep = minZstep;
       break;
       
     case 3:
       // ungrow Z span for each day and grow Z step between days
       if(millis()-startTime>delay){
         if(zspan>minZspan){
           zspan-=(maxZspan-minZspan)/25.;
         }
         if(zstep<maxZstep){
           zstep+=(maxZstep-minZstep)/25.;
         }
         
         startTime=millis();
       }
       if(zspan<=minZspan && zstep>=maxZstep){
         state = nextState(state);
       }
       break;
     default:
       break;
  } 
}
