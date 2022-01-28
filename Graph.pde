import java.util.*;


/** GraphMatrix
* Using a matrix to represent a bi-directional graph
*/
class GraphMatrix{
  private ArrayList<Node> nodes = new ArrayList<Node>();
  private ArrayList<ArrayList<Boolean>> edges = new ArrayList<ArrayList<Boolean>>();
  
  GraphMatrix(){
    
  }
  
  Node addNode(float x, float y){
    nodes.add(new Node(x, y));
    ArrayList<Boolean> row = new ArrayList<Boolean>();
    for(int i = 0; i < nodes.size(); i++){
      row.add(false);
    }
    edges.add(row);
    return nodes.get(nodes.size() - 1);
  }
  
  void addNode(float x, float y, String text){
    nodes.add(new Node(x, y));
    ArrayList<Boolean> row = new ArrayList<Boolean>();
    for(int i = 0; i < nodes.size(); i++){
      row.add(false);
    }
    edges.add(row);
    if(!text.equals("")){
      nodes.get(nodes.size() - 1).textBox().setText(text);
    }
  }
  
  void removeNode(Node n){
    int index = nodes.indexOf(n);
    println(index);
    nodes.remove(n);
    edges.remove(index);
    for(int i = index; i < edges.size(); i++){
      edges.get(i).remove(index);
    }
  }
  
  void addEdge(Node start, Node end){
    ArrayList<Integer> edge = new ArrayList<Integer>();
    for(int i = 0; i < nodes.size(); i++){
      if(start.equals(nodes.get(i)) || end.equals(nodes.get(i))){
        edge.add(i);
      }
    }
    edges.get(edge.get(1)).set(edge.get(0), !edges.get(edge.get(1)).get(edge.get(0)));
  }
  
  void loadEdges(int i, ArrayList<Boolean> arr){
    edges.set(i, arr);
  }
  
  void display(){
    // Display edges from edge matrix lookup
    for(int i = 0; i < edges.size(); i++){
      for(int j = 0; j < edges.get(i).size(); j++){
        if(edges.get(i).get(j)){
          line(nodes.get(i).pos().x, nodes.get(i).pos().y, nodes.get(j).pos().x, nodes.get(j).pos().y);
        }
      }
    }
    
    // Display nodes
    for(Node n : nodes){
      n.display();
    }
  }
  
  Node clickedNode(){
    for(Node n : nodes){
      if(n.clicked()){
        return n;
      }
    }
    
    return null;
  }
  
  void unfocus(){
    for(Node n : nodes){
      n.unfocus();
    }
  }
  
  String toString(){
    String result = "";
    for(ArrayList<Boolean> arr : edges){
      for(Boolean b : arr){
        result += b.toString() + " ";
      }
      result += '\n';
    }
    return result;
  }
  
  ArrayList<Node> nodeList(){
    return nodes;
  }
}
