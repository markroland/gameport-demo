/**
 * PC Controller Class
 *
 * Mark Roland, markroland.com
 *
 * 7/5/2020
 *
 */
class Controller{

  public int readFlag = -1;

  int A_val = 0;
  int B_val = 0;
  int X_val = 0;
  int Y_val = 0;

  // Set neutral values
  // This is based on observing the data coming from the Serial port
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
      if(inByte == 32){
        readFlag++;
      }

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

    // Render controller picture
    image(img, 0, 0);

    // Show buttons
    draw_AB_buttons();
    draw_arrowpad();
  }

  void draw_arrowpad(){

    int arrow_size = 24;

    pushMatrix();

    // Move the control pad on the screen as a group
    translate(144, 188);

    rotate(radians(-3.5));

    // ---- Inactive state
    /*
    stroke(228);
    noFill();
    // Up, Right, Down, Left
    rect(arrow_size, 0, arrow_size, arrow_size);
    rect(2* arrow_size, arrow_size, arrow_size, arrow_size);
    rect(arrow_size, 2 * arrow_size, arrow_size, arrow_size);
    rect(0, arrow_size, arrow_size, arrow_size);
    //*/

    // ---- Active state

    // Arrows (filled)
    noStroke();
    fill(0,255,0);

    // Right or Left
    if( X_val < (X0 - 30) ){
      rect(2* arrow_size, arrow_size, arrow_size, arrow_size);
    }else if( X_val > (X0 + 30)){
      rect(0, arrow_size, arrow_size, arrow_size);
    }

    // Up or down
    if (Y_val > (Y0 + 30)){
      rect(arrow_size, 0, arrow_size, arrow_size);
    }else if( Y_val < (Y0 - 30) ){
      rect(arrow_size, 2 * arrow_size, arrow_size, arrow_size);
    }

    popMatrix();
  }

  void draw_AB_buttons(){

    int button_size = 32;
    int button_space = 60;

    pushMatrix();

    translate(393, 230);

    rotate(radians(-26.0));

    // ---- Inactive state
    /*
    stroke(228);
    noFill();
    ellipse(0, 0, 32, 32);
    ellipse(button_space, 0, 32, 32);
    //*/

    // ---- Active state

    fill(0,255,0);
    noStroke();

    if( A_val < 1000 ){
      ellipse(0, 0, button_size, button_size);
    }

    if( B_val < 1000 ){
      ellipse(button_space, 0, button_size, button_size);
    }

    popMatrix();
  }
}
