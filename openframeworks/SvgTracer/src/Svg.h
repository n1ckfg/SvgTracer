#pragma once
#include "ofMain.h"
#include "SvgPath.h"

class Svg : public ofBaseApp {
  
    public:
        Svg();
    
        void drawPaths();
        string[] writePaths();
        void saveSvg();
        void saveSvg(string fileName);
        void addPath(ofVec3f[] p);
        void addPath(ArrayList<ofVec3f> p);
        void addPath(ofVec3f[] p, color fc, color sc, float sw);
        void addPath(ArrayList<ofVec3f> p, color fc, color sc, float sw);
        void refine();
        string writeHeader();
        string writeFooter();

        ArrayList<SvgPath> paths;

};
