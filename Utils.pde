/////////////////////////////////////////////////////////////////////////////////////////////////
interface Command {
  boolean executed = false;
  void execute();
  void queue();
}
/////////////////////////////////////////////////////////////////////////////////////////////////



/***********************************************************************************************/
class Configure implements Command {
  Configure() {}
  void execute() {
    system.activate(CONFIGURE_MENU);
  }
  void queue() {
    system.commands.add(this);
  }
}
/***********************************************************************************************/


/***********************************************************************************************/
class Home implements Command {
  Home() {}
  void execute() {
    system.activate(MAIN_MENU);
  }
  void queue() {
    system.commands.add(this);
  }
}
/***********************************************************************************************/



/***********************************************************************************************/
class Fly implements Command {
  Fly() {}
  void execute() {
    system.activate(FLIGHT_MENU);
  }
  void queue() {
    system.commands.add(this);
  }
}
/***********************************************************************************************/


/***********************************************************************************************/
Button newButton(Command command, String text, color c, Point point, Dimensions dimensions) {
  Button result = new Button(command,text,c,point,dimensions);
  system.mouseListener.add(result);
  return result;
}
/***********************************************************************************************/




/*********
Android utils
*********/


/***********************************************************************************************/
class Discover implements Command {
  Discover() {}
  void execute() {
    bt.discoverDevices();
  }
  void queue() {
    system.commands.add(this);
  }
}
/***********************************************************************************************/



/***********************************************************************************************/
class MakeDiscoverable implements Command {
  MakeDiscoverable() {}
  void execute() {
    bt.makeDiscoverable();
  }
  void queue() {
    system.commands.add(this);
  }
}
/***********************************************************************************************/




/***********************************************************************************************/
class Connect implements Command {
  Connect() {}
  void execute() {
    if(bt.getDiscoveredDeviceNames().size() > 0)
      klist = newKetaiList_getDiscoveredDeviceNames();
    else if(bt.getPairedDeviceNames().size() > 0)
      klist = newKetaiList_getPairedDeviceNames();
    }
  void queue() {
    system.commands.add(this);
  }
}
/***********************************************************************************************/



 
KetaiList newKetaiList_getDiscoveredDeviceNames() {
  return new KetaiList(this, bt.getDiscoveredDeviceNames());
}

KetaiList newKetaiList_getPairedDeviceNames() {
  return new KetaiList(this, bt.getPairedDeviceNames());
}
