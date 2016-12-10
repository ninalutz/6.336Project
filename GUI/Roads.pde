public class Road{
  public String name; 
  public int cars, capacity, speed, id;
  public float flow, len;
  PVector start, end; 
 
 
   Road(PVector _start, PVector _end, int _id){
    start = _start;
    id = _id;
    end = _end;
  }
  
  
  public void drawRoad(PGraphics p){
    PVector startViz = mercatorMap.getScreenLocation(start);
    PVector endViz = mercatorMap.getScreenLocation(end);
  }
 

}

public class RoadNetwork{
  public ArrayList<Road>Roads = new ArrayList<Road>();

}
