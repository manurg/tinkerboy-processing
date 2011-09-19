/**
 * RandomGrid.pde
 * Manuel Rodriguez | tinkerboy.de
 * version 0.1 - undocumented and silly code
 * 
 * Draws a random grid
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

private static final int SCREEN_WIDTH = 800;
private static final int SCREEN_HEIGHT = 600;
private static final int LINE_LENGTH = 5;
private static final int STEPS_TO_REDRAW = 2000;

color[] colors = new color[5];
float[] weights = new float[6];

int currentColorIndex, currentWeightIndex, currentDrawStep = 0;

Point lastPosition = new Point(round(SCREEN_WIDTH / 2), round(SCREEN_HEIGHT / 2));
int lastX, lastY;
int lastDirection = 0;

void setup(){
 size(SCREEN_WIDTH, SCREEN_HEIGHT);
 background(0);
 smooth();
 
 setWeights();
 setColors();
}

void setWeights(){
  
  weights[0] = 1;
  weights[1] = 2;
  weights[2] = 3;
  weights[3] = 4;
  weights[4] = 3;
  weights[5] = 2;
  
}


void setColors(){
  
  float blueChannel = random(1);
  
  colors[0] = color(round(255 * blueChannel * .3), round(255 * blueChannel * .3), round(255 * blueChannel));
  colors[1] = color(round(200 * blueChannel * .3), round(200 * blueChannel * .3), round(230 * blueChannel));
  colors[2] = color(round(150 * blueChannel * .3), round(150 * blueChannel * .3), round(205 * blueChannel));
  colors[3] = color(round(100 * blueChannel * .3), round(100 * blueChannel * .3), round(180 * blueChannel));
  colors[4] = color(round(50 * blueChannel * .3), round(50 * blueChannel * .3), round(155 * blueChannel));
  
}

void mouseClicked(){
  restartFromPoint(mouseX, mouseY);
}

void restartFromPoint(int _x, int _y){
  lastPosition.setX(_x);
  lastPosition.setY(_y);
  setColors();
  currentDrawStep = 0;
}


void draw(){
  
  if (currentDrawStep == STEPS_TO_REDRAW){
    restartFromPoint(round(random(SCREEN_WIDTH)), round(random(SCREEN_HEIGHT)));
    return;
  }
  
  // CALCULATE DIRECTION
  // 0 = UP
  // 1 = RIGHT
  // 2 = DOWN
  // 3 = LEFT
  int _direction = round(random(8));
  if(_direction == lastDirection) return; //early out
  
  currentWeightIndex = currentWeightIndex < weights.length - 1 ? currentWeightIndex + 1 : 0;
  currentColorIndex = currentColorIndex < colors.length - 1 ? currentColorIndex + 1 : 0;
  
  lastX = lastPosition.getX();
  lastY = lastPosition.getY();
  
  stroke(colors[currentColorIndex]);
  strokeWeight(weights[currentWeightIndex]);
  
  switch(_direction){
    case 2:
      goUp();
      break;
    
    
    case 3:
      goLeft();
      break;
      
      
    case 4:
      goRight();
      break;
      
      
    case 5:
      goDown();
      break;
  }
  
  lastDirection = _direction;
  currentDrawStep++;
}

void goLeft(){
  if (lastX > LINE_LENGTH && lastDirection != 1) {
    line(lastX, lastY, lastX - LINE_LENGTH, lastY);
    lastPosition.setX(lastX - LINE_LENGTH);
  }
}

void goRight(){
  if (lastX < (SCREEN_WIDTH - LINE_LENGTH) && lastDirection != 3){
    line(lastX, lastY, lastX + LINE_LENGTH, lastY);
    lastPosition.setX(lastX + LINE_LENGTH);
  }
}

void goUp(){
 if (lastY > LINE_LENGTH && lastDirection != 2) {
    line(lastX, lastY, lastX, lastY - LINE_LENGTH);
    lastPosition.setY(lastY - LINE_LENGTH);
 }    
}

void goDown(){
 if (lastY < (SCREEN_HEIGHT - LINE_LENGTH) && lastDirection != 0) {
    line(lastX, lastY, lastX, lastY + LINE_LENGTH);
    lastPosition.setY(lastY + LINE_LENGTH);
  } 
}


/*Classes
*/

class Point{
  private int _ypos, _xpos;
  private Point nextPoint;
  
  //Constructor
  Point(int xpos, int ypos){
    this._xpos = xpos;
    this._ypos = ypos;
  }
  
  
  /*GETTER SETTER
  */
  
  public void setX(int value){
   _xpos = value; 
  }
  
  public void setY(int value){
   _ypos = value;
  }
  
  public int getX(){
   return _xpos; 
  }
  
  public int getY(){
   return _ypos; 
  }

}
