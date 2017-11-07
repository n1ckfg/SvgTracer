#include "SvgPath.h"

SvgPath() {
    init();
}

SvgPath(ofVec3f[] p) {
    init();
    addPoints(p);
}

SvgPath(ArrayList<ofVec3f> p) {
    init();
    addPoints(p);
}

void SvgPath :: init() {
    points = new ArrayList<ofVec3f>();
    fillColor = color(255);
    strokeColor = color(0);
    strokeWidth = 2;
    closed = false;
}

void SvgPath :: addPoints(ofVec3f[] p) {
    for (int i=0; i<p.length; i++) {
        points.add(p[i]);
    }
}

void SvgPath :: addPoints(ArrayList<ofVec3f> p) {
    for (ofVec3f pv : p) {
        points.add(pv);
    }
}

string SvgPath :: rgbToHex(color c) {
    return "#" + hex(c, 6);
}

float SvgPath :: normAlpha(color c) {
    float a = alpha(c);
    return a/255.0;
}

void SvgPath :: drawPath() {
    if (alpha(strokeColor)==0) {
        noStroke();
    } else {
        stroke(strokeColor);
    }
    strokeWeight(strokeWidth);
    if (alpha(fillColor)==0) {
        noFill();
    } else {
        fill(fillColor);
    }
    beginShape();
    for (ofVec3f p : points) {
        vertex(p.x, p.y);
    }
    endShape();
}

string SvgPath :: writePath() {
    // https://developer.mozilla.org/en-US/docs/Web/SVG/Element/path
    string returns = "<path stroke=\""+ rgbToHex(strokeColor) + "\" fill=\""+ rgbToHex(fillColor) + "\" stroke-width=\"" + strokeWidth + "\" stroke-opacity=\"" + normAlpha(strokeColor) + "\" fill-opacity=\"" + normAlpha(fillColor) + "\" d=\"";
    for (int i=0; i<points.size(); i++) {
        ofVec3f p = points.get(i);
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

void SvgPath :: smoothStroke() {
    float weight = 18;
    float scale = 1.0 / (weight + 2);
    int nPointsMinusTwo = points.size() - 2;
    ofVec3f lower, upper, center;
    
    for (int i = 1; i < nPointsMinusTwo; i++) {
        lower = points.get(i-1);
        center = points.get(i);
        upper = points.get(i+1);
        
        center.x = (lower.x + weight * center.x + upper.x) * scale;
        center.y = (lower.y + weight * center.y + upper.y) * scale;
    }
}

void SvgPath :: splitStroke() {
    for (int i = 1; i < points.size(); i+=2) {
        ofVec3f center = points.get(i);
        ofVec3f lower = points.get(i-1);
        float x = (center.x + lower.x) / 2;
        float y = (center.y + lower.y) / 2;
        float z = (center.z + lower.z) / 2;
        ofVec3f p = new ofVec3f(x, y, z);
        points.add(i, p);
    }
}

void SvgPath :: refine() {
    for (int i=0; i<splitReps; i++) {
        splitStroke();
        smoothStroke();
    }
    for (int i=0; i<smoothReps - splitReps; i++) {
        smoothStroke();
    }
}

