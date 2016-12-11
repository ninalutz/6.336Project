RoadNetwork non7, car7, non9, car9, non11, car11;

Places stuff;

ArrayList<Edge> all = new ArrayList<Edge>();
ArrayList<Edge> french = new ArrayList<Edge>();
ArrayList<Edge> spanish = new ArrayList<Edge>();
ArrayList<Edge> other = new ArrayList<Edge>();

void generateClosingRoads(){
  
}

void generateOpeningRoads(){
  stuff = new Places(1);
  non7 = new RoadNetwork("7amnocarpool", 7, true, false);
  car7 = new RoadNetwork("7amcarpool", 7, true, true);
   non9 = new RoadNetwork("9amnocarpool", 7, true, false);
   non11 = new RoadNetwork("11amnocarpool", 7, true, false);
   car11 = new RoadNetwork("11amcarpool", 7, true, true);
   car9 = new RoadNetwork("9amcarpool", 7, true, true);
  
  for(int i = 0; i<opening.getRowCount(); i++){

    int startid = opening.getInt(i, "start node");
    int endid = opening.getInt(i, "end node");

           PVector start = new PVector(nodes.getFloat(startid - 1,"lat"), nodes.getFloat(startid - 1,"lon"));
           PVector end = new PVector(nodes.getFloat(endid - 1,"lat"), nodes.getFloat(endid - 1,"lon"));
            
           Road road7amnon = new Road(start, end, i, opening.getFloat(i, "7_no_carpool"), opening.getInt(i, "capacity"), opening.getInt(i, "speed (meter/s)"));
           Road road7am = new Road(start, end, i, opening.getFloat(i, "7_with_carpool"), opening.getInt(i, "capacity"), opening.getInt(i, "speed (meter/s)"));
           non7.Roads.add(road7amnon);
           car7.Roads.add(road7am);
           
           Road road9amnon = new Road(start, end, i, opening.getFloat(i, "9_no_carpool"), opening.getInt(i, "capacity"), opening.getInt(i, "speed (meter/s)"));
           Road road9am = new Road(start, end, i, opening.getFloat(i, "9_with_carpool"), opening.getInt(i, "capacity"), opening.getInt(i, "speed (meter/s)"));
           non9.Roads.add(road9amnon);
           car9.Roads.add(road9am);
           
           Road road11amnon = new Road(start, end, i, opening.getFloat(i, "11_no_carpool"), opening.getInt(i, "capacity"), opening.getInt(i, "speed (meter/s)"));
           Road road11am = new Road(start, end, i, opening.getFloat(i, "11_with_carpool"), opening.getInt(i, "capacity"), opening.getInt(i, "speed (meter/s)"));
           non11.Roads.add(road11amnon);
           car11.Roads.add(road11am);

  }
  
  non7.flows();
  car7.flows();
  non9.flows();
  car9.flows(); 
  non11.flows();
  car11.flows();
}

ArrayList<POI>POINetwork = new ArrayList<POI>();
ArrayList<POI>ODPOIs = new ArrayList<POI>();
ArrayList<Edge>ODMatrix = new ArrayList<Edge>();

void generatePOIs(){
  
  for(int i = 0; i<POIs.getRowCount(); i++){
    //  POI(PVector _location, int _id, int _income, int _total, int _open, int _close){
    POI poi = new POI(new PVector(POIs.getFloat(i, "lat"), POIs.getFloat(i, "lon")), POIs.getInt(i, "id"), POIs.getInt(i, "income"), 0, 0, 0);
    POINetwork.add(poi);
    stuff.places.add(poi);
  }
}

void generateODs(){
  Table OD = loadTable("data/O9noncarpool.csv", "header");
  for(int i = 0; i<OD.getRowCount(); i++){
    POI poi = new POI(new PVector(OD.getFloat(i, "lat"), OD.getFloat(i, "lon")), OD.getInt(i, "id"), OD.getInt(i, "income"), OD.getInt(i, "amount"), OD.getInt(i, "open"), OD.getInt(i, "close"));
    ODPOIs.add(poi); 
    stuff.places.add(poi); 
    
     PVector org = new PVector(nodes.getFloat(0, "lat"), nodes.getFloat(0, "lon"));

    //Edge(PVector _origin, PVector _destination, float _increment, int _amount, int _income, color _incomecolor, int _oi, int _di){
    if(OD.getInt(i, "income") == 1){
    Edge edge = new Edge(org, new PVector(OD.getFloat(i, "lat"), OD.getFloat(i, "lon")), increment, OD.getInt(i, "amount"), 
    1, income1color, 1, OD.getInt(i, "id"));
    ODMatrix.add(edge);
    }
    if(OD.getInt(i, "income") == 2){
    Edge edge = new Edge(org, new PVector(OD.getFloat(i, "lat"), OD.getFloat(i, "lon")), increment, OD.getInt(i, "amount"), 
    2, income2color, 1, OD.getInt(i, "id"));
    ODMatrix.add(edge);
    }
    if(OD.getInt(i, "income") == 3){
    Edge edge = new Edge(org, new PVector(OD.getFloat(i, "lat"), OD.getFloat(i, "lon")), increment, OD.getInt(i, "amount"), 
    3, income3color, 1, OD.getInt(i, "id"));
    ODMatrix.add(edge);
    }
    
}

}
