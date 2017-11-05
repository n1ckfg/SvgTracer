void keyPressed() {
  if (key=='s' || key=='S') svg.saveSvg();
  if (key==' ') showImg = !showImg;
  if (keyCode==UP) doThreshold(1);

  if (keyCode==DOWN) doThreshold(-1);

  if (key=='1' || key=='2' || key=='3' || key=='4' || key=='5' || key=='6' || key=='7' || key=='8' || key=='9') {
    int val = -threshold + (20 * int(""+key));
    doThreshold(val);
  }
  
  if (key=='0') {
    int val = -threshold + 200;
    doThreshold(val);
  }
}