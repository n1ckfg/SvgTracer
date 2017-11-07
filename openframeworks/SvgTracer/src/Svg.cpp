#include "Svg.h"

Svg() {
    paths = new ArrayList<SvgPath>();
}

void Svg :: drawPaths() {
    for (SvgPath path : paths) {
        path.drawPath();
    }
}

string[] Svg :: writePaths() {
    ArrayList<string> returnList = new ArrayList<string>();
    returnList.add(writeHeader());
    for (SvgPath path : paths) {
        returnList.add(path.writePath());
    }
    returnList.add(writeFooter());
    return returnList.toArray(new string[returnList.size()]);
}

void Svg :: saveSvg() {
    string fileName = "output.svg";
    savestrings(fileName, writePaths());
    println("Saved " + fileName);
}

void Svg :: saveSvg(string fileName) {
    savestrings(fileName, writePaths());
    println("Saved " + fileName);
}

void Svg :: addPath(ofVec3f[] p) {
    paths.add(new SvgPath(p));
}

void Svg :: addPath(ArrayList<ofVec3f> p) {
    paths.add(new SvgPath(p));
}

void Svg :: addPath(ofVec3f[] p, color fc, color sc, float sw) {
    SvgPath sp = new SvgPath(p);
    sp.fillColor = fc;
    sp.strokeColor = sc;
    sp.strokeWidth = sw;
    paths.add(sp);
}

void Svg :: addPath(ArrayList<ofVec3f> p, color fc, color sc, float sw) {
    SvgPath sp = new SvgPath(p);
    sp.fillColor = fc;
    sp.strokeColor = sc;
    sp.strokeWidth = sw;
    paths.add(sp);
}

void Svg :: refine() {
    for (SvgPath path : paths) {
        path.refine();
    }
}

string Svg :: writeHeader() {
    string returns = "";
    returns += "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + "\n";
    returns += "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">" + "\n";
    returns += "<svg version=\"1.1\" id=\"Layer_1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" x=\"0px\" y=\"0px\"" + "\n";
    returns += "\t" + "width=\"" + width + "px\" height=\"" + height + "px\" viewBox=\"0 0 " + width + " " + height + "\" enable-background=\"new 0 0 " + width + " " + height +"\" xml:space=\"preserve\">" + "\n";
    return returns;
}

string Svg :: writeFooter() {
    string returns = "";
    returns += "\n" + "</svg>" + "\n";
    return returns;
}


