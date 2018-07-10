//import android.content.Intent;
//import android.os.Bundle;

//Processing android mode bluetooth library
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import oscP5.*;

////Accelerometer necessities
//import android.content.Context;
//import android.hardware.Sensor;
//import android.hardware.SensorManager;
//import android.hardware.SensorEvent;
//import android.hardware.SensorEventListener;

//Declaring variables for Bluetooth
KetaiBluetooth bt;
String info = "";
KetaiList klist;

////********************************************************************
//// The following code is required to enable bluetooth at startup.
////********************************************************************
//void onCreate(Bundle savedInstanceState) {
//  super.onCreate(savedInstanceState);
//  bt = new KetaiBluetooth(this);
//}

//void onActivityResult(int requestCode, int resultCode, Intent data) {
//  bt.onActivityResult(requestCode, resultCode, data);
//}

////********************************************************************

//void onKetaiListSelection(KetaiList klist)
//{
//  String selection = klist.getSelection();
//  bt.connectToDeviceByName(selection);

//  //dispose of list for now
//  klist = null;
//}