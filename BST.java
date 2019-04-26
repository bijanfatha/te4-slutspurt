

class BST  
{ 
  
  
  class Node  
  { 
   int key; 
    Node left, right; 

    public Node(int item)  
    { 
       key = item; 
        left = right = null; 
    } 
  } 

  Node root; 

  // The constructors name must be the same as the class namee
  BST() {  
    root = null;  
  } 


  void insert(int key) { 
    root = insertOrder(root, key); 
  } 

  Node insertOrder(Node root, int key) { 

    if (root == null) { 
        root = new Node(key); 
        return root; 
      } 

    if (key < root.key) 
        root.left = insertOrder(root.left, key); 
    else if (key > root.key) 
        root.right = insertOrder(root.right, key); 
    return root; 
  } 

  void inorder(Node root) { 
      if (root != null) { 
        inorder(root.left); 
        System.out.print(root.key + " "); 
        inorder(root.right); 
      } 
    } 
    void treePath(int array[]) { 
      for(int i = 0; i < array.length; i++) { 
          insert(array[i]); 
        } 
        
    } 

  public static void main (String[] args) 
  { 
    BST tree = new BST();
    int array [] = {7,5,9,2,1,11};
    tree.treePath(array);
    tree.inorder(tree.root);
  }    
}

