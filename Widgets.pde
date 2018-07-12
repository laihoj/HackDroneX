/***********************************************************************************************/
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
/***********************************************************************************************/

/***********************************************************************************************/
class Dimensions {
  int leveys, korkeus;
  Dimensions(int leveys, int korkeus) {
    this.leveys = leveys;
    this.korkeus = korkeus;
  }
}
/***********************************************************************************************/


/***********************************************************************************************/
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
/***********************************************************************************************/



/////////////////////////////////////////////////////////////////////////////////////////////////
abstract class Widget extends MouseObserver {
  Point point;
  Dimensions dimensions;
  Widget(Point point, Dimensions dimensions) {
    system.mouseListener.add(this);
    this.point = point;
    this.dimensions = dimensions;
  }
  void display(){}
}
/////////////////////////////////////////////////////////////////////////////////////////////////


/***********************************************************************************************/
class Button extends Widget implements Command {
  Command command;
  String text;
  color c;
  Button(Command command, String text, color c, Point point, Dimensions dimensions) {
    super(point,dimensions);
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
    } else if(hovering) {
      fill(0,200,180);
      noStroke();
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
  Boolean isTarget() {
    return mouseX > this.point.x 
        && mouseX < this.point.x + this.dimensions.leveys 
        && mouseY > this.point.y 
        && mouseY < this.point.y + this.dimensions.korkeus;
  }
  void execute() {
    this.command.execute();
  }
  void queue() {
    system.commands.add(this);
  }
  void onHover() {}
  void onPress() {}
  void onDrag(PVector mouse) {}
  void onRelease() {
    this.queue();
  }
}
/***********************************************************************************************/


/***********************************************************************************************/
class TextBox extends Widget {
  String name;
  int font_size = DEFAULT_TEXT_SIZE;
  int modifier = LEFT;
  TextBox(String name, Point point) {
    super(point,null);
    this.name = name;
  }
  
  void display() {
    textSize(font_size);
    textAlign(modifier);
    text(name, point.x, point.y);
  }
  Boolean isTarget() {
    return false;
  }
  void onHover() {}
  void onPress() {}
  void onDrag(PVector mouse) {}
  void onRelease() {}
}
/***********************************************************************************************/


/***********************************************************************************************/
class Joystick extends Widget {
  boolean springy;
  float spring = 0.95;
  Point stick;
  float radius, innerRadius;
  PVector mouseDisplacement = new PVector(0,0);
  Joystick(Point point, Dimensions dimensions) {
    super(point,dimensions);
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
   if(this.pressed) fill(125);
   ellipse(stick.x,stick.y,innerRadius,innerRadius);
   line(point.x, point.y, stick.x, stick.y);
  }
  Boolean isTarget() {
    return this.innerRadius / 2 > sqrt((float)(Math.pow(this.stick.x - mouseX,2) + Math.pow(this.stick.y - mouseY,2)));
  }
  void onHover() {}
  void onPress() {
    this.mouseDisplacement = PVector.sub(new PVector(mouseX,mouseY),new PVector(this.stick.x,this.stick.y));
  }
  void onDrag(PVector drag) {
    this.stick.sub(drag);
  }
  void onRelease() {
    this.stick = new Point(this.point);
  }
  String toString() {
    String res = "";
    res += floor(-(min(max(point.x - stick.x,-radius),radius)  / (float)radius * OUTPUT_RANGE/2.0) + OUTPUT_RANGE/2);
    res += ",";
    res += floor(-(min(max(point.y - stick.y,-radius),radius) / (float)radius * OUTPUT_RANGE/2.0) + OUTPUT_RANGE/2);
    return res;
  }
}
/***********************************************************************************************/



/***********************************************************************************************/
class CheckBox extends Widget {
  boolean checked = false;
  boolean pressed = false;
  CheckBox(Point point, Dimensions dimensions) {
    super(point,dimensions);
  }
  void check() {
    this.checked = !this.checked;
  }
  void display() {
    if(!checked) {
      fill(255);
      stroke(0);
    } else {
      fill(0);
      noStroke();
    }
    rectMode(CORNER);
    rect(point.x,point.y,dimensions.leveys,dimensions.korkeus);
  }
  Boolean isTarget() {
    return mouseX > this.point.x 
        && mouseX < this.point.x + this.dimensions.leveys 
        && mouseY > this.point.y 
        && mouseY < this.point.y + this.dimensions.korkeus;
  }
  void onHover() {}
  void onPress() {}
  void onDrag(PVector mouse) {}
  void onRelease() {
    this.check();
  }
}
/***********************************************************************************************/
