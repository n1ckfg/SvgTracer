#pragma once
#include "ofMain.h"

class SvgPath : public ofBaseApp {
    
public:
    SvgPath();
    SvgPath(ofVec3f[] p);
    SvgPath(ArrayList<ofVec3f> p);
    
    void init();
    void addPoints(ofVec3f[] p);
    void addPoints(ArrayList<ofVec3f> p);
    string rgbToHex(color c);
    void drawPath();
    string writePath();
    void smoothStroke();
    void splitStroke();
    void refine();
    
    ArrayList<ofVec3f> points;
    color fillColor;
    color strokeColor;
    float strokeWidth;
    bool closed;
    int smoothReps = 10;
    int splitReps = 2;
    
};
