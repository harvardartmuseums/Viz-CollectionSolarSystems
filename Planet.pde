public class Planet {
  String name;
  float size;
  int radius;
  int diameter;
  int position;
  int population;
  
  float x = 0.0f;
  float y = 0.0f;
  
  public Planet(String _name, float _size, int _population, int _position) {
    name = _name;
    size = _size;
    radius = 0;
    diameter = 0;
    position = _position;
    population = _population;
  }
    
  public void setOrbit(int _radius) {
    radius = _radius;
    diameter = radius*2;
  }
  
  public void updateOrbit() {
    x = cos(radians(frameCount*.05)+this.size) * this.radius;
    y = sin(radians(frameCount*.05)+this.size) * this.radius;      
  }
  
  public void render() {
    this.render(false);
  } 
  
  public void render(boolean showLabel) {
    //the planet path
    noFill();
    stroke(20+(2.5*position));
    ellipse(0, 0, this.diameter, this.diameter);

    //the planet
    noStroke();
    fill(20+(2.5*position));
    ellipse(x, y, this.size, this.size);
  
    //the planet label
    if (showLabel) {
      stroke(20+(2.5*position));
      line(x, y, 0, x+50, y+50, 50);
      fill(20+(2.5*position));
      textSize(150);
      text(this.name, x+50, y+50, 50);   
    }
  }
}
