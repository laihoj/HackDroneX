import processing.serial.*;
Serial myPort;



void setup() {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  TOP_LEFT = new Point(0,0);
  TOP_ONE_THIRDS = new Point(width/3,0);
  TOP_TWO_THIRDS = new Point(width*2/3,0);
  BUTTON_DEFAULT_DIMENSIONS = new Dimensions(width/3-1, 100);
  SLIDER_DEFAULT_DIMENSIONS = new Dimensions(width / 10, height * 4 / 5);
  JOYSTICK_DEFAULT_RADIUS = min(width,height)*2/3;
  JOYSTICK_DEFAULT_DIMENSIONS = new Dimensions(JOYSTICK_DEFAULT_RADIUS,JOYSTICK_DEFAULT_RADIUS);
  frameRate(20);
  //orientation(LANDSCAPE);
  fullScreen();
  stroke(255);
  textSize(24);
  system = new System();
  MAIN_MENU = new View("Main menu view");
  MAIN_MENU.add(new TextBox("Home", new Point(width/2, height/2)));
  MAIN_MENU.add(new CheckBox(new Point(width/2, height/2 + 100), new Dimensions(100,100)));
  CONFIGURE_MENU = new View("Configuration view");
  CONFIGURE_MENU.add(new TextBox("Configuration", new Point(width/2, BUTTON_DEFAULT_DIMENSIONS.korkeus + 10)));
  //CONFIGURE_MENU.add(newButton(new Discover(),"Discover",color(255,255,255),new Point(0,height/4),BUTTON_DEFAULT_DIMENSIONS));
  //CONFIGURE_MENU.add(newButton(new MakeDiscoverable(),"Make Discoverable",color(255,255,255),new Point(0,height*1/2),BUTTON_DEFAULT_DIMENSIONS));
  //CONFIGURE_MENU.add(newButton(new Connect(),"Connect",color(255,255,255),new Point(0,height*3/4),BUTTON_DEFAULT_DIMENSIONS));
  FLIGHT_MENU = new View("Flight menu view");
  FLIGHT_MENU.add(new TextBox("Flying", new Point(width/2, height/2)));
  leftStick = new Joystick(new Point(width*1/4,height/2), JOYSTICK_DEFAULT_DIMENSIONS);
  leftStick.setResting(new Point(leftStick.point.x,leftStick.point.y + (int)leftStick.radius));
  rightStick = new Joystick(new Point(width*3/4,height/2), JOYSTICK_DEFAULT_DIMENSIONS);
  rightStick.setResting(new Point(rightStick.point));
  FLIGHT_MENU.add(leftStick);
  FLIGHT_MENU.add(rightStick);
  
  ACTION_BAR = new View();
  system.action_bar = ACTION_BAR;
  system.active_view = MAIN_MENU;
  ACTION_BAR.add(newButton(new Configure(),"Configure",color(255,255,255),TOP_LEFT,BUTTON_DEFAULT_DIMENSIONS));
  ACTION_BAR.add(newButton(new Home(),"Main menu",color(255),TOP_ONE_THIRDS,BUTTON_DEFAULT_DIMENSIONS));
  ACTION_BAR.add(newButton(new Fly(),"Flight menu",color(255),TOP_TWO_THIRDS,BUTTON_DEFAULT_DIMENSIONS));
}

void draw() {
  background(255);
  system.listen();
  system.display();
  system.execute();
  //String message = "$" + leftStick.toString() + "," + rightStick.toString();
  //if(flying) {
  //  println(message);
  //  myPort.write(message);
  //}
  
  //bt.broadcast(message.getBytes());
}
