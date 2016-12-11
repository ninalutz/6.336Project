Table POIs, O9, O11, C5, O7, C9, C10, C11;

void setup(){
POIs = loadTable("data/POIs.csv", "header");
O9 = loadTable("data/O9am.csv", "header");
O7 = loadTable("data/O7am.csv", "header");
O11 = loadTable("data/O11am.csv", "header");
C5 = loadTable("data/C5pm.csv", "header");
C9 = loadTable("data/C9pm.csv", "header");
C10 = loadTable("data/C10pm.csv", "header");
C11 = loadTable("data/C11pm.csv", "header");

C11.addColumn("amount");
for(int i = 0; i<POIs.getRowCount(); i++){
    for(int j = 0; j<C11.getRowCount(); j++){
      int id = POIs.getInt(i, "id");
      int amount = POIs.getInt(i, "noncarpool");
      String nameP = POIs.getString(i, "name");
      String nameC = C11.getString(j, "name");
      
      if(nameP.equals(nameC)){
        C11.setInt(j, "amount", amount);
        C11.setInt(j, "id", id);
        saveTable(C11, "C11noncarpool.csv");
      }
    }
}

}
