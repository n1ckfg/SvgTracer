class Svg {
  
  String r = "\r";
  String t = "\t";

color bgColor = color(0);
color fillColor = color(150);
color strokeColor = color(150, 0, 0);
int strkwidth = 2;

int numPathReps = 100;
int numCurveReps = 30;
boolean isClosed = true;

void setup() {
  size(sW, sH);
  smooth();
  doSvg();
}

void draw() {
  background(bgColor);
  if (svgExists) {
    shape(shp, 0, 0);
  }
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void keyPressed() {

}

void doSvg() {
  makeSvg(fillColor, strokeColor, strkwidth, alphaNum, numPathReps, numCurveReps, isClosed);
}

void makeSvg(color _fc, color _sc, int _sw, float _an, int _npr, int _ncr, boolean _cl) {
  fillColor = color(random(255), random(255), random(255));
  strokeColor = color(random(255), random(255), random(255));
  strkwidth = int(random(1, 10));
  beginSvg();
  for (int i=0;i<_npr;i++) {
    pathSvg(_fc, _sc, _sw, _an, _ncr, _cl);
  }
  cSvg();
}

void beginSvg() {
  data = new Data();
  data.beginSave();
  data.add("<?xml version=\"1.0\" encoding=\"utf-8\"?>" + r);
  data.add("<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">" + r);
  data.add("<svg version=\"1.1\" id=\"Layer_1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" x=\"0px\" y=\"0px\"" + r);
  data.add(t + "width=\"" + sW + "px\" height=\"" + sH + "px\" viewBox=\"0 0 " + sW + " " + sH + "\" enable-background=\"new 0 0 " + sW + " " + sH +"\" xml:space=\"preserve\">" + r);
}

void pathSvg(color _fc, color _sc, int _sw, float _an, int _ncr, boolean _cl) {
  data.add("<path fill=\""+ rgbToHex(_fc) + "\" stroke=\""+ rgbToHex(_sc) + "\" stroke-width=\"" + _sw + "\" fill-opacity=\"" + _an + "\" stroke-opacity=\"" + _an + "\" d=\"");
  String q = pathGenerator(_ncr, _cl);
  println(q);
  data.add(q);
  data.add("\"/>");
}

void cSvg() {
  data.add("</svg>" + r);
  data.endSave("foo.svg");
}

String rgbToHex(color c) {
  return "#" + hex(c, 6);
}

float rounder(float _val, float _places) {
  _val *= pow(10, _places);
  _val = round(_val);
  _val /= pow(10, _places);
  return _val;
}
    
}

class SvgPath {
  
  SvgPath() {
  }
  
}