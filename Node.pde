class Node{
  private PVector pos;
  private ArrayList<Node> edges = new ArrayList<Node>();
  boolean focus = false;
  TextBox t = null;
  
  private final int radius = 50;
  
  Node(float x, float y){
    this.pos = new PVector(x, y);
  }
  
  Node(PVector pos){
    this.pos = pos.copy();
  }
  
  void connect(Node other){
    edges.add(other);
  }
  
  ArrayList<Node> getEdges(){
    return edges;
  }
  
  void display(){
    if(this.focus){
      fill(230, 230, 255);
    }
    ellipse(pos.x, pos.y, radius, radius);
    fill(255);
  }
  
  PVector pos(){
    return pos.copy();
  }
  
  void setPos(float x, float y){
    this.pos = new PVector(x, y);
    if(t != null){
      t.setPos(x, y);
    }
  }
  
  boolean clicked(){
    return dist(mouseX, mouseY, pos.x, pos.y) < radius/2;
  }
  
  void focus(){
    this.focus = true;
    if(t != null){
      t.focus();
    }
  }
  
  void unfocus(){
    this.focus = false;
    if(t != null){
      t.unfocus();
    }
  }
  
  TextBox textBox(){
    if(t == null){
      t = new TextBox(pos.x, pos.y);
    }
    return t;
  }
}
