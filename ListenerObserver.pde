interface Listener {
  void listen();
}
class MouseListener implements Listener {
  boolean wasMousePressed = false;
  PVector mousePos = new PVector(0,0);
  PVector prevMousePos = new PVector(0,0);
  PVector dragment = new PVector(0,0);
  ArrayList<MouseObserver> observers = new ArrayList<MouseObserver>();
  MouseListener() {
  }
  void add(MouseObserver observer) {
    this.observers.add(observer);
  }
  void listen() {
    if(mousePressed) {
      this.mousePos = new PVector(mouseX,mouseY);
      if(!wasMousePressed) {
        this.dragment.setMag(0);
        this.prevMousePos = new PVector(mouseX,mouseY);
        for(MouseObserver observer: this.observers) {
          observer.click(this.mousePos);
        }
      }
      if(this.mousePos != this.prevMousePos) {
        this.dragment = PVector.sub(this.prevMousePos,this.mousePos);
        for(MouseObserver observer: this.observers) {
          observer.drag(this.dragment);
        }
      }
    }
    if(wasMousePressed && !mousePressed) {
      for(MouseObserver observer: this.observers) {
        observer.release(mousePos, dragment);
      }
    }
    
    this.prevMousePos = new PVector(mousePos.x, mousePos.y);
    this.wasMousePressed = mousePressed;
  }
}

abstract class MouseObserver {
  boolean selected = false;
  PVector pos = new PVector(0,0);

  void connectListener(MouseListener listener) {
    listener.add(this);
  }
  void click(PVector mouse) {
    if(this.target(mouse)) {
      this.selected = true;
    }
  }
  void drag(PVector mouse) {
    if(this.selected) {
    }
  }
  void release(PVector mouse, PVector dragment) {
    this.selected = false;
  }
  Boolean target(PVector mouse) {
    return false;
  }
}


interface Command {
  boolean executed = false;
  void execute();
  void queue();
}

class Point {
  int x, y;
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

class Dimensions {
  int leveys, korkeus;
  Dimensions(int leveys, int korkeus) {
    this.leveys = leveys;
    this.korkeus = korkeus;
  }
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

Button newButton(Command command, String text, color c, Point point, Dimensions dimensions) {
  Button result = new Button(command,text,c,point,dimensions);
  system.mouseListener.add(result);
  return result;
}