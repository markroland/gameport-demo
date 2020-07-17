/*

PC Propad Controller Interface 

Mark Roland <mark@markroland.com>

6/3/2020 - Copied from Joystick code

*/

// Setup
void setup() {
  
  // Initialize serial connection
  Serial.begin(9600);  
}

// Main Loop
void loop(){

  // Read analog values
  int A_button = analogRead(A0);
  int B_button = analogRead(A3);
  int x_axis = analogRead(A1);
  int y_axis = analogRead(A2);
  
  // Output data to Serial port
  Serial.print("<");
  Serial.print(A_button, DEC);
  Serial.print(" ");
  Serial.print(B_button, DEC);
  Serial.print(" ");
  Serial.print(x_axis, DEC);
  Serial.print(" ");
  Serial.print(y_axis, DEC);
  Serial.print(">\n");
  
  // Delay so that Processing can handle the input
  // https://arduino.stackexchange.com/questions/1830/reducing-lag-between-the-arduino-and-a-processing-sketch-on-my-computer
  delay(50);   
}
