import processing.serial.*; 
Serial myPort;

void setup() {
  size(1000, 500);
  myPort = new Serial(this, Serial.list()[8], 9600);
}

int count = 0;
int prevVal=0, val=0;

void draw() {
  noStroke();
  fill(0, 5);
  rect(0, 0, width, height);
  fill(255);
  // Expand array size to the number of bytes you expect
  int lf = 10;
  stroke(0,255,150);
  strokeWeight(5);
//  while (true)
  {
    while (myPort.available () > 0) {
    // Expand array size to the number of bytes you expect:
    byte[] inBuffer = new byte[100];
    int readBytes = myPort.readBytes(inBuffer);
        for (int i=0; i<readBytes; i++)
        {
//          if(inBuffer[i]!=0)
          {
          count++;
          if (count>width)
          {
            count = 1;
          }
//          print("read ");
//          println(int(inBuffer[i]));
          val = int(height/2-map(inBuffer[i],0,128,-height/2, height/2));
          line(count-1, prevVal, count, val);
          prevVal = val;
//          line(count, (height/2-inBuffer[i]), count, height/2);
          }
        }
    }
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
