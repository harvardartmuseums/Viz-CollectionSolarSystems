/* Keyboard commands
    
    Enter - save a snapshot of the screen
    Left arrow - move the camera to the previous solar system
    Right arrow - move the camera to the next solar system
    Up arrow - 
    Down arrow - 
    A - rearrange the universe
    F - focus mode; focus on the selected system by hiding all other systems
    R - record every frame to disk
    M - show or hide the mouse
    U - cycle through the multiverse
    N - toggle day/night mode
    
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
  if (keyCode == KeyEvent.VK_N) {
    nightMode = !nightMode;
    for(int i=0; i<solarSystems.length; i++) {
      solarSystems[i].setColorScheme();
    }
  } 
  if (keyCode == KeyEvent.VK_F) {
    focusMode = !focusMode;
  }    
  if (keyCode == KeyEvent.VK_U) {
    currentUniverse+=1;
    if (currentUniverse > multiverse.length-1) currentUniverse = 0;
    createUniverse();
  }    
  if (keyCode == KeyEvent.VK_I) {
    showHUD = !showHUD;
  }    
}