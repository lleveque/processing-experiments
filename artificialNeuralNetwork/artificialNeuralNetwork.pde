/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/2292*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
// Simple neural nets
// (c) Alasdair Turner 2009

// Free software: you can redistribute this program and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

Network neuralnet;

PFont font;
PFont defaultFont;
LearningGraph graph;

void setup()
{
  size(400,600);

  font = loadFont("LucidaSans-20.vlw");
  textFont(font);
  
  setupSigmoid();
  loadData();
  
  neuralnet = new Network(196,49,10);
  graph = new LearningGraph("Accuracy vs training");
  
  background(220,204,255);
  noStroke();
  smooth();
  pushMatrix();
  neuralnet.draw();
  popMatrix();
  fill(0);
}

boolean b_dataloaded = false;

// left click to test, right click (or ctrl+click on a Mac) to train
boolean b_train = false, b_test = false;

void draw()
{
  textFont(font);
  int response = -1, actual = -1;
  if (!b_dataloaded) {
    loadData();
    b_dataloaded = true;
    b_test = true;
  }
  if (b_train) {
    // this allows some fast training without displaying:
    for (int i = 0; i < 500; i++) {
      // select a random training input and train
      int row = (int) floor(random(0,training_set.length));
      response = neuralnet.respond(training_set[row].inputs);
      actual = training_set[row].output;
      neuralnet.train(training_set[row].outputs); 
    }
    
    // get accuracy data on all test set with this training
    float accuracy = 0;
    for (int row = 0; row < testing_set.length; row++)
    {
      response = neuralnet.respond(testing_set[row].inputs);
      actual = testing_set[row].output;
      accuracy = ((response==actual ? 1:0) + accuracy*row)/(row+1);
    }
    graph.add(neuralnet.trainingLevel, accuracy);
    
  }
  else if (b_test) {
    int row = (int) floor(random(0,testing_set.length));
    response = neuralnet.respond(testing_set[row].inputs);
    actual = testing_set[row].output;
  }
  if (b_train || b_test) {
    // draw
    background(220,204,255);
    noStroke();
    smooth();
    pushMatrix();
    neuralnet.draw();
    popMatrix();
    b_train = b_test = false;
    fill(0);
    text(str(response),350,27);
    text(str(actual),350,275);
  
    graph.draw(30, 430, 320, 140, 0, neuralnet.trainingLevel, 0, 1);
  }
  
  fill(0);
}

void mousePressed() 
{
  if (mouseButton == LEFT) {
    b_test = true;
  }
  else {
    b_train = true;
  }
}


