int hr = 11;
int min = 15;
int sec = 56;

PGraphics Test, Cars, PLACES;
Table opening, nodes, POIs, closing;
boolean thing, otherthing, needLoop;
int time;
boolean cars;

MercatorMap mercatorMap;

void setup(){
  size(1450, 850, P3D);
  cp5 = new ControlP5(this);
  initButtons();
  initSliders();
  opening = loadTable("data/Opening.csv", "header");
  nodes = loadTable("data/Simnodes_working_final.csv", "header");
  POIs = loadTable("data/POIs.csv", "header");

  //map = new UnfoldingMap(this, new OpenStreetMap.OpenStreetMapProvider());
  map = new UnfoldingMap(this, new StamenMapProvider.TonerBackground());
 //map = new UnfoldingMap(this, new StamenMapProvider.WaterColor());
  //map = new UnfoldingMap(this, new Microsoft.RoadProvider());
// map = new UnfoldingMap(this, new Microsoft.HybridProvider());
    Location Boston = new Location(42.359676, -71.060636);

  map.zoomAndPanTo(Boston, 17);
  
  Test = createGraphics(width, height);

  Cars = createGraphics(width, height);
    
  PLACES = createGraphics(width, height);
  MapUtils.createDefaultEventDispatcher(this, map);
  AM.on = true;
  
  generateOpeningRoads();
  generatePOIs();
  generateODs();
   initialTime = millis();
  

}


void draw(){
  
  am = AM.on;
  pm = PM.on;
 
//  println(edges);

  mercatorMap = new MercatorMap(width, height, CanvasBox().get(0).x, CanvasBox().get(1).x, CanvasBox().get(0).y, CanvasBox().get(1).y, 0);
    //non7.drawRoads(Test);
//  println(AM.on);
  PM.on = !AM.on;
  AM.on = !PM.on;

background(background);

map.draw();

image(Test, 0, 0);
image(PLACES, 0, 0);




  //resets initial time apporpriately after one iteration and delay
  if(needLoop){
    initialTime += duration;
    initialTime += delay;
    needLoop = !needLoop;
  }
  

String timing = "PM";
if(AM.on == true){
  timing = "AM";
}
if(edges){
  for(int i = 0; i<ODMatrix.size(); i++){
     ODMatrix.get(i).drawEdge();
  }
  rect(0, 0, width, 90);

}

if(cars){
  non9.drawAMCars(Cars);
  image(Cars, 0, 0);
}

if(lines){
  non9.drawRoads(Test);
}

if(showFrameRate){
  println(frameRate);
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

time = int(cp5.getController("t").getValue());

smooth();
//println(frameRate);

}

void mouseDragged(){
  if(lines){
  Test.clear();
  PLACES.clear();
  non9.drawRoads(Test);
  stuff.drawNodes(PLACES);
  edges = false;
  }
  
  if(cars){
      Cars.clear();
      non9.drawAMCars(Cars);
      
  }
  
}
