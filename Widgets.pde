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
  int[] dims;
  Dimensions(int... dims) {
    this.dims = dims;
  }
}
/***********************************************************************************************/


/***********************************************************************************************/
class View {
  String name;
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<Widget> widgets = new ArrayList<Widget>();
  View() {
    system.add(this);
    this.name = "This view is anonymous";
  }
  View(String name) {
    system.add(this);
    this.name = name;
  }
  String toString() {
    return this.name;
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
interface Displayable {
  void display();
}
/////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////
abstract class Widget extends MouseObserver implements Displayable {
  Point point;
  Dimensions dimensions;
  Widget(Point point, Dimensions dimensions) {
    system.mouseListener.add(this);
    this.point = point;
    this.dimensions = dimensions;
  }
}

/*
To describe a widget, one must describe its location, its dimensions, how it is displayed,
and how it a user's mouse inputs interact with it.
For example, a rectangular item's dimensions might be its width and height, while 
a circular item's dimensions might better be described by its radius.

The Joystick's dimensions are the radius of the outer circle, and the radius of the inner circle
*/
class Widget_Placeholder extends Widget {
  Widget_Placeholder(Point point, Dimensions dimensions) {
    super(point,dimensions);
  }
  void display() {}
  Boolean isTarget() {return null;}
  void onHover() {}
  void onPress() {}
  void onDrag(PVector mouse) {}
  void onRelease() {}
}
/***********************************************************************************************/
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
    rect(point.x,point.y,dimensions.dims[0],dimensions.dims[1]);
    fill(0);
    textAlign(CENTER);
    textSize(15);
    text(text,point.x + dimensions.dims[0]/2,point.y+dimensions.dims[1]/2);
  }
  Boolean isTarget() {
    return mouseX > this.point.x 
        && mouseX < this.point.x + this.dimensions.dims[0] 
        && mouseY > this.point.y 
        && mouseY < this.point.y + this.dimensions.dims[1];
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


//The dimensions.dim[0] refers to the diameter of the outer circle, [1] is the inner circle  
/***********************************************************************************************/
class Joystick extends Widget {
  boolean springy;
  float spring = 0.95;
  Point stick;
  //float radius, innerRadius;
  PVector mouseDisplacement = new PVector(0,0);
  Point resting;
  Joystick(Point point, Dimensions dimensions) {
    super(point,dimensions);
    this.point = point;
    this.dimensions = dimensions;
    //this.radius = dimensions.leveys / 2;
    //this.innerRadius = radius * 0.3;
    this.stick = new Point(this.point.x, this.point.y + (int)this.getRadius());
    this.resting = new Point(point);
  }
  int getRadius() {
    return dimensions.dims[0] / 2;
  }
  void rest() {
    this.stick = new Point(resting);
  }
  Joystick setResting(Point point) {
    this.resting = point;
    return this;
  }
  void display() {
   stroke(0);
   noFill();
   point(point.x,point.y);
   //ellipse(point.x,point.y,dimensions.korkeus,dimensions.leveys);
   ellipse(point.x,point.y,dimensions.dims[0],dimensions.dims[0]);
   if(this.pressed) fill(125);
   //ellipse(stick.x,stick.y,innerRadius,innerRadius);
   ellipse(stick.x,stick.y,dimensions.dims[1],dimensions.dims[1]);
   line(point.x, point.y, stick.x, stick.y);
  }
  Boolean isTarget() {
    return this.dimensions.dims[1] / 2 > sqrt((float)(Math.pow(this.stick.x - mouseX,2) + Math.pow(this.stick.y - mouseY,2)));
  }
  void onHover() {}
  void onPress() {
    this.mouseDisplacement = PVector.sub(new PVector(mouseX,mouseY),new PVector(this.stick.x,this.stick.y));
  }
  void onDrag(PVector drag) {
    this.stick.sub(drag);
    output_state();
    //String message = "$" + leftStick.toString() + "," + rightStick.toString();
    //println(message);
    //myPort.write(message);
  }
  void onRelease() {
    this.rest();
    output_state();
  }
  String toString() {
    String res = "";
    res += (int)OUTPUT_RANGE - floor(-(min(max(point.y - stick.y,-getRadius()),getRadius()) / (float)getRadius() * OUTPUT_RANGE/2.0) + OUTPUT_RANGE/2);
    res += ",";
    res += floor(-(min(max(point.x - stick.x,-getRadius()),getRadius())  / (float)getRadius() * OUTPUT_RANGE/2.0) + OUTPUT_RANGE/2);
    return res;
  }
}
/***********************************************************************************************/



/***********************************************************************************************/
class CheckBox extends Widget {
  boolean checked = false;
  CheckBox(Point point, Dimensions dimensions) {
    super(point,dimensions);
  }
  void check() {
    this.checked = !this.checked;
  }
  void display() {
    if(checked) {
      fill(0);
      noStroke();
    } else if(isTarget()) {
      fill(125);
      stroke(0);
    } else {
      fill(255);
      stroke(0);
    }
    rectMode(CORNER);
    rect(point.x,point.y,dimensions.dims[0],dimensions.dims[1]);
  }
  Boolean isTarget() {
    return mouseX > this.point.x
        && mouseX < this.point.x + this.dimensions.dims[0] 
        && mouseY > this.point.y 
        && mouseY < this.point.y + this.dimensions.dims[1];
  }
  void onHover() {}
  void onPress() {}
  void onDrag(PVector mouse) {}
  void onRelease() {
    this.check();
  }
}
/***********************************************************************************************/


/***********************************************************************************************/
class Slider extends Widget {
  Slider(Point point, Dimensions dimensions) {
    super(point,dimensions);
  }
  String toString() {
    return str(floor(this.getValue() * OUTPUT_RANGE));
  }
  float getValue() {
    return this.dimensions.dims[2] / (float)this.dimensions.dims[1];
  }
  void setHeight(int Height) {
    this.dimensions.dims[2] = (int)limit(Height,0,dimensions.dims[1]);
  }
  void display() {
    text(getValue(),this.point.x, this.point.y - 15);
    fill(255);
    stroke(0);
    rect(point.x, point.y, dimensions.dims[0],dimensions.dims[1]);
    fill(0);
    rect(point.x, point.y + dimensions.dims[1], dimensions.dims[0], -dimensions.dims[2]);
  }
  Boolean isTarget() {
    return mouseX > this.point.x
        && mouseX < this.point.x + this.dimensions.dims[0] 
        && mouseY > this.point.y 
        && mouseY < this.point.y + this.dimensions.dims[1];
  }
  void onHover() {}
  void onPress() {
    setHeight(-mouseY + point.y + dimensions.dims[1]);
  }
  void onDrag(PVector mouse) {
    setHeight(-mouseY + point.y + dimensions.dims[1]);
    slider_output_state();
  }
  void onRelease() {
    slider_output_state();
  }
}
/***********************************************************************************************/