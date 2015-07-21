/* Keyboard commands
    
    Enter - save a snapshot of the screen
    Left arrow - move the camera to the previous solar system
    Right arrow - move the camera to the next solar system
    Up arrow - 
    Down arrow - 
    A - rearrange the universe
    R - record every frame to disk
    M - show or hide the mouse
    
*/

void keyPressed() {
  if (keyCode == KeyEvent.VK_RIGHT) {
    currentSystem+=1;
    if (currentSystem > solarSystems.length-1) currentSystem = 0;
    lookAtSystem(solarSystems[currentSystem]);
  }  
  if (keyCode == KeyEvent.VK_LEFT) {
    currentSystem-=1;
    if (currentSystem < 0) currentSystem = solarSystems.length-1;
    lookAtSystem(solarSystems[currentSystem]);
  }    
  if (keyCode == KeyEvent.VK_A) {
    arrangeUniverse(solarSystems);
  }      
  if (keyCode == KeyEvent.VK_ENTER) {
    saveFrame("snapshots/snapshot-####.png");
  }    
  if (keyCode == KeyEvent.VK_R) {
    recording = !recording;
  }  
  if (keyCode == KeyEvent.VK_M) {
    showMouse = !showMouse;
  }   
}


