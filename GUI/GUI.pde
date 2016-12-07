int hr = 11;
int min = 15;
int sec = 56;

void setup(){
  size(1450, 850);
  cp5 = new ControlP5(this);
  initButtons();
  initSliders();

  //map = new UnfoldingMap(this, new OpenStreetMap.OpenStreetMapProvider());
  //map = new UnfoldingMap(this, new StamenMapProvider.TonerBackground());
 map = new UnfoldingMap(this, new StamenMapProvider.WaterColor());
  //map = new UnfoldingMap(this, new Microsoft.RoadProvider());
// map = new UnfoldingMap(this, new Microsoft.HybridProvider());
    Location Boston = new Location(42.359676, -71.060636);

  map.zoomAndPanTo(Boston, 17);

  MapUtils.createDefaultEventDispatcher(this, map);
  AM.on = true;

}


void draw(){
  println(AM.on);
  PM.on = !AM.on;
  AM.on = !PM.on;

background(background);

map.draw();

String timing = "PM";
if(AM.on == true){
  timing = "AM";
}

fill(background);
stroke(background);
//rect(0, 0, 100, height);
rect(0, 0, width, 90);

fill(accentwhite);
text("k = " + int(cp5.getController("k").getValue()), 260 + offset, 37);
text("t = " + int(cp5.getController("t").getValue()), 260 + offset, 67);

if(AutoPlay.on){
textSize(40);
text(int(cp5.getController("t").getValue()) + ":" + minute() + ":" + second() + timing, 1200, 60);
}

if(AutoPlay.on == false){
textSize(40);
text(int(cp5.getController("t").getValue()) + timing, 1200, 60);
}


smooth();

}
