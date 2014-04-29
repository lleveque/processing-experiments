import processing.serial.*; 
//Serial myPort;

void setup() {
  size(1000, 500);
  background(0);
  //  myPort = new Serial(this, Serial.list()[8], 9600);
}
int count = 0;
int prevVal=0, val=0;
void draw() {
  noStroke();
  fill(0, 10);
  rect(0, 0, width, height);
  fill(255);
  stroke(0, 255, 150);

//  delay(1);
  for (int i=0; i<1; i++)
  {
    count++;
    if (count>width)
    {
      count = 1;
    }
    val = (int)min(max(val+(random(60)-30), 0), height);
    line(count-1, prevVal, count, val);
    prevVal = val;
  }
}


// Arduino
//void setup() {
//  Serial.begin(9600);
//}
//
//void loop() {
////  int sensorValue = analogRead(A0);
//  int sensorValue = random(255);
////  int sensorValue = 128*sin(2*PI*(millis()%1000)/1000);
//  Serial.write(sensorValue);
//  delay(1);        // delay in between reads for stability
//}

