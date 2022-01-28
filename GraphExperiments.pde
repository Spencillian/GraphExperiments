GraphMatrix g = new GraphMatrix();
Node focus = null, pfocus = null;
S state = S.create;
ArrayList<TextBox> boxes = new ArrayList<TextBox>();

final int TEXTSIZE = 32;

void setup(){
  size(2000, 2000);
  textAlign(CENTER, CENTER);
  textLeading(TEXTSIZE/2);
  
  textSize(TEXTSIZE);
  rectMode(CENTER);
  
  JSONObject json = loadJSONObject("save.json");
  
  JSONArray arr = json.getJSONArray("nodes");
  
  for(int i = 0; i < arr.size(); i++){
    JSONObject node = arr.getJSONObject(i);
    g.addNode(node.getFloat("x"), node.getFloat("y"), node.getString("text"));
    
  }
  
  String edgesTable[] = json.getString("edgesTable").split("\n");
  
  for(int i = 0; i < edgesTable.length; i++){
    ArrayList<Boolean> across = new ArrayList<Boolean>();
    for(String s : edgesTable[i].split(" ")){
      across.add(s.equals("true"));
    }
    g.loadEdges(i, across);
  }
  
  
  /*TODO: Deserialize from data/save.json
  - New functions
    - Create nodes from file reads
    - Take string of edges data and return it to arraylist form
    - TextBox setText
  */
  
}

/**
Interations
- Create new node
  - mouseReleased on nothing
- Move node
  - Mouse dragged
- Create new link
  - you need to rethink this part because its the main things tripping you up
- Delete node
  - pressing delete key when node is selected or shift + click (need to choose one)
- Label node
  - Select node and start typing
  
Architechure
- Click to create node
- Click node to select it
- Click off node to deselect
- Click selected node to start link
  - When link started:
    - Clicking on another node creates link
    - Clicking nothing gets rid of link

states?
- create
- connect
- select

Load save from json data file
What data?
- Graph
  - Nodes
  - Edge Table
- Nodes
  - Position
  - TextBox
- Edge Table
  - toString()
- TextBox
  - Text

*/
enum S{
  create,
  select,
  connect,
  drag,
}

void draw(){
  background(200);
  g.display();
  if(state == S.connect && focus != null){
    line(mouseX, mouseY, focus.pos().x, focus.pos().y);
  }
  for(TextBox t : boxes){
    t.display();
  }
}

void mouseReleased(){
  pfocus = focus;
  focus = g.clickedNode();
  if(focus != null){
    g.unfocus();
    focus.focus();
    if(pfocus != null){
      if(focus.equals(pfocus) && state != S.drag){ 
        state = S.connect;
      }else{
        if(state == S.connect){
          g.addEdge(pfocus, focus);
        }
        state = S.select;
      }
    }
  }else{
    if(state == S.connect){ // TODO: Edge case - pfocus = null
      state = S.select;
      focus = pfocus;
      if(focus != null){
        focus.focus();
      }
      pfocus = null;
      return;
    }
    state = S.create;
    focus = g.addNode(mouseX, mouseY);
    g.unfocus();
    focus.focus();
  }
}

void mouseDragged(){
  focus = g.clickedNode();
  if(focus != null){
    state = S.drag;
    focus.setPos(mouseX, mouseY);
  }
}

void keyPressed(){ // Implement the textboxes on top of nodes
  if(focus != null){
    if(key == CODED){
      return;
    }
    
    if(keyCode == TAB || keyCode == RETURN || keyCode == ESC || keyCode == ENTER || keyCode == RETURN){
      return;
    }
    
    if(keyCode == BACKSPACE || keyCode == DELETE){
      if(focus.textBox().backspace()){
        g.removeNode(focus);
        focus = null;
        pfocus = null;
        g.unfocus();
      }
      return;
    }
    
    focus.textBox().editText(key);
  }
}

void exit(){ // TODO: Add a note somewhere about ESC and only ESC saving on exit
  JSONObject json = new JSONObject();
  json.setString("edgesTable", g.toString());
  
  JSONArray jarr = new JSONArray();
  for(int i = 0; i < g.nodeList().size(); i++){ // Need to make sure that the data in the edge table matches the order of the node array
    JSONObject node = new JSONObject();
    node.setFloat("x", g.nodeList().get(i).pos.x);
    node.setFloat("y", g.nodeList().get(i).pos.y);
    node.setString("text", g.nodeList().get(i).textBox().toString());
    
    jarr.setJSONObject(i, node);
  }
  
  json.setJSONArray("nodes", jarr);
  saveJSONObject(json, "data/save.json");
  
  super.exit();
}
