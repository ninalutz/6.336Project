void initSliders(){
  textSize(20);
    cp5.addSlider("k")
     .setPosition(100,70)
     .setSize(200,20)
     .setValue(1)
     .setColorBackground(0) 
     .setColorActive(accentred)
     .setColorLabel(background)
     .setColorValue(background)
     .setColorValueLabel(background)
     .setRange(0,4)
     .setDecimalPrecision(0)
     .setNumberOfTickMarks(5)
     .snapToTickMarks(true)
     .showTickMarks(false) 

     ;
    cp5.addSlider("t")
     .setPosition(100,120)
     .setSize(200,20)
     .setValue(1)
     .setColorBackground(0) 
     .setColorActive(accentred)
     .setColorLabel(background)
     .setColorValue(background)
     .setColorValueLabel(background)
     .setRange(0,4)
     .setDecimalPrecision(0)
     .setNumberOfTickMarks(5)
     .snapToTickMarks(true)
     .showTickMarks(false) 
     ;
     
 cp5.getController("t").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("k").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  
     
}
