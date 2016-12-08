void setup(){
  
  numbers(26, 5155);
}

void draw(){}

public int[] numbers(int size, int sum){
  int[] things = new int[size];
  int[] things2 = new int[size];
  float num = 0;
  float num2 = 0;
  for(int i = 0; i<size; i++){
      things[i] = int(random(5, sum/size));
      num += things[i];
  }
  
  for(int i = 0; i<size; i++){
      things2[i] = int((things[i]/num)*sum);
      num2+=things2[i];
  }
  
  println(things2);
  println(num2);
  
  return things2;
}
