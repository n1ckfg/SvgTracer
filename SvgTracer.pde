PImage img;
Svg svg;

void setup() {
  size(50, 50, P2D);
  img = loadImage("barb.png");
  surface.setSize(img.width, img.height);

  svg = new Svg();
  PVector[] p = { new PVector(width/2, height/2), new PVector(1,-440), new PVector(0,4), new PVector(0,0) };
  svg.addPath(p);
}

void draw() {
  image(img, 0, 0);
  svg.drawPaths();
}

void keyPressed() {
  svg.saveSvg();
}