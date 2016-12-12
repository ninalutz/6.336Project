boolean edges, lines, showFrameRate;

void keyPressed(){
switch(key){
 
  case 'a': 
    sw2.start();
    lines = !lines;
    Test.clear();
    PLACES.clear();
    car9.drawRoads(Test);
    stuff.drawNodes(PLACES);
//    
//    for(int i = 0; i<POINetwork.size(); i++){
//        POINetwork.get(i).drawNodes(PLACES);
//    }
//    
//    for(int i =0; i<ODPOIs.size(); i++){
//        ODPOIs.get(i).drawNodes(PLACES);
//    }
    break;
    
    
  case 'o':
     edges = !edges;
     break;
  
  case 'c':
      sw.start();
      xPos = 0;
      cars = !cars;
      Cars.clear();
      car9.drawAMCars(Cars);
      break;
      
  case 'f':
      showFrameRate = !showFrameRate;
    break;  
  
}

}
