/***********************************************
Imports
************************************************/
import processing.serial.*;

/***********************
Android-specific imports
************************/
//import android.content.Intent;
//import android.os.Bundle;

//Processing android mode bluetooth library
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
//import oscP5.*;

////Accelerometer necessities
//import android.content.Context;
//import android.hardware.Sensor;
//import android.hardware.SensorManager;
//import android.hardware.SensorEvent;
//import android.hardware.SensorEventListener;



/***********************************************
Global constants
************************************************/

Point       TOP_LEFT;
Point       TOP_ONE_THIRDS;
Point       TOP_TWO_THIRDS;
View        ACTION_BAR;
View        MAIN_MENU;
View        CONFIGURE_MENU;
View        FLIGHT_MENU;
Dimensions  BUTTON_DEFAULT_DIMENSIONS;
Dimensions  SLIDER_DEFAULT_DIMENSIONS;
Dimensions  JOYSTICK_DEFAULT_DIMS;
int         JOYSTICK_DEFAULT_RADIUS;
boolean     CALIBRATING = false;
color       BACKGROUND_COLOR;
float       OUTPUT_RANGE;
int         DEFAULT_TEXT_SIZE;



/***********************************************
Initialization function - cleaner here than in setup()
************************************************/

void initialiseDeclarations() {
  BACKGROUND_COLOR = color(255,255,255);
  OUTPUT_RANGE = 255;
  DEFAULT_TEXT_SIZE = 15;
  TOP_LEFT = new Point(0,0);
  TOP_ONE_THIRDS = new Point(width/3,0);
  TOP_TWO_THIRDS = new Point(width*2/3,0);
  BUTTON_DEFAULT_DIMENSIONS = new Dimensions(width/3-1, 100);
  SLIDER_DEFAULT_DIMENSIONS = new Dimensions(width / 10, height * 4 / 5);
  JOYSTICK_DEFAULT_RADIUS = min(width,height)*2/3;
  JOYSTICK_DEFAULT_DIMS = new Dimensions(JOYSTICK_DEFAULT_RADIUS,(int)(JOYSTICK_DEFAULT_RADIUS * 0.15),0);
  
  
  MAIN_MENU = new View("Main menu view");
  MAIN_MENU.add(new TextBox("Home", new Point(width/2, height/2)));
  MAIN_MENU.add(new Slider(new Point(width/3, height/2), new Dimensions(100,400,20)));
  CONFIGURE_MENU = new View("Configuration view");
  CONFIGURE_MENU.add(new TextBox("Configuration", new Point(width/2, BUTTON_DEFAULT_DIMENSIONS.dims[1] + 10)));
  //CONFIGURE_MENU.add(newButton(new Discover(),"Discover",color(255,255,255),new Point(0,height/4),BUTTON_DEFAULT_DIMENSIONS));
  //CONFIGURE_MENU.add(newButton(new MakeDiscoverable(),"Make Discoverable",color(255,255,255),new Point(0,height*1/2),BUTTON_DEFAULT_DIMENSIONS));
  //CONFIGURE_MENU.add(newButton(new Connect(),"Connect",color(255,255,255),new Point(0,height*3/4),BUTTON_DEFAULT_DIMENSIONS));
  FLIGHT_MENU = new View("Flight menu view");
  FLIGHT_MENU.add(new CheckBox(new Point(width/2 - 100, height - 100), new Dimensions(50,50)));
  FLIGHT_MENU.add(new CheckBox(new Point(width/2, height - 100), new Dimensions(50,50)));
  leftStick = new Joystick(new Point(width*1/4,height/2), JOYSTICK_DEFAULT_DIMS);
  leftStick.setResting(new Point(leftStick.point.x,leftStick.point.y + (int)leftStick.getRadius())).rest();
  rightStick = new Joystick(new Point(width*3/4,height/2), JOYSTICK_DEFAULT_DIMS);
  rightStick.setResting(new Point(rightStick.point)).rest();
  FLIGHT_MENU.add(leftStick);
  FLIGHT_MENU.add(rightStick);
  
  ACTION_BAR = new View();
  system.action_bar = ACTION_BAR;
  system.active_view = MAIN_MENU;
  ACTION_BAR.add(newButton(new ChangeView(CONFIGURE_MENU),"Configure menu",color(255,255,255),TOP_LEFT,BUTTON_DEFAULT_DIMENSIONS));
  ACTION_BAR.add(newButton(new ChangeView(MAIN_MENU),"Main menu",color(255),TOP_ONE_THIRDS,BUTTON_DEFAULT_DIMENSIONS));
  ACTION_BAR.add(newButton(new ChangeView(FLIGHT_MENU),"Flight menu",color(255),TOP_TWO_THIRDS,BUTTON_DEFAULT_DIMENSIONS));
}
