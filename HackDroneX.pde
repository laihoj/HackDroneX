System system;
Serial myPort = null;

//think about where these should go
Joystick_Left leftStick;
Joystick_Right rightStick;
Slider mainSlider;


void setup() {
  system = new System();
  printArray(Serial.list());
  //myPort = new Serial(this, Serial.list()[0], 9600);
  frameRate(120);
  //orientation(LANDSCAPE);
  fullScreen();
  stroke(255);
  textSize(24);
  initialiseDeclarations();
}

void draw() {
  background(255);
  system.listen();
  system.display();
  system.execute();
  //output_state();
  
  //bt.broadcast(message.getBytes());
}