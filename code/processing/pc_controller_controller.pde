/**
 * PC Controller Class
 *
 * Mark Roland, markroland.com
 *
 * 7/3/2020
 *
 */
class Controller{

  // Public variables
  public int readFlag = -1;  

  // Private variables

  int A_val = 0;
  int B_val = 0;
  int X_val = 0;
  int Y_val = 0;
  int X0 = 676;
  int Y0 = 674;

  void read(){
  
    // Data received from the serial port
    int inByte;

    // read value from serial port
    while (myPort.available() > 0) {
      inByte = myPort.read();

      // start of transmission: "<"
      if(inByte == 60){
        A_val = 0;
        B_val = 0;
        X_val = 0;
        Y_val = 0;
        readFlag = 1;
      }
      
      // between ASCII numbers 0-9
      if(readFlag > 0 && (inByte >= 48) && (inByte <= 57)){ 
        
        if(readFlag == 1){
          A_val *= 10;
          A_val += inByte-48;
        }
        
        if(readFlag == 2){
          B_val *= 10;
          B_val += inByte-48;
        }
        
        if(readFlag == 3){
          X_val *= 10;
          X_val += inByte-48;
        }
        
        if(readFlag == 4){
          Y_val *= 10;
          Y_val += inByte-48;
        }

      }
      
      // space between points
      if(inByte == 32) 
        readFlag++;  
  
      // end of transmission: ">"
      if(inByte == 62){
        readFlag = 0;
      }
    }

  }

  void print_data(){
    println("<" + A_val + " " + B_val + " " + X_val + " " + Y_val + ">"); 
  }
  
  void render(){
    
    if (c1.readFlag != 0) {
      return;
    }
    
    image(img, 0, 0);
    fill(255,255,255,128);
    rect(0, 0, width, height);
    
    // Show button presses
    render_buttons();
  }
  
  void render_buttons(){

    stroke(228);
    noFill();
    
    // Arrows (empty)
    /*
    pushMatrix();
    translate(28,59);
    rect(25,0,25,25);
    rect(50,25,25,25);
    rect(25,50,25,25);
    rect(0,25,25,25);
    popMatrix();
    //*/
    
    // Buttons (empty)
    /*
    pushMatrix();
    translate(281, 116);
    ellipse(0, 0, 29, 29);
    ellipse(52, 0, 29, 29);
    popMatrix();
    //*/

    // Arrows (filled)
    noStroke();
    fill(0,255,0);
    pushMatrix();
    translate(28,59);
    if( X_val < (X0 - 30) ){
      // Right
      rect(50,25,25,25);
    }else if( X_val > (X0 + 30)){
      // Left
      rect(0,25,25,25);  
    }

    if( Y_val > (Y0 + 30) ){
      // Up
      rect(25,0,25,25);
    }else if( Y_val < (Y0 - 30) ){
      // Down
      rect(25,50,25,25);  
    }
    popMatrix();

    // Buttons (filled)
    fill(0,255,0);
    noStroke();
    pushMatrix();
    translate(281, 116);
    if( A_val < 1000 ){      
      ellipse(0, 0, 29, 29);
    }
    if( B_val < 1000 ){
      ellipse(52, 0, 29, 29);
    }
    popMatrix();

  }
}
