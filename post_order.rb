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
