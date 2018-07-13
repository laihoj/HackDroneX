float limit(float value, float min, float max) {
  return min(max,max(min,value));
}

void output_state() {
  String message = "$" + leftStick.toString() + "," + rightStick.toString();
  //println("Left: " + leftStick.toString() + "," + " Right: " + rightStick.toString());
  println(message);
  myPort.write(message);
}




/***********************************************************************************************/
Button newButton(Command command, String text, color c, Point point, Dimensions dimensions) {
  Button result = new Button(command,text,c,point,dimensions);
  system.mouseListener.add(result);
  return result;
}
/***********************************************************************************************/




/*********
Android utils - comment out when not testing on mobile device
*********/


///***********************************************************************************************/
//class Discover implements Command {
//  Discover() {}
//  void execute() {
//    bt.discoverDevices();
//  }
//  void queue() {
//    system.commands.add(this);
//  }
//}
///***********************************************************************************************/



///***********************************************************************************************/
//class MakeDiscoverable implements Command {
//  MakeDiscoverable() {}
//  void execute() {
//    bt.makeDiscoverable();
//  }
//  void queue() {
//    system.commands.add(this);
//  }
//}
///***********************************************************************************************/




///***********************************************************************************************/
//class Connect implements Command {
//  Connect() {}
//  void execute() {
//    if(bt.getDiscoveredDeviceNames().size() > 0)
//      klist = newKetaiList_getDiscoveredDeviceNames();
//    else if(bt.getPairedDeviceNames().size() > 0)
//      klist = newKetaiList_getPairedDeviceNames();
//    }
//  void queue() {
//    system.commands.add(this);
//  }
//}
///***********************************************************************************************/



 
//KetaiList newKetaiList_getDiscoveredDeviceNames() {
//  return new KetaiList(this, bt.getDiscoveredDeviceNames());
//}

//KetaiList newKetaiList_getPairedDeviceNames() {
//  return new KetaiList(this, bt.getPairedDeviceNames());
//}
