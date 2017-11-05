class Svg {
  
  ArrayList<SvgPath> paths;
  
  Svg() {
    paths = new ArrayList<SvgPath>();
  }
  
  void drawPaths() {
    for (int i=0; i<paths.size(); i++) {
      paths.get(i).drawPath();
    }
  }
  
  String[] writePaths() {
    ArrayList<String> returnList = new ArrayList<String>();
    returnList.add(writeHeader());
    for (int i=0; i<paths.size(); i++) {
      returnList.add(paths.get(i).writePath());
    }
    returnList.add(writeFooter());
    return returnList.toArray(new String[returnList.size()]);
  }
  
  void saveSvg() {
    String fileName = "output.svg";
    saveStrings(fileName, writePaths());
    println("Saved " + fileName);
  }
  
  void saveSvg(String fileName) {
    saveStrings(fileName, writePaths());
    println("Saved " + fileName);
  }
  
  void addPath(PVector[] p) {
    paths.add(new SvgPath(p));
  }
  
  void addPath(ArrayList<PVector> p) {
    paths.add(new SvgPath(p));
  }
  
  void addPath(PVector[] p, color fc, color sc, float sw) {
    SvgPath sp = new SvgPath(p);
    sp.fillColor = fc;
    sp.strokeColor = sc;
    sp.strokeWidth = sw;
    paths.add(sp);
  }
  
  void addPath(ArrayList<PVector> p, color fc, color sc, float sw) {
    SvgPath sp = new SvgPath(p);
    sp.fillColor = fc;
    sp.strokeColor = sc;
    sp.strokeWidth = sw;
    paths.add(sp);  
  }
  
  String writeHeader() {
    String returns = "";
    returns += "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + "\n";
    returns += "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">" + "\n";
    returns += "<svg version=\"1.1\" id=\"Layer_1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" x=\"0px\" y=\"0px\"" + "\n";
    returns += "\t" + "width=\"" + width + "px\" height=\"" + height + "px\" viewBox=\"0 0 " + width + " " + height + "\" enable-background=\"new 0 0 " + width + " " + height +"\" xml:space=\"preserve\">" + "\n";
    return returns;
  }
  
  String writeFooter() {
    String returns = "";
    returns += "\n" + "</svg>" + "\n";
    return returns;
  }
    
}

class SvgPath {
  
  ArrayList<PVector> points;
  color fillColor;
  color strokeColor;
  float strokeWidth;
  boolean closed;
  
  void init() {
    points = new ArrayList<PVector>();
    fillColor = color(255);
    strokeColor = color(0);
    strokeWidth = 2;
    closed = false;
  }
  
  SvgPath() {
    init();
  }
  
  SvgPath(PVector[] p) {
    init();
    addPoints(p);
  }
  
  SvgPath(ArrayList<PVector> p) {
    init();
    addPoints(p);
  }
  
  void addPoints(PVector[] p) {
    for (int i=0; i<p.length; i++) {
      points.add(p[i]);
    }
  }
  
  void addPoints(ArrayList<PVector> p) {
    for (int i=0; i<p.size(); i++) {
      points.add(p.get(i));
    }
  }  
  
  String rgbToHex(color c) {
    return "#" + hex(c, 6);
  }
  
  float normAlpha(color c) {
    float a = alpha(c);
    return a/255.0;
  }
  
  void drawPath() {
    stroke(strokeColor);
    strokeWeight(strokeWidth);
    fill(fillColor);
    beginShape();
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      vertex(p.x, p.y);
    }
    endShape();
  }
  
  String writePath() {
    // https://developer.mozilla.org/en-US/docs/Web/SVG/Element/path
    String returns = "<path stroke=\""+ rgbToHex(strokeColor) + "\" fill=\""+ rgbToHex(fillColor) + "\" stroke-width=\"" + strokeWidth + "\" stroke-opacity=\"" + normAlpha(strokeColor) + "\" fill-opacity=\"" + normAlpha(fillColor) + "\" d=\"";
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      if (i == 0) {
          returns += "M" + p.x + " " + p.y + " ";
      } else if (i > 0 && i < points.size()-1) {
          returns += "L" + p.x + " " + p.y + " ";
      } else if (i == points.size()-1) {
        if (closed) {
          returns += "L" + p.x + " " + p.y + " z";
        } else {
          returns += "L" + p.x + " " + p.y;
        }
      }
    }
    returns += "\"/>";
    return returns;
  }

}