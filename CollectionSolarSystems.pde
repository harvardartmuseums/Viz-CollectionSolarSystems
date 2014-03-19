//reference: http://www.openprocessing.org/sketch/65139#

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

import processing.opengl.*;
import javax.media.opengl.*;

PGraphicsOpenGL pgl;
GL gl;

PeasyCam cam;

PFont font;

final int UNIVERSE_DIAMETER = 1470;

int diameterOfTheCenterofTheUniverse = UNIVERSE_DIAMETER;
int systemCount = 0;
int skyColor = 255;
int labelColor = 0;
int ringColor = 0;
Boolean showHUD = false;
Boolean showRingLabels = false;
Boolean showPlanetLabels = false;
Boolean showRings = false;
Boolean showPlanets = false;
Boolean showTheCenterOfTheUniverse = false;
Boolean showAsStack = true;
Boolean playOrbit = false;
Boolean nightMode = false;

void setup() {
  size(screen.width, screen.height, OPENGL);
  
  smooth();

  font = createFont("Arial", 28);
  textFont(font, 28);

  cam = new PeasyCam(this, 200);
}

void draw() {  
  //include some additive blending
  //see http://www.flight404.com/blog/?p=71
  pgl = (PGraphicsOpenGL) g;
  gl = pgl.gl;
  
  pgl.beginGL();

  // This fixes the overlap issue
  gl.glDisable(GL.GL_DEPTH_TEST);
  
  // Turn on the blend mode
  gl.glEnable(GL.GL_BLEND);
  
  // Define the blend mode
  if (nightMode) {
    skyColor = 0;
    labelColor = 255;
    gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE);
  } else {
    skyColor = 255;
    labelColor = 0;
  }
  
  pgl.endGL();
  
  background(skyColor);
  
    // The center of the universe (aka the entire collection)
  pushMatrix();
  translate(0, 0, -300);
  noStroke();
  fill(255, 255, 0);
  ellipse(0, 0, diameterOfTheCenterofTheUniverse, diameterOfTheCenterofTheUniverse); 
  if (showPlanetLabels) {
    stroke(labelColor);
    line(0, 0, 0, 50, 50, 50);
    fill(labelColor);
    text("All that is, was, and will be", 50, 50, 50);
  }  
  popMatrix();
  
  
  int x;
  int z;
  if (showAsStack) {
    z = 300;
    x = 0;
  } else {
    z = 0;
    x = 2000;
  }
  for (int i=0; i<systemCount; i++) {
    drawSystem(new PVector(i*x, 0, i*z), planets[i], diameters[i], names[i], labels[i]);
  }
  

  
  if (showHUD) {
    cam.beginHUD();
    fill(255);
    text("The universe organized by classification", 10, height-15);  
    cam.endHUD();
  }
}

void drawSystem(PVector origin_, int[] rings_, int d_, String name_, String[] labels_) {
  int diameter = d_;
  
  pushMatrix();
  translate(origin_.x, origin_.y, origin_.z);
  
    //the core/sun
  noStroke();
  fill(220, 220, 100);
  ellipse(0, 0, diameter, diameter); 
  if (showPlanetLabels) {
    stroke(labelColor);
    line(0, 0, 0, 50, 50, 50);
    fill(labelColor);
    text(name_, 50, 50, 50);
  }  
  
  int seedDiameter = diameter;
  int ringSpacing = 10; //change this to widen the gap between rings; especially where there are longs of rings with a narrow thickness
  //the rings
  for (int i=0; i<rings_.length; i++) {
    int c = 200/rings_.length;
    int d = seedDiameter + (ringSpacing * rings_[i]);
    int r = d/2;

    //the ring
    if (showRings) {
      noFill();
      stroke(20+i*c);
      ellipse(0, 0, d, d);
    }
    
    //the planet on the ring
    if (showPlanets) {
      
      float x = 0.0f;
      float y = 0.0f;
      
      if (playOrbit) {
        x = cos(radians(frameCount*.05)+rings_[i]) * r;
        y = sin(radians(frameCount*.05)+rings_[i]) * r;    
      } else {
        x = cos(rings_[i]) * r;
        y = sin(rings_[i]) * r;
      }
      
      noStroke();
      fill(20+i*c);
      ellipse(x, y, rings_[i], rings_[i]);

      if (showRingLabels) {
        stroke(labelColor);
        line(x, y, 0, x+50, y+50, 50);
        text(labels_[i], x+50, y+50, 50);
      }
    }
    
    seedDiameter = d;    
  }
  
  popMatrix();
}

void updateDiameterOfTheCenterOfTheUniverse() {
  diameterOfTheCenterofTheUniverse = UNIVERSE_DIAMETER;
  for (int i=0; i<systemCount; i++) {  
    diameterOfTheCenterofTheUniverse-=diameters[i];
  }
}

//See http://studio.sketchpad.cc/sp/pad/view/ro.9gL97JYgiuy3$/rev.176
void ring(float radB, float radS, float offsetX, float offsetY) {
    beginShape(QUAD_STRIP);
    int precision = (int)ceil(TWO_PI * radB / 5);
    for(int i = 0; i <= precision; i++) {
        float angleB = map(i, 0, precision, 0, TWO_PI);
        float xB = radB * cos(angleB),
              yB = radB * sin(angleB);
        float angleS = atan2(-(offsetY - yB), -(offsetX - xB));
        vertex(xB, yB);
        vertex(offsetX + radS * cos(angleS), offsetY + radS * sin(angleS));
        fill(0, 200, 0, (i/(precision*.3))*i+40);
    }
    endShape();
}


