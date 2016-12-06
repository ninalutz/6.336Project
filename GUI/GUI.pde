import controlP5.*;
ControlP5 cp5;

int sliderValue = 100;
int sliderTicks1 = 100;
int sliderTicks2 = 30;
Slider abc;


void setup(){
  size(1200, 800);
  cp5 = new ControlP5(this);
initSliders();
}


void draw(){
String time = "11:00";
background(background);

//Title and names
fill(accentwhite);
textAlign(CENTER);
textSize(20);
//text("Traffic Modeling by Income Bracket in Cambridge Area", width/2, 30);
textSize(14);
//text("DeJuan M Anderson, Shi Kai Chong, Nina Lutz", width/2, 55);

//UI mockup
//k 1, 2, 3, 4 slider
//t slider //AM PM toggles
//incomes to show //steady state

//Map holder
rect(100, 200, 1000, 500);

//text(int(cp5.getController("t").getValue()), 50, 50);

//autoplay/pause      time:
rect(100, 710, 500, 20);
text("Time: " + time, 1050, 725);

smooth();
}
