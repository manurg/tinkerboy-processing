/**
 * SinFlower.pde
 * Manuel Rodriguez | tinkerboy.de
 * version 0.1
 * 
 * Draws a abstract flower
 * 
 * Copyright (c) 2011 Manuel Rodriguez
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

int IMAGE_WIDTH = 1024;
int IMAGE_HEIGHT = 768;
int centerX = floor(IMAGE_WIDTH / 2);
int centerY = floor(IMAGE_HEIGHT / 2);

boolean addNoise = false;
int numCircles = floor(random(45) + 5);

void setup() {
  size(IMAGE_WIDTH, IMAGE_HEIGHT);
  background(0);
  smooth();
  
  //how many circles to be drawn
  for (int i = 0; i < numCircles; i++){
    
    drawCircle();
  }
}

void drawCircle(){
  //define circle
  int startDegree = floor(random(360));
  int endDegree = startDegree + floor(random(315) + 45);
  int radius = floor(random(IMAGE_HEIGHT / 2) - 25) + 25;
  
  //define color
  //red - green - blue - alpha | max 255
  int r = floor(random(255));
  int g = floor(random(255));
  int b = floor(random(255));
  int a = 10;
  
  //define sin-waves
  int waveHeight = floor(random(10));
  float waveCounter = 0.0;
  float waveLength = random(1) / 20; //small Number -> long wave 
  
  //define noise | addNoise has to be true to take effect
  float noisePower = random(20);
  float noiseStart = random(1);
  float noiseAddValue = random(1) / 10;
  
  stroke(r, g, b, a);
  
  //draws noisy circle(part)
  for(float j = startDegree; j < endDegree; j += 0.1){
    float lineLength = 0;
    
    float noiseValue;
    if(addNoise){
      noiseValue = noise(noiseStart) * noisePower;
      lineLength += noiseValue;
    }
    
    lineLength += sin(waveCounter) * waveHeight + radius;
    
    line(centerX, centerY, cos(getRadian(j)) * lineLength + centerX, sin(getRadian(j)) * lineLength + centerY);
    
    noiseStart += noiseAddValue;
    waveCounter += waveLength;
  }
}

float getRadian(float degree){
  return degree * PI / 180;
}

