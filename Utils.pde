class Configure implements Command {
  Configure() {}
  void execute() {
    system.activate(CONFIGURE_MENU);
  }
  void queue() {
    system.commands.add(this);
  }
}

class Home implements Command {
  Home() {}
  void execute() {
    system.activate(MAIN_MENU);
  }
  void queue() {
    system.commands.add(this);
  }
}

class Fly implements Command {
  Fly() {}
  void execute() {
    system.activate(FLIGHT_MENU);
  }
  void queue() {
    system.commands.add(this);
  }
}