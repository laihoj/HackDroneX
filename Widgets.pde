class Point {
  int x, y;
  Point(Point point) {
    this.x = point.x;
    this.y = point.y;
  }
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void sub(Point that) {
    this.x -= that.x;
    this.y -= that.y;
  }
  void sub(PVector that) {
    this.x -= that.x;
    this.y -= that.y;
  }
  float dist(Point that) {
    return sqrt((float)(Math.pow((that.x - this.x),2) + Math.pow((that.y - this.y),2)));
  }
  float dist(PVector that) {
    return sqrt((float)(Math.pow((that.x - this.x),2) + Math.pow((that.y - this.y),2)));
  }
}

class Dimensions {
  int leveys, korkeus;
  Dimensions(int leveys, int korkeus) {
    this.leveys = leveys;
    this.korkeus = korkeus;
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

abstract class Widget extends MouseObserver {
  Point point;
  Dimensions dimensions;
  Widget() {
    system.mouseListener.add(this);
  }
  void display(){}
}

class Button extends MouseObserver implements Command {
  Command command;
  String text;
  color c;
  Point point;
  Dimensions dimensions; 
  boolean pressed = false;
  
  Button(Command command, String text, color c, Point point, Dimensions dimensions) {
    this.command = command;
    this.text = text;
    this.c = c;
    this.point = point;
    this.dimensions = dimensions;
  }
  
  void display() {
    if(pressed) {
      fill(c);
      stroke(0);
    } else {
      fill(0,132,180);
      noStroke();
    }
    rectMode(CORNER);
    rect(point.x,point.y,dimensions.leveys,dimensions.korkeus);
    fill(0);
    textAlign(CENTER);
    textSize(15);
    text(text,point.x + dimensions.leveys/2,point.y+dimensions.korkeus/2);
  }
  Boolean target(PVector mouse) {
    return mouse.x > this.point.x 
        && mouse.x < this.point.x + this.dimensions.leveys 
        && mouse.y > this.point.y 
        && mouse.y < this.point.y + this.dimensions.korkeus;
  }
  void execute() {
    this.command.execute();
  }
  void queue() {
    system.commands.add(this);
  }
  void click(PVector mouse) {
    if(target(mouse)) {
      this.pressed = true;
    }
  }
  void release(PVector mouse, PVector dragment) {
    if(target(mouse)) {
      this.queue();
    }
    this.pressed = false;
  }
}

class TextBox extends Widget {
  String name;
  int font_size = DEFAULT_TEXT_SIZE;
  int modifier = LEFT;
  TextBox(String name, Point point) {
    this.name = name;
    this.point = point;
  }
  void display() {
    textSize(font_size);
    textAlign(modifier);
    text(name, point.x, point.y);
  }
}

class Joystick extends Widget {
  float angle, distance;
  float spring = 0.95;
  Point stick;
  float radius;
  float innerRadius;
  PVector mouseDisplacement = new PVector(0,0);
  Joystick(Point point, Dimensions dimensions) {
    this.point = point;
    this.stick = new Point(point);
    this.dimensions = dimensions;
    this.radius = dimensions.leveys / 2;
    this.innerRadius = radius * 0.3;
  }
  void display() {
   stroke(0);
   noFill();
   point(point.x,point.y);
   ellipse(point.x,point.y,dimensions.korkeus,dimensions.leveys);
   if(selected) fill(125);
   ellipse(stick.x,stick.y,innerRadius,innerRadius);
   line(point.x, point.y, stick.x, stick.y);
  }
  Boolean target(PVector mouse) {
    return this.innerRadius / 2 > this.stick.dist(mouse);
  }
  void click(PVector mouse) {
    super.click(mouse);
    this.mouseDisplacement = PVector.sub(mouse,new PVector(this.stick.x,this.stick.y));
  }
  void drag(PVector drag) {
    if(this.selected) {
      this.stick.sub(drag);
    }
  }
  void release(PVector mouse, PVector dragment) {
    if(this.selected) {
      this.stick = new Point(this.point);
    }
    super.release(mouse,dragment);
  }
  String toString() {
    String res = "";
    res += floor(-(min(max(point.x - stick.x,-radius),radius)  / (float)radius * OUTPUT_RANGE/2.0) + OUTPUT_RANGE/2);
    res += ",";
    res += floor(-(min(max(point.y - stick.y,-radius),radius) / (float)radius * OUTPUT_RANGE/2.0) + OUTPUT_RANGE/2);
    return res;
  }
}

//class Slider extends Widget {
//  int value = 20;
//  Slider(Point point, Dimensions dimensions) {
//    this.point = point;
//    this.dimensions = dimensions;
//  }
//  void display() {
//    noFill();
//    stroke(0);
//    rect(point.x,point.y,dimensions.leveys,dimensions.korkeus);
//    fill(125);
//    noStroke();
//    rect(point.x, point.y - (dimensions.korkeus * value / 100),dimensions.leveys, dimensions.korkeus * value / 100);
//  }
//}
//class main_screen extends Widget {
//  main_screen(int x, int y, int wide,int tall) {
//    this.x = x;
//    this.y = y;
//    this.wide = wide;
//    this.tall = tall;
//  }
//  void display() {
//    stroke(0);
//    fill(255);
//    rect(this.x,this.y,this.wide,this.tall);
//    fill(0);
//    text("main screen",this.x + this.wide/2 + 15, this.y + this.tall/2 + 15);
//  }
//}

//class info_bar extends Widget {
//  info_bar(int x, int y, int wide,int tall) {
//    this.x = x;
//    this.y = y;
//    this.wide = wide;
//    this.tall = tall;
//  }
//  void display() {
//    stroke(0);
//    fill(255);
//    rect(this.x,this.y,this.wide,this.tall);
//    fill(0);
//    text("info bar",this.x + this.wide/2 + 15, this.y + this.tall/2 + 15);
//  }
//}