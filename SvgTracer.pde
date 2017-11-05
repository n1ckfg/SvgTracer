Svg svg;

void setup() {
  size(960, 540, P2D);
  svg = new Svg();
  PVector[] p = { new PVector(width/2, height/2), new PVector(1,-440), new PVector(0,4), new PVector(0,0) };
  svg.addPath(p);
}

void draw() {
  background(127);
  svg.drawPaths();
}

void keyPressed() {
  svg.saveSvg();
}