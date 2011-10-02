package com.hardcorepawn;

import processing.core.*;
import processing.opengl.*;
import javax.media.opengl.*;
import java.nio.*;

/**
 * This class allows you to create a large number of points in OPENGL mode in processing.
 * 
 * @author JohnG
 *
 */
public class SuperPoint {
	private GL gl;
	private PApplet p;
	
	private FloatBuffer v;
	private FloatBuffer c;
	
	private float[] points;
	private int numPoints;
	private float[] cols;
	//private int numCols;
	
	private boolean updated;
	
	/**
	 * Create a new SuperPoint object like:
	 * 
	 * <pre>SuperPoint p;
	 * void setup()
	 * {
	 *   //size etc...
	 *   p=new SuperPoint(this);
	 * }</pre>
	 * @param p
	 */
	public SuperPoint(PApplet p)
	{
		if(!(p.g instanceof PGraphicsOpenGL))
		{
			throw new RuntimeException("This library requires OpenGL");
		}
		this.p=p;
		//p.registerDraw(this);
		updated=false;
		points=new float[30000];
		numPoints=0;
		cols=new float[40000];
	}
	
	/*public void addPoint(float x, float y, float z)
	{
		if(coloured)
		{
			addPoint(x,y,z,1,1,1,1);
			return;
		}
		updated=true;
		if(numPoints==points.length/3)
		{
			int len=points.length;
			len*=2;
			float[] tmp=new float[len];
			System.arraycopy(points, 0, tmp, 0, points.length);
			points=null;
			points=tmp;
		}
		points[numPoints*3]=x;
		points[numPoints*3+1]=y;
		points[numPoints*3+2]=z;
		numPoints+=3;
	}*/
	
	/**
	 * Add a new point to the list.
	 * The red/green/blue/alpha values should be between 0 and 1, not 0 and 255.
	 */
	public void addPoint(float x, float y, float z, float r, float g, float b, float a)
	{
		updated=true;
		if((numPoints+1)==points.length/3)
		{
			int len=points.length;
			len*=2;
			float[] tmp=new float[len];
			System.arraycopy(points, 0, tmp, 0, points.length);
			points=null;
			points=tmp;
			
			len=cols.length;
			len*=2;
			tmp=new float[len];
			System.arraycopy(cols, 0, tmp, 0, cols.length);
			cols=null;
			cols=tmp;
		}
		points[numPoints*3]=x;
		points[numPoints*3+1]=y;
		points[numPoints*3+2]=z;
		cols[numPoints*4]=r;
		cols[numPoints*4+1]=g;
		cols[numPoints*4+2]=b;
		cols[numPoints*4+3]=a;
		numPoints++;
	}
	
	/**
	 * Draws the points. Do not call beginGL() before calling this.
	 * 
	 * You may want to use:
	 * 
	 * ((PGraphicsOpenGL)g).gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE);
	 * 
	 * and/or
	 * 
	 * ((PGraphicsOpenGL)g).gl.glDisable(GL.GL_DEPTH_TEST);
	 * 
	 * before calling this to get the points to blend properly.
	 * 
	 * @param size - the size of the points. Note some OpenGL implementations don't support large sizes.
	 */
	public void draw(float size)
	{
		if(updated)
		{
			//System.out.println("updating vert buffers");
			//System.out.println("Number of points "+numPoints);
			v=ByteBuffer.allocateDirect(4*3*numPoints).order(ByteOrder.nativeOrder()).asFloatBuffer();
			v.put(points, 0, 3*numPoints);
			v.rewind();
			//System.out.println("updating col buffers");
			if(c!=null)
				c.clear();
			c=ByteBuffer.allocateDirect(4*4*numPoints).order(ByteOrder.nativeOrder()).asFloatBuffer();
			c.put(cols, 0, 4*numPoints);
			c.rewind();
			updated=false;
		}
		//System.out.println("Drawing...");
		gl=((PGraphicsOpenGL)p.g).beginGL();
		gl.glEnable(GL.GL_POINT_SMOOTH);
		gl.glPointSize(size);
		gl.glEnableClientState(GL.GL_VERTEX_ARRAY);
		gl.glEnableClientState(GL.GL_COLOR_ARRAY);
		gl.glVertexPointer(3,GL.GL_FLOAT,0,v);
		gl.glColorPointer(4,GL.GL_FLOAT,0,c);
		gl.glDrawArrays(GL.GL_POINTS,0,numPoints);  
		gl.glDisableClientState(GL.GL_COLOR_ARRAY);
		gl.glDisableClientState(GL.GL_VERTEX_ARRAY);
		((PGraphicsOpenGL)p.g).endGL();
	}
}