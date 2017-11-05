import gab.opencv.*;

PImage src, dst;
OpenCV opencv;
ArrayList<Contour> contours;
Svg svg;
boolean showImg = false;
int threshold = 185;

void setup() {
  size(50, 50, P2D);
  src = loadImage("barb.png");
  surface.setSize(src.width, src.height);

  doThreshold(0);
}

void doThreshold(int val) {
  threshold += val;
  threshold = constrain(threshold, 0, 255);
  println("threshold: " + threshold);

  opencv = new OpenCV(this, src);
  opencv.gray();
  opencv.invert();
  opencv.threshold(threshold);
  dst = opencv.getOutput();
  contours = opencv.findContours();
  
  svg = new Svg();
  for (Contour contour : contours) {
    svg.addPath(contour.getPoints(), color(0), color(0,0), 1);
  }
}

void draw() {
  if (showImg) {
    image(dst, 0, 0);
  } else {
    background(255);
    svg.drawPaths();
  }
}