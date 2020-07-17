/**
 * PC Controller
 *
 * Read data from the serial port and render a representation of the controller
 * 
 * Mark Roland, markroland.com 
 * 
 * 7/4/2020
 *
 */

// Import Serial library
import processing.serial.*;

// Create object from Serial class
Serial myPort;

// Create new Joystick class object
Controller c1;

PImage img;

// Setup the sketch
void setup() {
  
    background(128);
  
  // Set sketch size
  size(400, 164);
  
  // Load controller image
  img = loadImage("NES-controller-sm.png");
  
  // Find the Serial port (Something like /dev/cu.usbserial-A3000Ykf)
  //printArray(Serial.list());
  
  // Initialize the serial port
  myPort = new Serial(this, Serial.list()[3], 9600);
  
  // Initialize the joystick object
  c1 = new Controller();

  smooth();
}

// Loop the sketch
void draw() {

  
  // Read the joystick
  c1.read();
  
  // Debugging
  //c1.print_data();
  
  // Render a cursor
  c1.render();
}
