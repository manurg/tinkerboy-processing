/**
 * SphereNet.pde
 * Manuel Rodriguez | tinkerboy.de
 * version 0.1
 * 
 * Draws random points on a sphere and connects them.
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

import processing.opengl.*;
import com.hardcorepawn.*; 

/* SETTINGS */
int WORLD_RADIUS = 300;
int STAGE_WIDTH = 1024;
int STAGE_HEIGHT = 768;
int NUM_POINTS = 1000;
float MAX_DISTANCE = 80; //max distance to connect 2 points

/* VARS */
SuperPoint sPoint;
Point3D[] points3D = {};

/* INITIALIZE */
void setup() {
  size(STAGE_WIDTH, STAGE_HEIGHT, OPENGL);
  translate(STAGE_WIDTH * 0.5, STAGE_HEIGHT * 0.5);
  smooth();
  
  sPoint = new SuperPoint(this);
  
  //generates random points on a sphere
  for (int i = 0; i < NUM_POINTS; i++){
    addPoint(random(-90, 90), random(-180, 180));
  }
  
}

void draw() {
  background(50);
  translate(STAGE_WIDTH * 0.5, STAGE_HEIGHT * 0.5);
  rotateY(frameCount/300.0);
  rotateX(frameCount/300.0);
  drawLines();
  sPoint.draw(1);
}

void drawLines() {
   for (int j = 0; j < points3D.length; j++) {
    
    Point3D currentPoint = (Point3D) points3D[j];
    
    for (int k = 0; k < points3D.length; k++) {
      Point3D nextPoint = (Point3D) points3D[k];
      float distance = dist(currentPoint.x, currentPoint.y, currentPoint.z, nextPoint.x, nextPoint.y, nextPoint.z);
      
      if ( distance < MAX_DISTANCE) {
        strokeWeight(1);
        stroke(255, 255, 255, 15 / MAX_DISTANCE * distance);
        line(currentPoint.x, currentPoint.y, currentPoint.z, nextPoint.x, nextPoint.y, nextPoint.z);
      }
    }
  }
}


void addPoint(float latitude, float longitude) {
  float lat = latitude * PI / 180;
  float lon = longitude * PI / 180;
  
  float pointX = -(WORLD_RADIUS) * cos(lat) * cos(lon);
  float pointY = (WORLD_RADIUS) * sin(lat);
  float pointZ = (WORLD_RADIUS) * cos(lat) * sin(lon);
  
  points3D = (Point3D[])append(points3D, new Point3D(pointX, pointY, pointZ));
  sPoint.addPoint(pointX, pointY, pointZ, 0.5, 0.5, 0.5, 0.5);
}


/* HELPER CLASS */
class Point3D {
 
  public float x, y, z;
  
  Point3D(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}
