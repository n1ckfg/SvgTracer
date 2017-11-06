import gab.opencv.*;

PImage src, dst;
OpenCV opencv;
ArrayList<Contour> contours;
Svg svg;
boolean showImg = false;
int threshold = 80;

void setup() {
  size(50, 50, FX2D);
  src = loadImage("barb.png");
  surface.setSize(src.width, src.height);

  doThreshold(0);
}

void draw() {
  updateControls();
  
  if (showImg) {
    image(dst, 0, 0);
  } else {
    background(255);
    svg.drawPaths();
  }
}

void doThreshold(int val) {
  threshold += val;
  threshold = constrain(threshold, 0, 255);
  
  println("threshold: " + threshold);

  svg = new Svg();

  opencv = new OpenCV(this, src);
  opencv.gray();
  opencv.invert();
  opencv.threshold(threshold);
  dst = opencv.getOutput();
  contours = opencv.findContours();

  for (Contour contour : contours) {
    ArrayList<PVector> points = getContourPoints(contour, 1);
    svg.addPath(points, color(0,0), color(0), 2);
  }
  
  opencv = new OpenCV(this, src);
  opencv.gray();
  opencv.invert();
  opencv.threshold(150);
  contours = opencv.findContours();

  for (Contour contour : contours) {
    ArrayList<PVector> points = getContourPoints(contour, 2);
    svg.addPath(points, color(0,127,255,20), color(0,127,127,20), 3);
  }
  
  svg.refine();
}

ArrayList<PVector> getContourPoints(Contour contour, float reduce) {
  contour.setPolygonApproximationFactor(reduce);
  ArrayList<PVector> returns = contour.getPolygonApproximation().getPoints();
  return returns;
}