//Declaring environment variables
ArrayList<String> devicesDiscovered = new ArrayList();
//boolean CONFIGURING = true;
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
Dimensions SLIDER_DEFAULT_DIMENSIONS;
Dimensions JOYSTICK_DEFAULT_DIMENSIONS;
Joystick leftStick;
Joystick rightStick;
int JOYSTICK_DEFAULT_RADIUS;
Point TOP_LEFT;
Point TOP_ONE_THIRDS;
Point TOP_TWO_THIRDS;
float OUTPUT_RANGE = 255;

boolean flying = false;


/***********************************************
System states
************************************************/
int BOOTING = 0;
int MAIN_MENUING = 1;
int CONFIGURING = 2;
int FLYING = 3;
