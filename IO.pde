void keyPressed() {
  if (keyCode == KeyEvent.VK_H) {
    showHUD = !showHUD;
  }
  if (keyCode == KeyEvent.VK_E) {
    showRingLabels = !showRingLabels;
  }
  if (keyCode == KeyEvent.VK_L) {
    showPlanetLabels = !showPlanetLabels;
  } 
  if (keyCode == KeyEvent.VK_R) {
    showRings = !showRings;
  }
  if (keyCode == KeyEvent.VK_P) {
    showPlanets = !showPlanets;
  }
  if (keyCode == KeyEvent.VK_UP) {
    systemCount+=1;
    if (systemCount > planets.length) systemCount = planets.length;
    updateDiameterOfTheCenterOfTheUniverse();
  }
  if (keyCode == KeyEvent.VK_DOWN) {
    systemCount-=1;
    if (systemCount < 0) systemCount = 0;
    updateDiameterOfTheCenterOfTheUniverse();
  }
  if (keyCode == KeyEvent.VK_D) {
    showAsStack = !showAsStack;
  }
  if (keyCode == KeyEvent.VK_O) {
    playOrbit = !playOrbit;
  }
  if (keyCode == KeyEvent.VK_ENTER) {
    saveFrame("snapshots/snapshot-####.png");
  }
}
