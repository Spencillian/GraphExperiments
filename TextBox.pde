class TextBox{
  PVector pos;
  String text = "";
  boolean focus = false;
  
  TextBox(float x, float y){
    pos = new PVector(x, y);
    boxes.add(this);
  }
  
  /* Functions
  - Create TextBox
  - Focus TextBox
    - Edit TextBox
  - Delete TextBox
  - Move TextBox
  */
  
  void display(){
    if(focus){
      fill(240, 240, 255);  
    }else{
      fill(255);
    }
    
    rect(pos.x, pos.y, textWidth(text) + 10, TEXTSIZE);
    fill(0);
    text(text, pos.x, pos.y - TEXTSIZE/5);
    fill(255);
  }
  
  boolean clicked(){
    if(mouseX > this.pos.x - ((textWidth(text) + 10)/2) && mouseX < this.pos.x + ((textWidth(text) + 10)/2)){
      if(mouseY > this.pos.y - (TEXTSIZE/2) && mouseY < this.pos.y + (TEXTSIZE/2)){
        return true;
      } 
    }
    return false;
  }
  
  void focus(){
    focus = true;
  }
  
  void unfocus(){
    focus = false;
  }
  
  void editText(char t){
    text += t;
  }
  
  boolean backspace(){
    if(text.length() > 0){
      text = text.substring(0, text.length() - 1);
      return false;
    }else{
      boxes.remove(this);
      return true;
    }
  }
  
  void setPos(float x, float y){
    this.pos = new PVector(x, y);
  }
  
  void setText(String text){
    this.text = text;
  }
  
  String toString(){
    return text;
  }
}
