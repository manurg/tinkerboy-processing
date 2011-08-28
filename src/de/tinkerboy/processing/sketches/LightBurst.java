/**
 * LightBurst
 * Manuel Rodriguez | tinkerboy.de
 * version 0.1
 * 
 * Draws a lightburst
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


package de.tinkerboy.processing.sketches;

import processing.core.PApplet;

public class LightBurst extends PApplet {
	
	//start app in presentation mode
	public static void main(String args[]) {
	    PApplet.main(new String[] { "--present", "LightBurst" });
	  }
	
	//setup
	private static final int NUM_EXPLOSIONS = 15; //how many explosions
	private static final int LIGHT_STROKES_MAX = 35; //how many light strokes / explosion
	private static final int LIGHT_STROKE_SIZE_MAX = 10; //max size for strokes
	private static final int LIGHT_STROKES_MIN = 5;  //min size for stroke
	private static final int LIGHT_COLOR = 0x0500F2FF; //color of explosion
	
	private static final int EXPLOSION_SIZE_MAX = 500;
	private static final int EXPLOSION_SIZE_MIN = 50;
	private static final int IMAGE_SIZE_WIDTH = 1024;
	private static final int IMAGE_SIZE_HEIGHT = 768;
	
	
	//variables
	float counter = 0;
	
	public void setup() {
		background(0);
		size(IMAGE_SIZE_WIDTH, IMAGE_SIZE_HEIGHT, P2D);
		stroke(LIGHT_COLOR);
		frameRate(30);
	}
	
	public void draw() {
		if (counter >= NUM_EXPLOSIONS) return;
		
		float numLeaves = random(LIGHT_STROKES_MAX - LIGHT_STROKES_MIN) + LIGHT_STROKES_MIN;
		for (int i = 0; i < numLeaves; i++) {
			drawLightStroke(IMAGE_SIZE_WIDTH / 2, IMAGE_SIZE_HEIGHT / 2, random(EXPLOSION_SIZE_MAX - EXPLOSION_SIZE_MIN) + EXPLOSION_SIZE_MIN, random(360), random(LIGHT_STROKE_SIZE_MAX));
		}
		
		counter++;
	}
	
	private void drawLightStroke(float x, float y, float radius, float startDegree, float size) {
		for (float i = startDegree; i <= startDegree + size; i+=0.1) {
			float currentX = getXOnEllipse(x, radius, i);
			float currentY = getYOnEllipse(y, radius, i);
			
			float nextDegree = i;
			nextDegree += 0.1;
			
			float nextX = getXOnEllipse(x, radius, nextDegree);
			float nextY = getYOnEllipse(y, radius, nextDegree);
			
			line(x, y, currentX, currentY);
			line(currentX, currentY, nextX, nextY);
			line(nextX, nextY, x, y);
		}
	}
	
	private float getXOnEllipse(float centerX, float radius, float degree) {
		return centerX + (radius * cos(radians(degree)));
	}
	
	private float getYOnEllipse(float centerY, float radius, float degree) {
		return centerY + (radius * sin(radians(degree)));
	}
}
