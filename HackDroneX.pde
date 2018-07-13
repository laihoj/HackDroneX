System system;
Serial myPort;

//think about where these should go
Joystick leftStick;
Joystick rightStick;


void setup() {
  system = new System();
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  frameRate(20);
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