/////////////////////////////////////////////////////////////////////////////////////////////////
interface Listener {
  void listen();
}
/////////////////////////////////////////////////////////////////////////////////////////////////



/***********************************************************************************************/
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
    for(MouseObserver observer: this.observers) {
      observer.hover(this.mousePos);
    }
    if(mousePressed) {
      this.mousePos = new PVector(mouseX,mouseY);
      
      if(!wasMousePressed) {
        this.dragment.setMag(0);
        this.prevMousePos = new PVector(mouseX,mouseY);
        for(MouseObserver observer: this.observers) {
          observer.press(this.mousePos);
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
/***********************************************************************************************/




/////////////////////////////////////////////////////////////////////////////////////////////////
interface MouseActivities {
  Boolean isTarget();
  void onHover();
  void onPress();
  void onDrag(PVector mouse);
  void onRelease();
}
/////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////
abstract class MouseObserver implements MouseActivities {
  boolean pressed, hovering;
  PVector pos = new PVector(0,0);
  void connectListener(MouseListener listener) {
    this.pressed = false;
    this.hovering = false;
    listener.add(this);
  }
  void hover(PVector mouse) {
    if(this.isTarget()) {
      this.hovering = true;
      this.onHover();
    } else {
      this.hovering = false;
    }
  }
  void press(PVector mouse) {
    if(this.isTarget()) {
      this.pressed = true;
      this.onPress();
    }
  }
  void drag(PVector mouse) {
    if(this.pressed && PVector.dist(new PVector(pmouseX, pmouseY), new PVector(mouseX, mouseY)) > 0) {
      this.onDrag(mouse);
    }
  }
  void release(PVector mouse, PVector dragment) {
    if(this.pressed && this.isTarget()) {
      this.onRelease();
    }
    this.pressed = false;    
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////