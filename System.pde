class System {
  MouseListener mouseListener;
  ArrayList<View> views;
  ArrayList<Command> commands;
  View active_view;
  View action_bar;
  System() {
    
    mouseListener = new MouseListener();
    views = new ArrayList<View>();
    commands = new ArrayList<Command>();
    active_view = null;
    action_bar = null;
  }
  void add(View view) {
    this.views.add(view);
  }
  void remove(View view) {
    this.views.remove(view);
  }
  void removeTopWidget() {
    int active_view_widgets_latest = active_view.widgets.size() - 1;
    if(active_view_widgets_latest > 0) {
      Widget top_widget = active_view.widgets.get(active_view_widgets_latest);
      this.active_view.remove(top_widget);
    }
  }
  void activate(View view) {
    this.active_view = view;
  }
  void display() {
    if(this.action_bar != null) {
      this.action_bar.display();
    }
    if(this.active_view != null) {
      this.active_view.display();
    }
  }
  void listen() {
    this.mouseListener.listen();
  }
  void execute() {
    for(Command command: this.commands) {
      command.execute();
    }
    this.commands = new ArrayList<Command>();
  }
}
//Activates another view
class Change_view implements Command {
  View target;
  Change_view(View target) {
    this.target = target;
  }
  void execute() {
    system.activate(target);
  }
  void queue() {
    system.commands.add(this);
  }
}

class View {
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<Widget> widgets = new ArrayList<Widget>();
  View() {
    system.add(this);
  }
  void add(Button button) {
    this.buttons.add(button);
  }
  void add(Widget widget) {
    this.widgets.add(widget);
  }
  void remove(Button button) {
    this.buttons.remove(button);
  }
  void remove(Widget widget) {
    this.widgets.remove(widget);
  }
  void display() {
    for(Button button: this.buttons) {
      button.display();
    }
    for(Widget widget: this.widgets) {
      if(widget != null) {
        widget.display();
      }
    }
  }
}