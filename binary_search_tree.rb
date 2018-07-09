require_relative 'bst_node'

class BinarySearchTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def insert(value, tree_node = @root)
    # It reaches the bottom of the tree
    return @root = BSTNode.new(value) if @root.nil?
    if tree_node.value >= value
      if tree_node.left.nil?
        new_node = BSTNode.new(value)
        tree_node.left = new_node
        new_node.parent = tree_node
      else
        insert(value, tree_node.left)
      end
    else
      if tree_node.right.nil?
        new_node = BSTNode.new(value)
        tree_node.right = new_node
        new_node.parent = tree_node
      else
        insert(value, tree_node.right)
      end
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if tree_node.value == value
    return find(value, tree_node.left) if tree_node.value >= value
    return find(value, tree_node.right) if tree_node.value < value
  end

  def delete(value, tree_node = @root)
    delete_node = find(value, @root)
    return @root = nil if delete_node == @root
    return nil if delete_node.nil?
    # case two children
    if delete_node.left && delete_node.right
      left_subtree = delete_node.left
      max_node = maximum(left_subtree)
      delete_node.value = max_node.value
      # case that no values on the right of left subtree
      if delete_node.left == max_node
        # case has left children
        if max_node.left
          max_node.left.parent = delete_node
          delete_node.left = max_node.left
          delete_node.value = max_node.value
          max_node.left = nil
          max_node.parent = nil
        # case no left children
        else
          delete_node.left = nil
        end
        # case there were right children
      else
        delete_node.value = max_node.value
        # case max_node has values to the left
        if max_node.left
          max_node.parent.right = max_node.left
          max_node.parent = nil
          max_node.left = nil
        else
          max_node.parent.right = nil
          max_node.parent = nil
        end
      end
      # only left child, no right child
    elsif delete_node.left
      parent = delete_node.parent
      if parent.value > delete_node.left.value
        parent.left = delete_node.left
        delete_node.left.parent = parent
      else
        parent.right = delete_node.left
        delete_node.left.parent = parent
      end
      # only right child
    elsif delete_node.right
      parent = delete_node.parent
      if parent.value > delete_node.right.value
        parent.left = delete_node.right
        delete_node.right.parent = parent
      else
        parent.right = delete_node.right
        delete_node.right.parent = parent
      end
    # no children
    else
      parent = delete_node.parent
      if parent.value > delete_node.value
        parent.left = nil
        delete_node.parent = nil
      else
        parent.right = nil
        delete_node.parent = nil
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?
    left = depth(tree_node.left) + 1
    right = depth(tree_node.right) + 1
    if left > right
      return left
    else
      return right
    end
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    left_depth = depth(tree_node.left)
    right_depth = depth(tree_node.right)
    if (left_depth - right_depth).abs > 1
      false
    else
      is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
    end
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return arr if tree_node.nil?
    in_order_traversal(tree_node.left, arr)
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr)
    arr
  end



end
