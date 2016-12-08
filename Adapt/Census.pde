JSONArray mastercensus = new JSONArray();
JSONArray exportcensus;
JSONObject blok;
String poplink;

ArrayList<PVector>CoordsCensus = new ArrayList<PVector>();

void cleaner(ArrayList<PVector> list){
    HashSet set = new HashSet(list);
    list.clear();
    list.addAll(set);
    
}
 
int totalpopulation; 
StringList BlockCodes;
public void PullCensus() {
  BlockCodes = new StringList();
  //lat is vert
  //lon is horz
  int rows = 30;
  int cols = 50;
  float distancehorz = mercatorMap.Haversine(new PVector(42.373207, -71.098015), new PVector(42.373207, -71.078415));
  float distancevert = mercatorMap.Haversine(new PVector(42.373207, -71.098015), new PVector(42.365196, -71.098015));
  println(distancehorz, distancevert);
  //  
  float inchorz = distancehorz*2/cols;
  float incvert = distancevert*2/rows;

  for (int i = 0; i<rows; i++) {
    for (int j = 0; j<cols; j++) {
      PVector leftcorner = mercatorMap.getScreenLocation( new PVector(42.373207, -71.098015));
      float starty = leftcorner.y + incvert/2;

      float y = starty + incvert*i;
      float x = leftcorner.x + inchorz*j;

      CoordsCensus.add(mercatorMap.getGeo(new PVector(x, y)));
    }
  }
  
  cleaner(CoordsCensus);


  for (int i = 0; i<CoordsCensus.size(); i++) {
    // PVector loc = new PVector(map.getLocation(i*10, i*10).y, map.getLocation(i*10, i*10).x);
//    float horzstep = float(boxw*2)/float(size*2);
//    float vertstep = float(boxh*2)/float(size*2);
//    PVector xy = mercatorMap.getScreenLocation(new PVector(BleedZone().get(1).x, BleedZone().get(1).y));
//    PVector loc = mercatorMap.getGeo(new PVector(xy.x + i*horzstep, xy.y + i*vertstep));
    //        Cell cell = new Cell(i, mercatorMap.getGeo(new PVector(xy.x + i*horzstep, xy.y + i*vertstep)));
    
      link = "http://www.broadbandmap.gov/broadbandmap/census/block?latitude=" + CoordsCensus.get(i).x + "&longitude=" + CoordsCensus.get(i).y + "&format=json";
      GetRequest get = new GetRequest(link);
      get.send();
      output = get.getContent();
      blok = parseJSONObject(output);

      float maxx = blok.getJSONObject("Results").getJSONArray("block").getJSONObject(0).getJSONObject("envelope").getFloat("maxx");
      float maxy = blok.getJSONObject("Results").getJSONArray("block").getJSONObject(0).getJSONObject("envelope").getFloat("maxy");
      float minx = blok.getJSONObject("Results").getJSONArray("block").getJSONObject(0).getJSONObject("envelope").getFloat("minx");
      float miny = blok.getJSONObject("Results").getJSONArray("block").getJSONObject(0).getJSONObject("envelope").getFloat("miny");
      String blockcode = blok.getJSONObject("Results").getJSONArray("block").getJSONObject(0).getString("FIPS");

      
      if(BlockCodes.hasValue(blockcode) == false){
          BlockCodes.append(blockcode);
        poplink = "http://api.census.gov/data/2010/sf1?key=d25ec0abd89f8be098513b759dea2f216f886a06&get=P0010001&for=block:" + blockcode.substring(11) + 
        "&in=state:" + blockcode.substring(0, 2) +"+county:" + blockcode.substring(2, 5) + "+tract:" + blockcode.substring(5, 11);      
     GetRequest get2 = new GetRequest(poplink);

      get2.send();
      output2 = get2.getContent();
      exportcensus = parseJSONArray(output2);
      int pop = exportcensus.getJSONArray(1).getInt(0);

      blok.getJSONObject("Results").getJSONArray("block").getJSONObject(0).setInt("Population", pop);
//      blockbbx = new bbox(miny, minx, maxy, maxx);
//
//      Block thing = new Block(int(blockcode), pop, blockbbx);
//
//      grid.Blocks.add(thing);

      println(int(float(i)/CoordsCensus.size()*100) + "% DONE CENSUS");
      if(pop > 0){
      mastercensus.setJSONObject(i, blok);
      totalpopulation+=pop;
      }   
      }

  }
  try {
    saveJSONArray(mastercensus, "exports/census" + map.getLocation(0, 0) + "_" + map.getLocation(width, height)+".json");
  }
  catch(Exception e) {
  }
  println(totalpopulation);
}

