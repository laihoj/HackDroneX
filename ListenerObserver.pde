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
