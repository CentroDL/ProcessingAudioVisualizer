//The MIT License (MIT) - See Licence.txt for details

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies

/*
This doesn't use any trigonometry (no sin, cos or tan stuff, and no PI), but has a very similar affect.
 
 It uses a value I've called 'time' to keep things moving round. Have a play with it. 
 */
Maxim maxim; 
AudioPlayer player;
float time = 0; /* This is going to function as a clock. We'll update it with a value every time a frame gets drawn*/
float timeMod = 0.015;
boolean fill=true;
float power;
int loopCount;

void setup() {
  //loopCount = 20;
  maxim = new Maxim(this);
  player = maxim.loadFile("beat2.wav"); // audio from http://www.freesound.org/people/Timbre/sounds/218866/
  player.setLooping(true);
  player.volume(1.0);
  player.setAnalysing(true);
  power = player.getAveragePower();
  size(512, 512);/* setup the size */
  frameRate(24);/* This sets the current frameRate */
  colorMode(HSB);
}//SETUP

void draw() {
  player.play();
  power = player.getAveragePower();
  loopCount = (int)map(power, 0, 0.7, 0, 50);
  //println(time);

  //int bgHue = (int) map(power, 0, 0.4, 0, 255);
  //background(bgHue, 255, 255); 
  background(0);
  noFill();
  time=time+timeMod; 
  if (time > 5 || time < 0 || power > 0.3 || power < 0.15) {
    timeMod *=-1;
  }

  pushMatrix();
  translate(width*0.5, height*0.5);
//rotate(time);
//scale(1/time);
  spiral(width*0.5, height*0.5);
  spiral(width, 0); 
  spiral(width, height); 
  spiral(0, 0);
  spiral(0, height);

  circles(width*0.5, 0);
  circles(0, height*0.5);
  circles(width, height*0.5);
  circles(width*0.5, height);
  popMatrix();
}//DRAW


void spiral(float translateX, float translateY) {
  
  println(power); //used to tweak the loopcount variables
  
  pushMatrix();
  translate(translateX-width*0.5, translateY-height*0.5); 
  
  /*DRAW SQUARES, LINES, ELLIPSES*/
  for (int i = 0; i < loopCount; i++) { //loops according to audio power
    rotate(time); 
    ellipse(0, 0, i*15*power, i*15*power);//draws circles sized by audio power
    rect(i*2*time, i*2*time, i*15*power, i*15*power); //spaced by time & index, sized by power 
    line(0, 0, i*2*time, i*2*time); // draws line from the 'center' to each rectangle
    stroke((i*power*50)%255, i*power*200, 255); //colored based on index & power
    //strokeWeight(i*power);
  }//FOR
  popMatrix();
}//SPIRAL

void circles(float translateX, float translateY) {
//  float power = player.getAveragePower();
//  int loopCount = (int)map(power, 0, 0.6, 0, 50);
  pushMatrix();
  translate(translateX-width*0.5, translateY-height*0.5); 
  for (int i = 0; i < loopCount; i++) { 
    ellipse(0, 0, i*15*power, i*15*power);
    stroke((i*power*50)%255, i*power*200, 255);
  }//FOR
  popMatrix();
}//CIRCLES

