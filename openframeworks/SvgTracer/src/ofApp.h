#pragma once
#include "ofMain.h"
#include "ofxCv.h"
#include "ofxOpenCv.h"
#include "Svg.h"

class ofApp : public ofBaseApp {

	public:
		void setup();
		void update();
		void draw();
		void keyPressed(int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);
		void mouseEntered(int x, int y);
		void mouseExited(int x, int y);
		void windowResized(int w, int h);
		void dragEvent(ofDragInfo dragInfo);
		void gotMessage(ofMessage msg);
    
        void updateControls();
        void doThreshold(int val);
        ArrayList<PVector> getContourPoints(Contour contour, float reduce);
        
        ofImage src, dst;
        OpenCV opencv;
        ArrayList<Contour> contours;
        Svg svg;
        boolean showImg = false;
        int threshold = 80;
    
};
