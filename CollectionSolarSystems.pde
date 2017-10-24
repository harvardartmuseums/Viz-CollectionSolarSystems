import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;
import java.net.*;
import java.awt.event.KeyEvent;
import java.text.*;
import java.util.Locale;

PeasyCam cam;

PFont font;

boolean recording = false;
boolean showMouse = false;
boolean focusMode = false;
boolean showHUD = true;
boolean nightMode = false;

String baseURL = "https://api.harvardartmuseums.org/object";
String apiKey = "[YOUR-APIKEY-HERE]";
String[][] multiverse = {
            {"classification.exact", "century"}, 
            {"gallery.gallerynumber", "classification.exact"}, 
            {"century", "classification.exact"},
            {"division", "century"}
          };

SolarSystem[] solarSystems;

int universePopulation = 0;
int currentUniverse = 0;
int currentSystem = -1;

void setup() {
  fullScreen(P3D, 2);
  
  smooth();

  font = createFont("Arial", 100);
  textFont(font, 200);

  createUniverse();
  
  cam = new PeasyCam(this, 200);
}

void draw() {
  if (showMouse) {
    cursor();
  } else {
    noCursor();
  }
    
  //the default text size unless specified before calling text()
  textSize(200);
  perspective(PI/3.0, (float) width/height, 1, 1000000);
  if (nightMode) {
    background(#000000);
  } else {
    background(#ffffff);
  }
  
  if (focusMode && (currentSystem > -1)) {
    solarSystems[currentSystem].render(true);
  } else {
    for(int i=0; i<solarSystems.length; i++) {
      solarSystems[i].render(i==currentSystem);
    }
  }
  
  if (showHUD) {
    cam.beginHUD();
    fill(120);
    if (currentSystem > -1) {
      textSize(16);
      String planetList = "Planets: " + "\n";
      for (int i=0; i<solarSystems[currentSystem].planets.length; i++) {
        planetList += solarSystems[currentSystem].planets[i].name + ": " + NumberFormat.getNumberInstance(Locale.US).format(solarSystems[currentSystem].planets[i].population) + "\n";
      }
      
      text("Universe Population: " + NumberFormat.getNumberInstance(Locale.US).format(universePopulation) + "\n" +  
            "Total Systems: " + NumberFormat.getNumberInstance(Locale.US).format(solarSystems.length) + "\n\n" +
            "System: " + solarSystems[currentSystem].name + "\n" + 
            "Total Population: " + NumberFormat.getNumberInstance(Locale.US).format(solarSystems[currentSystem].population) + "\n" +
            "Total Planets: " + solarSystems[currentSystem].planets.length + "\n\n" + 
            planetList, 10, 20);
    }  
    cam.endHUD();
  }
  
  if (recording) {
    saveFrame("output/frames####.png");
  }  
}

void createUniverse() {
  currentSystem = -1;
  solarSystems = loadData();
  arrangeUniverse(solarSystems);
}

void arrangeUniverse(SolarSystem[] _solarSystems) {  
  for(int i=0; i<_solarSystems.length; i++) {
//    _solarSystems[i].setLocation(new PVector(0, 0, i*1000));
    _solarSystems[i].setLocation(new PVector(random(-25000,25000), random(-25000,25000),  random(-25000,25000)));
  }
}

void lookAtSystem(SolarSystem _solarSystem) {
  cam.lookAt(_solarSystem.location.x, _solarSystem.location.y, _solarSystem.location.z, 4000, 1000);
}