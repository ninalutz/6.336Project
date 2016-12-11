Table table; 

class POI{
  public String name, kind;
  public int id, total, totalin;
  public PVector location;

  POI(PVector _location, int _id, int _total, String _name, String _kind){
        location = _location;
        id = _id;
        total = _total;
        name = _name;
        kind = _kind;
    }
}

class ODPOIs{
   public ArrayList<POI>POIs = new ArrayList<POI>(); 
   public String name;
   
   ODPOIs(String _name){
     name = _name;
   }
   
public void PullPOIs(){
   Table stuff = loadTable("POIs.csv", "header");
   for(int i =0; i<stuff.getRowCount(); i++){
     PVector dot = new PVector(stuff.getFloat(i, "lat"), stuff.getFloat(i, "lon"));
      POI poi = new POI(dot, i, 0, stuff.getString(i, "name"), "hello");
      POIs.add(poi);
     }
  
//  println("pulling POIS");
//  XML[] widthtag;
//  if(!demo){
//  xml = loadXML("exports/" + "OSM"+ map.getLocation(0, 0) + "_" + map.getLocation(width, height)+ ".xml");
//  }
//  
//  if(demo){
//   xml = loadXML("data/OSM(42.363, -71.068)_(42.357, -71.053).xml");
//  }
//  XML[] children = xml.getChildren("node");
//  println(children.length);
//  for(int i = 0; i<children.length; i++){
//    String hello;
//    XML[] tag = children[i].getChildren("tag"); 
//    for(int j = 0; j < tag.length; j++){
//      hello = "hello";
//        if(tag[j].getString("k").equals("amenity") || tag[j].getString("k").equals("building") || tag[j].getString("k").equals("poi") || tag[j].getString("k").equals("name")){
//            float lat = float(children[i].getString("lat"));
//            float lon = float(children[i].getString("lon"));
//                     PVector loc = new PVector(lat, lon);
//                     if(Bounds.inbbox(loc) == true){
//                         if(tag[j].getString("k").equals("name")){
//                             hello = tag[j].getString("v");
//                         }
//                     POI poi = new POI(loc, 12, 0, hello, "stuff");
//                     POIs.add(poi);
//                     }
//        }
//    }
//}
//
//    
    println("POIs generated: ", POIs.size());
}   

 
}
