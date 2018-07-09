abstract class Widget extends MouseObserver {
  Point point;
  Dimensions dimensions;
  Widget() {
    system.mouseListener.add(this);
  }
  void display(){}
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