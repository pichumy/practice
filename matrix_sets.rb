def matrix_set(matrix)
  x_length = matrix.length
  y_length = matrix[0].length
  # the +1 here is to reserve one index to define what an "edge" is. I'm going to be using the very last index as the edge.
  union_object = WeightedQuickUnion.new(x_length * y_length + 1)
  edge_index = x_length * y_length
  matrix.each_with_index do |array, row|
    array.each_with_index do |value, column|
      # map the row, column combination to the correct index in union_object
      index = row * y_length + column
      # we only care if the value is 1
      if value == 1
        # case that value is on an edge
        if row == 0 || row == (x_length - 1) || column == 0 || column == (y_length - 1)
          union_object.union(index, edge_index)
        end
        # Check top
        if row > 0 && matrix[row - 1][column] == 1
          union_object.union(index, index - y_length)
        end
        # check bottom
        if row < x_length - 1 && matrix[row + 1][column] == 1
          union_object.union(index, index + y_length)
        end
        # check left
        if column > 0 && matrix[row][column - 1] == 1
          union_object.union(index, index - 1)
        end
        # check right
        if column < y_length - 1 && matrix[row][column + 1] == 1
          union_object.union(index, index + 1)
        end
      end
    end
  end
  matrix.each_with_index do |array, row|
    array.each_with_index do |value, column|
      index = row * y_length + column
      # change all elements to 0 except for the ones connected
      if value == 1
        unless union_object.connected(index, edge_index)
          matrix[row][column] = 0
        end
      end
    end
  end
  matrix
end

class WeightedQuickUnion
  # O(n)
  def initialize(size)
    # Store is an integer array
    @store = Array.new(size)
    # sizeStore is another array that is used to ensure log(n) trees
    @sizeStore = Array.new(size);
    idx = 0
    while idx < size
      @store[idx] = idx
      @sizeStore[idx] = 1
      idx += 1
    end
  end
  # find the root of a certain index
  # O(logn)
  def root(index)
    return index if index == @store[index]
    root(@store[index])
  end
  # checks if two elements are in the same set
  # O(logn)
  def connected(index1, index2)
    root(index1) == root(index2)
  end
  # O(logn)
  def union(index1, index2)
    i = @store[index1]
    j = @store[index2]
    return if i == j
    if @sizeStore[i] < @sizeStore[j]
      @store[i] = j
      @sizeStore[j] += @sizeStore[i]
    else
      @store[j] = i
      @sizeStore[i] += @sizeStore[j]
    end
  end
end

input = [[1,1,0,0,0,1,1], [0,0,1,0,0,1,0], [1,0,1,0,0,0,1], [0,0,0,0,1,0,0], [1,1,1,1,1,1,1]]

print matrix_set(input)
