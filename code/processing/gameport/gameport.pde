/**
 * PC Propad Gameport Controller
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

int serial_port_id;

// Setup the sketch
void setup() {

  smooth();

  background(128);

  // Set sketch size
  size(600, 388);

  // Load controller image
  img = loadImage("data/PC_propad.jpg");

  // Setup only: Find the Serial port (Something like /dev/cu.usbserial-A3000Ykf)
  //printArray(Serial.list());
  serial_port_id = 3;

  // Initialize the serial port
  myPort = new Serial(this, Serial.list()[serial_port_id], 9600);

  // Initialize the joystick object
  c1 = new Controller();
}

// Loop the sketch
void draw() {

  // Read the joystick
  c1.read();

  // Debugging
  //c1.print_data();

  // Render canvas
  c1.render();
}
