public class SolarSystem {
  String name;
  float size;
  int population;
  Planet[] planets;
  
  int colorScheme = 0;
  
  PVector location;
  
  //The space between the sun and the first planet
  private int PLANET_BUFFER = 100;
  private float seedDiameter = 0;
  
  public SolarSystem(String _name, float _size, int _population) {
    name = _name;
    size = _size;
    population = _population;
    location = new PVector(0, 0, 0);    
    planets = new Planet[0];
    
    seedDiameter = size;
  }
 
  public void addPlanet(Planet _planet) {
    planets = (Planet[]) append(planets, _planet);
    
    int orbit = (int) seedDiameter + (5 * (int) _planet.size);
    planets[planets.length-1].setOrbit(orbit);
    
    seedDiameter = orbit;
  }
  
  public void setLocation(PVector _location) {
    this.location = _location;
    
    for (int i=0; i<planets.length; i++) {      
      planets[i].setLocation(_location);
    }
  }
 
  public void setColorScheme() {
    if (colorScheme == 0) {
      colorScheme = 255;
    } else {
      colorScheme = 0;  
    }
  }
 
  public void update() {
    location.x +=1;
    location.y +=1;
    location.z +=1;
  }
 
  public void render() {
   this.render(false);
  } 
 
  public void render(boolean showPlanetDetails) {    
    //The center position is off for some reason????
    pushMatrix();
    translate(location.x, location.y, location.z);
    
    //the core/sun
    noStroke();
    fill(220, 220, 100);
    ellipse(0, 0, this.size, this.size); 

    //the name label
    stroke(colorScheme);
    line(0, 0, 0, 50, 50, 50);
    fill(colorScheme);
    text(this.name, 50, 50, 50);

    for (int i=0; i<planets.length; i++) {
      planets[i].updateOrbit();
      planets[i].render(showPlanetDetails);
    }

    popMatrix();     
  } 
}