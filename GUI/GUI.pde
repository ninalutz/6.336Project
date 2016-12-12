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
    Location Boston = new Location(42.365986,-71.07584);

  map.zoomAndPanTo(Boston, 16);
  
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

    stuff.drawNodes(PLACES);
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


if(Congestion.on){ 
  car9.drawRoads(Test);
  image(Test, 0, 0);
}

if(ODButton.on){
  if(AutoPlay.on == false){
  for(int i = 0; i<ODMatrix.size(); i++){
     ODMatrix.get(i).drawEdge();
  }
  rect(0, 0, width, 90);
  }
  
  if(AutoPlay.on == true){
  for(int i = 0; i<ODMatrix.size(); i++){
     ODMatrix.get(i).pauseEdge();
  }
  rect(0, 0, width, 90);
  }
}


if(CarButton.on){
  car9.drawAMCars(Cars);
  image(Cars, 0, 0);
}


if(showFrameRate){
  println(frameRate);
}


fill(background);
stroke(background);
//rect(0, 0, 100, height);
rect(0, 0, width, 90);


fill(income1color);
text("Income 1", offset + 65, 30);
fill(income2color);
text("Income 2", offset + 180-25, 30);
fill(income3color);
text("Income 3", offset + 265-20, 30);

fill(accentwhite);
text("t = " + int(cp5.getController("t").getValue()), 260 + offset, 67);


textSize(40);
text(int(cp5.getController("t").getValue()) + timing, 1200, 60);


if(AutoPlay.on == false){
  xDir = 0.5;
}

if(AutoPlay.on == true){
  xDir = 0;
}

time = int(cp5.getController("t").getValue());

smooth();
//  println(Congestion.on);
//println(frameRate);

}

void mouseDragged(){
    PLACES.clear();
    
  if(Congestion.on){
  Test.clear();
  PLACES.clear();
  car9.drawRoads(Test);
  stuff.drawNodes(PLACES);
  }
  
  
  if(CarButton.on == true){
      Cars.clear();
      car9.drawAMCars(Cars);
  }
  
  if(edges){
  if(AutoPlay.on == false){
  for(int i = 0; i<ODMatrix.size(); i++){
     ODMatrix.get(i).drawEdge();
  }
  rect(0, 0, width, 90);
  }
  
  if(AutoPlay.on == true){
  for(int i = 0; i<ODMatrix.size(); i++){
     ODMatrix.get(i).pauseEdge();
  }
  rect(0, 0, width, 90);
  }
}
  
}
