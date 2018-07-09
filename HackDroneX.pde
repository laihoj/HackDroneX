//Declaring environment variables
ArrayList<String> devicesDiscovered = new ArrayList();
boolean CONFIGURING = true;
boolean CALIBRATING = false;
color BACKGROUND_COLOR = color(255,255,255);
String UIText;

//UI related stuff
int DEFAULT_TEXT_SIZE = 15;
System system;
View ACTION_BAR;
View MAIN_MENU;
View CONFIGURE_MENU;
View FLIGHT_MENU;
Dimensions BUTTON_DEFAULT_DIMENSIONS;
Point TOP_LEFT;
Point TOP_ONE_THIRDS;
Point TOP_TWO_THIRDS;
void setup() {
  TOP_LEFT = new Point(0,0);
  TOP_ONE_THIRDS = new Point(width/3,0);
  TOP_TWO_THIRDS = new Point(width*2/3,0);
  BUTTON_DEFAULT_DIMENSIONS = new Dimensions(width/3-1, 100);
  frameRate(20);
  fullScreen();
  background(255, 128, 0);
  stroke(255);
  textSize(24);
  system = new System();
  MAIN_MENU = new View();
  MAIN_MENU.add(new TextBox("Home", new Point(width/2, height/2)));
  CONFIGURE_MENU = new View();
  CONFIGURE_MENU.add(new TextBox("Configuration", new Point(width/2, height/2)));
  FLIGHT_MENU = new View();
  FLIGHT_MENU.add(new TextBox("Flying", new Point(width/2, height/2)));
  
  ACTION_BAR = new View();
  system.action_bar = ACTION_BAR;
  system.active_view = MAIN_MENU;
  ACTION_BAR.add(newButton(new Configure(),"Configure",color(255,255,255),TOP_LEFT,BUTTON_DEFAULT_DIMENSIONS));
  ACTION_BAR.add(newButton(new Home(),"Main menu",color(255),TOP_ONE_THIRDS,BUTTON_DEFAULT_DIMENSIONS));
  ACTION_BAR.add(newButton(new Fly(),"Fligth menu",color(255),TOP_TWO_THIRDS,BUTTON_DEFAULT_DIMENSIONS));
}

void draw() {
  background(255);
  system.listen();
  system.display();
  system.execute();
}