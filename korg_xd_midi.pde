import themidibus.*; //Import the library


MidiBus myBus; // The MidiBus

float circ_radius = 100;
int circ_x, circ_y;
int num_circs=1;
int max_num_circs = 123;
float circ_sw=1; // strokeWeight
float circ_polar_off=0;
float circ_sw_alpha = 255;
float hue_base, hue_rng, bkg_clr;
float rot_vel; // rotational velocity. How fast and in what direction -1 , 1
float curr_rot; // in radians
float max_rot_vel = TWO_PI/123;
boolean shape_type=false; // circle or line


void setup() {
  size(800, 800);
  // fullScreen();
  colorMode(HSB, 1.0);
  background(.618, .618, .32);
  println("pre list");
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  println("post list");
  circ_x = width / 2;
  circ_y = height / 2;
  curr_rot=0;
  rot_vel=0;


  myBus = new MidiBus(this, 3, 4); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.
}

void draw() {
  int channel =2;
  int pitch = 60;
  int velocity = 120;

  //myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  //delay(20);
  //myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff


  background(1, 0, bkg_clr);
  //fill(0.618, 0, 1);
  strokeWeight(circ_sw);
  float hue_intrvl = hue_rng/num_circs;
  noFill();
  push();
  float rot_incr = PI * rot_vel;
  curr_rot += rot_vel;
  translate(circ_x, circ_y);
  rotate(curr_rot);
  for (int i=0; i<num_circs; i++) {
    float polar_off =  i*(TWO_PI/num_circs);
    float hue = (hue_base+(i * hue_intrvl))%1.0;
    push();
    //stroke(1/num_circs
    rotate(polar_off);
    stroke(hue, 1, 1, circ_sw_alpha);

    if (shape_type) {
      line(0, circ_polar_off, 0+circ_radius, circ_polar_off+circ_radius);
    } else {
      ellipse(0, circ_polar_off, circ_radius, circ_radius);
    }
    //rect(0, circ_polar_off, circ_radius, circ_polar_off+circ_radius);
    //ellipse(random(pow(1.618,i)), circ_polar_off+random(pow(1.618,i)),1,1);
    pop();
  }
  pop();
  delay(2);
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  //println();
  println("Note On  – Channel: "+channel+", Pitch: "+pitch+ ", Velocity: "+velocity);
  //println("Channel: "+channel+", Pitch: "+pitch+ ", Velocity: "+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff

  println("Note Off – Channel: "+channel+", Pitch: "+pitch+ ", Velocity: "+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change – Channel: "+channel+", Number: "+number+ ", Value: "+value);

  if (number == 24) circ_radius = map(value, 0, 127, width*pow(.618, 7), width); // LFO RATE
  if (number == 26) circ_sw = map(value, 64, 127, 0.32, 521); // LFO INT
  if (number == 43) circ_polar_off = map(value, 127, 0, 0, width/2); // FILTER CUTOFF
  if (number == 44) circ_sw_alpha = map(value, 0, 127, 0, 1); // RES
  if (number == 39) num_circs = int(map(value, 0, 127, 1, max_num_circs)); // VCO 1 LVL
  if (number == 40) hue_base = map(value, 0, 127, 0, 1); // VCO 2 LVL
  if (number == 33) hue_rng = map(value, 0, 127, 0, 1); // VCO 3 LVL
  if (number == 80) bkg_clr = map(value, 0, 127, 0, 1); // SYNC
  if (number == 81) shape_type = parseBoolean(int(map(value, 0, 127, 0, 1))); // RING
  if (number == 22) { // EG INT
    rot_vel = map(value, 0, 127, -max_rot_vel, max_rot_vel);
    if (value == 64) rot_vel = 0;

    println(rot_vel);
  }
}

void keyPressed() {
if (key == 's' || key == 'S') {
    String export_filename_png = "output/korg_xd_midi-"+get_curr_datetime()+".png";
    pg.save(export_filename_png);
    println("Saved to: " + export_filename_png);
  }
}

  String get_curr_datetime() {
  // Get current date and time
  int year = year();
  int month = month();
  int day = day();
  int hour = hour();
  int minute = minute();
  int second = second();
  
  // Format date and time with leading zeros
  String formattedDateTime = nf(year, 4) + nf(month, 2) + nf(day, 2) + nf(hour, 2) + nf(minute, 2) + nf(second, 2);
  
  return formattedDateTime;
}