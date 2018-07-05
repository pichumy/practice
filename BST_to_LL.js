// This is the O(n) solution
const BST_to_LL = (tree) => {
    // Receiving a tree means receiving the root node of a tree
    // First implement dfs
    let array = dfs(tree);
    // turn this into an array of nodes
    let nodes = [];
    array.forEach(val => {
      let node = new Node(val);
      nodes.push(node)
    })
    // reassign pointers
    let linkedList = nodes.map( (node, idx) => {
      if(idx > 0){
        prev = idx - 1;
        next = idx + 1;
      }
      if(idx === 0){
        next = idx + 1;
        prev = array.length - 1
      }
      if(idx === array.length - 1){
        next = 0;
        prev = idx - 1
      }
      node.next = array[next];
      node.prev = array[prev];
      return node;
    })
    return linkedList;
}
// this isn't necessarily faster in terms of time complexity, but it is O(N) space complexity
const efficient_BST_to_LL = (head) => {
  let last_node = efficient_dfs(head);
  let lowest_node = find_lowest(head);
  last_node.next = lowest_node;
  lowest_node.prev = last_node;
  return lowest_node;
}

const find_lowest = (node) => {
  if(node.left === undefined){
    return node;
  }
  return find_lowest(node.left);
}

const efficient_dfs = (node) => {
  if(node.left === undefined && node.right === undefined){
    return node;
  }else if(node.left === undefined){
    return efficient_dfs(node.right);
  }else if(node.right === undefined){
    return efficient_dfs(node.left);
  }
  left = efficient_dfs(node.left);
  right = efficient_dfs(node.right);
  left.next = node;
  node.prev = left;
  node.next = right;
  right.prev = node;
  return right;
}

class Node {
  constructor(val){
    this.next = undefined;
    this.prev = undefined;
    this.val = val
  }
}

const dfs = (node) => {
  // dfs
  if(node.left === undefined && node.right === undefined){
    return [node.val]
  }else if(node.left === undefined){
    return dfs(node.right)
  }else if(node.right === undefined){
    return dfs(node.left)
  }
  left = dfs(node.left)
  right = dfs(node.right)
  return left.concat(node.val).concat(right)
}
class TreeNode {
  constructor(val){
    this.left = undefined;
    this.right = undefined;
    this.val = val
  }
}

let root = new TreeNode(6);
let node1 = new TreeNode(3);
let node2 = new TreeNode(7);
root.left = node1;
root.right = node2;
let node3 = new TreeNode(0);
let node4 = new TreeNode(4);
node1.left = node3;
node1.right = node4;

let node = efficient_BST_to_LL(root);
console.log(node);
// linkedList.forEach(node => {
//   console.log("This node: ", node.val);
//   console.log("next: ", node.next);
//   console.log("prev: ", node.prev);
// });
