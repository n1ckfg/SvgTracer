#include "ofApp.h"

//--------------------------------------------------------------
void ofApp :: setup() {
    size(50, 50, FX2D);
    src = loadImage("barb.png");
    surface.setSize(src.width, src.height);
    
    doThreshold(0);
}

//--------------------------------------------------------------
void ofApp :: update() {
    updateControls();
}

//--------------------------------------------------------------
void ofApp :: draw() {
    if (showImg) {
        image(dst, 0, 0);
    } else {
        background(255);
        svg.drawPaths();
    }
}

//--------------------------------------------------------------
void ofApp :: keyPressed(int key) {
    if (key=='s' || key=='S') svg.saveSvg();
    if (key==' ') showImg = !showImg;
    
    if (key=='1' || key=='2' || key=='3' || key=='4' || key=='5' || key=='6' || key=='7' || key=='8' || key=='9') {
        int val = -threshold + (20 * int(""+key));
        doThreshold(val);
    }
    
    if (key=='0') {
        int val = -threshold + 200;
        doThreshold(val);
    }
}

//--------------------------------------------------------------
void ofApp :: keyReleased(int key) {

}

//--------------------------------------------------------------
void ofApp :: mouseMoved(int x, int y ) {

}

//--------------------------------------------------------------
void ofApp :: mouseDragged(int x, int y, int button) {

}

//--------------------------------------------------------------
void ofApp :: mousePressed(int x, int y, int button) {

}

//--------------------------------------------------------------
void ofApp :: mouseReleased(int x, int y, int button) {

}

//--------------------------------------------------------------
void ofApp :: mouseEntered(int x, int y) {

}

//--------------------------------------------------------------
void ofApp :: mouseExited(int x, int y) {

}

//--------------------------------------------------------------
void ofApp :: windowResized(int w, int h) {

}

//--------------------------------------------------------------
void ofApp :: gotMessage(ofMessage msg) {

}

//--------------------------------------------------------------
void ofApp :: dragEvent(ofDragInfo dragInfo) {

}

void ofApp :: updateControls() {
    if (keyPressed) {
        if (keyCode==UP) doThreshold(1);
        if (keyCode==DOWN) doThreshold(-1);
    }
}

void ofApp :: doThreshold(int val) {
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

ArrayList<PVector> ofApp :: getContourPoints(Contour contour, float reduce) {
    contour.setPolygonApproximationFactor(reduce);
    ArrayList<PVector> returns = contour.getPolygonApproximation().getPoints();
    return returns;
}
