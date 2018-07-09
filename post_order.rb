require_relative 'binary_search_tree'

def post_order(tree_node, arr = [])
  if tree_node.left.nil? && tree_node.right.nil?
    arr.push(tree_node.value)
    return
  end
  if tree_node.left
    post_order(tree_node.left, arr)
  end
  if tree_node.right
    post_order(tree_node.right, arr)
  end
  arr.push(tree_node.value)
end

def pre_order(tree_node, arr = [])
    return if tree_node.nil?
    arr.push(tree_node.value)
    pre_order(tree_node.left, arr)
    pre_order(tree_node.right, arr)
    arr
end

def lca(tree_node, node1, node2)
  left = false
  right = false
  if node1.value > tree_node.value || node2.value > tree_node.value
    right = true
  end
  if node1.value <= tree_node.value || node2.value <= tree_node.value
    left = true
  end
  # case that they are in different subtrees
  if left && right
    return tree_node
  # case they are both in left subtree
  elsif left
    return lca(tree_node.left, node1, node2)
  # case they are in right subtree
  elsif right
    return lca(tree_node.right, node1, node2)
  end
end
# find next largest value in a BST when given a node to compare
def next_largest(node)
  if node.right
    return left_most(node.right)
  end
  greater_parent(node.parent,node.value)
end
# helper method for next_largest
def left_most(node)
  if node.left
    left_most(node.left)
  else
    node
  end
end
# helper method for next_largest 
def greater_parent(parent, value)
  if parent.value > value
    return parent
  else
    if parent.parent.nil?
      return nil
    else
      greater_parent(parent.parent, value)
    end
  end
end

# create a BST
bst = BinarySearchTree.new
numbers = [5,2,3,1,7,4]
numbers.each do |el|
  bst.insert(el)
end

print post_order(bst.root)
print "\n"
print pre_order(bst.root)
print "\n"
# expect bst.root.left to be returned, or Node(2)
p lca(bst.root, bst.root.left.left, bst.root.left.right).value
