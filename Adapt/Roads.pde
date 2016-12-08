PGraphics Canvas, Handler, Selection;

import java.util.Set;
import java.util.HashSet;


public class Road{
  public String name, kind;
  public int OSMid, cars, startnum, endnum;
  public PVector start, end, org, dest;
  public ArrayList<PVector>Brez = new ArrayList<PVector>();
  public ArrayList<PVector>SnapGrid = new ArrayList<PVector>();
  public float dx, dy, Steps, xInc, yInc, inc, x1, x2, y1, y2, x, y, len;
  
  Road(PVector _start, PVector _end, int _id, int _speed, float _len, int _cars, int _startnum, int _endnum){
    start = _start;
    startnum = _startnum;
    endnum = _endnum;
    end = _end;
    OSMid = _id;
    cars = _cars;
    len = _len;
    speed = _speed;
  }
  
  public void bresenham(){
//      println("running brez");
      int inc = 1;
      PVector starting = mercatorMap.getScreenLocation(new PVector(start.x, start.y));
      PVector ending = mercatorMap.getScreenLocation(new PVector(end.x, end.y));
      
        x1 = starting.x;
        x2 = ending.x;
        y1 = starting.y;
        y2 = ending.y;
        
        org = new PVector(x1, y1);
        dest = new PVector(x2, y2);
        
        
     //these are what will be rendered between the start and end points, initialize at start
        x = org.x;
        y = org.y;
        
        //calculating the change in x and y across the line
        dx = abs(dest.x - org.x);
        dy = abs(dest.y - org.y);
        
        //number of steps needed, based on what change is biggest
        //depending on your need for accuracy, you can adjust this, the smaller the Steps number, the fewer points rendered
        if(dx > dy){
          Steps = dx/1.75;
        }
        else{
          Steps = dy/1.75;        
        }
        
         //x and y increments for the points in the line      
        float xInc = (dx)/(Steps);
        float yInc = (dy)/(Steps);
        
        //this is the code to render vertical and horizontal lines, which need to be handled differently at different resolution for my implementation
                if(x1 == x2 || y1 == y2){
                       if (y2 < y1 || x2 < x1) {
                          org = new PVector(x2, y2);
                          dest = new PVector(x1, y1);
                        }
            
                        else{
                          org = new PVector(x1, y1);
                          dest = new PVector(x2, y2);
                        }
        
                        //slopes of the lines
                        dx = abs(dest.x - org.x);
                        dy = abs(dest.y - org.y);
                      
                        //steps needed to render the lines
                        if (dx > dy) {
                          Steps = dx*inc;
                        } else {
                          Steps = dy*inc;
                        }
                      
                        //increments for the points on the line 
                         xInc =  dx/(Steps);
                         yInc = dy/(Steps);
                      
                        //sets a starting point
                        x = org.x;
                        y = org.y;  
                 }
                 
          for(int v = 0; v< (int)Steps; v++){       
                //there are four main cases that need to be handled
                      if(dest.x < org.x && dest.y < org.y){
                           x = x - xInc;    y = y - yInc;
                                }
                      else if(dest.y < org.y){
                           x = x + xInc;    y = y - yInc;
                                }  
                      else if(dest.x < org.x){
                           x = x - xInc;    y = y + yInc;
                                }
                      else{ 
                           x = x + xInc;    y = y + yInc;
                             }
  
                        if(x <= max(x1, x2) && y<= max(y1, y2) && x >= min(x1, x2) && y >= min(y1, y2) 
                        && x >= 0 && x <= width && y >= 0 && y<= height){
                            PVector coord = mercatorMap.getGeo(new PVector(int(x), int(y), 0));
                            //Brez.add(new PVector(int(x), int(y), 0));
//                            if(v%4 == 0){
                            Brez.add(coord);
                            //}
                        }
              }
            HashSet set = new HashSet(Brez);
            Brez.clear();
            Brez.addAll(set);
        
}
 
}

public class RoadNetwork{
  public ArrayList<Road>Roads = new ArrayList<Road>();
  public ArrayList<PVector>SimulationNodes = new ArrayList<PVector>();
  public int size, capacity, normcap;
  public String name;
  public bbox bounds;
  
  RoadNetwork(String _name, bbox _Bounds){
      name = _name;
      bounds = _Bounds;
      size = Roads.size();
  }
  
   void GenerateNetwork(int genratio){
     
     Roads.clear();
     int a = 1;
      
      JSONArray input = loadJSONArray("data/plz.json");
      
      for(int m = 0; m<genratio; m++){
        try{
          JSONObject JSONM = input.getJSONObject(m); 
          JSONObject JSON = JSONM.getJSONObject("roads");
          JSONArray JSONlines = JSON.getJSONArray("features");
//              try{
                for(int i=0; i<JSONlines.size(); i++) {
                  String type = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("geometry").getString("type");
                  int OSMid = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("properties").getInt("id");
                  String kind = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("properties").getString("kind");
                if(type.equals("LineString")){
                 JSONArray linestring = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("geometry").getJSONArray("coordinates");
                   for(int j = 0; j<linestring.size(); j++){
                     if(j<linestring.size()-1){
                        PVector start = new PVector(linestring.getJSONArray(j).getFloat(1), linestring.getJSONArray(j).getFloat(0));
                        PVector end = new PVector(linestring.getJSONArray(j+1).getFloat(1), linestring.getJSONArray(j+1).getFloat(0));
                        if(bounds.inbbox(start) == true || bounds.inbbox(end) == true){ 
                        float len = mercatorMap.Haversine(start, end);
                        if(kind.equals("path") == false && kind.equals("rail") == false){
                            if(int(len/7.5) == 0){
                              len = 7.5;
                               }
                        Road road = new Road(start, end, OSMid, 45, len, int(len/7.5), 0, 0);
                        a+=1;
//                        if(start.x > 42.36596 && start.x < 42.372135 && start.y < -71.06496 && start.y > -71.07805
//                        && end.x > 42.36596 && end.x < 42.372135 && end.y < -71.06496 && end.y > -71.07805
//                        ){
//                        println("sup");
//                          }
//                        else{
                        Roads.add(road);
                        SimulationNodes.add(start);
                        SimulationNodes.add(end);
                        //}
                        }
                           }
                   }
                   }
            }
             if(type.equals("MultiLineString")){
                   JSONArray multi = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("geometry").getJSONArray("coordinates");
                           for(int k = 0; k<multi.size(); k++){
                               JSONArray substring = multi.getJSONArray(k);
                                    for(int d = 0; d<substring.size(); d++){
                                           float lat = substring.getJSONArray(d).getFloat(1);
                                           float lon = substring.getJSONArray(d).getFloat(0);
                                            if(d<substring.size()-1){
                                                  PVector start = new PVector(substring.getJSONArray(d).getFloat(1), substring.getJSONArray(d).getFloat(0));
                                                  PVector end = new PVector(substring.getJSONArray(d+1).getFloat(1), substring.getJSONArray(d+1).getFloat(0));
                                                  float len = mercatorMap.Haversine(start, end);
                                                  //println(bounds.bounds);
                                               if(bounds.inbbox(start) == true || bounds.inbbox(end) == true){
                                                 if(kind.equals("path") == false && kind.equals("rail") == false){
                                                  if(int(len/7.5) == 0){
                                                    len = 7.5;
                                                     }
                                                  Road road = new Road(start, end, OSMid, 45, len, int(len/7.5), 0, 0);
                                                  a+=1;
//                                                  if(start.x > 42.36596 && start.x < 42.372135 && start.y < -71.06496 && start.y > -71.07805 
//                                                  && end.x > 42.36596 && end.x < 42.372135 && end.y < -71.06496 && end.y > -71.07805
//                                                  ){
//                                                  println("sup");
//                                                    }
//                                                  else{
                                                  Roads.add(road);
                                                  SimulationNodes.add(start);
                                                  SimulationNodes.add(end);
                                                  //}
                                                 }
                                               }
                                            }
                                    }
                           }
                   }
                    }
            }
            catch(Exception e){
            }
                }
              println("Nodes: ", Roads.size());
              println("Bounding Box: ");
              bounds.printbox();
              Table thing = new Table();
              thing.addColumn("start");
              thing.addColumn("end");
              thing.addColumn("id");
              thing.addColumn("capacity");
              thing.addColumn("length");
              thing.addColumn("speed");
              thing.addColumn("startlat");
              thing.addColumn("startlon");
              thing.addColumn("endlat");
              thing.addColumn("endlon");
              for(int i = 0; i<Roads.size(); i++){
                   TableRow newRow = thing.addRow();
                   newRow.setInt("id", Roads.get(i).OSMid);
                   newRow.setInt("start", i);
                   newRow.setInt("end", i+1);
                   newRow.setInt("capacity", Roads.get(i).cars);
                   newRow.setFloat("length", Roads.get(i).len);
                   newRow.setInt("speed", 45);
                   newRow.setFloat("startlat", Roads.get(i).start.x);
                   newRow.setFloat("startlon", Roads.get(i).start.y);
                   newRow.setFloat("endlat", Roads.get(i).end.x);
                   newRow.setFloat("endlon", Roads.get(i).end.y);
              }
              saveTable(thing, "data/roads.csv");
//              clean(SimulationNodes);
      }
      
      
  
  void drawRoads(PGraphics p, color c){
    Table hello = loadTable("data/POIs.csv", "header");
    Table thing = loadTable("data/roads.csv", "header");
    Table nodes = loadTable("Simnodes.csv", "header");
   Table stuffs = loadTable("roadsHalf.csv", "header");
    
    for(int i = 0; i<stuffs.getRowCount(); i++){
      int starter = stuffs.getInt(i, "start");
      int ender = stuffs.getInt(i, "end");
      TableRow startrow = nodes.getRow(starter-1);
      TableRow endrow = nodes.getRow(ender-1);
      PVector starts = new PVector(startrow.getFloat("lat"), startrow.getFloat("lon"));
      PVector ends = new PVector(endrow.getFloat("lat"), endrow.getFloat("lon"));
      float len = abs(mercatorMap.Haversine(starts, ends));
      stuffs.setFloat(i, "length", len);
      stuffs.setFloat(i, "capacity", int(len/7.5));
    }
    saveTable(stuffs, "roadshalf2.csv");
    
    for(int i = 0; i<nodes.getRowCount(); i++){
      PVector dot = mercatorMap.getScreenLocation(new PVector(nodes.getFloat(i, "lat"), nodes.getFloat(i, "lon")));
      p.fill(0);
      p.ellipse(dot.x, dot.y, 10, 10);
      p.fill(0);
     
      p.text(nodes.getInt(i, "id"), dot.x, dot.y-10);
      
             p.textSize(14);
       p.fill(0);
    }
    
    for(int i = 0; i<CoordsCensus.size(); i++){
      PVector dot = mercatorMap.getScreenLocation(CoordsCensus.get(i));
      p.fill(255);
      p.ellipse(dot.x, dot.y, 10, 10);
    
    }
    
    for(int i = 0; i<hello.getRowCount(); i++){
        PVector dot = mercatorMap.getScreenLocation(new PVector(hello.getFloat(i, "lat"), hello.getFloat(i, "lon")));
        
        p.fill(#0000ff);
        p.text(hello.getInt(i, "id"), dot.x + 5, dot.y);
         p.fill(#00ff00);
         
      p.textSize(14);
         
       p.ellipse(dot.x, dot.y, 10, 10);
    }
    
    for(int i = 0; i<thing.getRowCount(); i++){
      PVector start = mercatorMap.getScreenLocation(new PVector(thing.getFloat(i, "startlat"), thing.getFloat(i, "startlon")));
      PVector end = mercatorMap.getScreenLocation(new PVector(thing.getFloat(i, "endlat"), thing.getFloat(i, "endlon")));
      p.fill(0);
      p.line(start.x, start.y, end.x, end.y);
//      p.text(i, start.x + 5, start.y);
        p.textSize(14);
      //p.text(thing.getString(i, "start"), start.x + 35, start.y + 15);
      //p.text(thing.getString(i, "end"), end.x + 5, end.y);
    }
    println("Drawing roads...");
         p.beginDraw();
     for(int j = 0; j<bounds.boxcorners().size(); j++){
            PVector coord2;
            PVector coord = mercatorMap.getScreenLocation(bounds.boxcorners().get(j));
            if(j<bounds.boxcorners().size()-1){
            coord2 = mercatorMap.getScreenLocation(bounds.boxcorners().get(j+1));
            }
            else{
              coord2 = mercatorMap.getScreenLocation(bounds.boxcorners().get(0));
            }
            p.stroke(0);
            
            p.strokeWeight(5);
            p.line(coord.x, coord.y, coord2.x, coord2.y);
             p.strokeWeight(1);
            p.fill(#0000ff);
            p.ellipse(mercatorMap.getScreenLocation(bounds.boxcorners().get(0)).x, mercatorMap.getScreenLocation(bounds.boxcorners().get(0)).y, 10, 10); 
            p.fill(#00ff00);
            p.ellipse(mercatorMap.getScreenLocation(bounds.boxcorners().get(1)).x, mercatorMap.getScreenLocation(bounds.boxcorners().get(1)).y, 10, 10);
            p.fill(#ffff00);
             p.ellipse(mercatorMap.getScreenLocation(bounds.boxcorners().get(2)).x, mercatorMap.getScreenLocation(bounds.boxcorners().get(2)).y, 10, 10);
             p.fill(#ff0000);
             p.ellipse(mercatorMap.getScreenLocation(bounds.boxcorners().get(3)).x, mercatorMap.getScreenLocation(bounds.boxcorners().get(3)).y, 10, 10);
        }
        p.stroke(0);
          for(int i = 0; i<numcols+1; i++){
                float ww = abs(mercatorMap.getScreenLocation(bounds.boxcorners().get(3)).x - mercatorMap.getScreenLocation(bounds.boxcorners().get(0)).x);
                float hh = abs(mercatorMap.getScreenLocation(bounds.boxcorners().get(2)).y - mercatorMap.getScreenLocation(bounds.boxcorners().get(0)).y);
          }

      for(int i = 0; i<Roads.size(); i++){
        p.strokeWeight(1);
        PVector start = mercatorMap.getScreenLocation(new PVector(Roads.get(i).start.x, Roads.get(i).start.y));
        PVector end = mercatorMap.getScreenLocation(new PVector(Roads.get(i).end.x, Roads.get(i).end.y));
        if(showid){
            p.stroke(0);
            p.fill(255);
            //p.ellipse(start.x, start.y, 5, 5);
            p.fill(0);
            //p.ellipse(end.x, end.y, 5, 5);
            p.text(Roads.get(i).OSMid, start.x + 5, start.y);
            p.fill(0);
            //p.text(i+1, end.x + 5, end.y+10 );
            p.fill(#ff0000);
        }
        p.stroke(c);
        //p.line(start.x, start.y, end.x, end.y);  
      }
  
   p.endDraw();
   println("DONE: Roads Drawn", millis());
}

void clean(ArrayList<PVector> list){
    Table nodes = new Table();
    nodes.addColumn("lat");
    nodes.addColumn("lon");
    HashSet set = new HashSet(list);
    list.clear();
    list.addAll(set);
    
    for(int i = 0; i<list.size(); i++){
          TableRow newRow = nodes.addRow();
          newRow.setFloat("lat", list.get(i).x);
          newRow.setFloat("lon", list.get(i).y);
    }
    saveTable(nodes, "data/nodes.csv");
}
  
}

ArrayList<PVector> BresenhamMaster = new ArrayList<PVector>();

void test_Bresen(){
  for(int i = 0; i<canvas.Roads.size(); i++){
        for(int j = 0; j<canvas.Roads.get(i).Brez.size(); j++){
             BresenhamMaster.add(canvas.Roads.get(i).Brez.get(j));
        }
  }
  println("Brez", BresenhamMaster.size());
}

//
//

//  

