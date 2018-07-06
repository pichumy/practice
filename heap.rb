class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(store = [],&prc)
    @store = store
    @prc = prc || Proc.new { |parent, child| parent <=> child }
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    return [1,2] if parent_index == 0 && len > 2
    return [1] if parent_index == 0 && len == 2
    return [] if parent_index == 0 && len == 1
    indices = []
    indices.push(2 * parent_index + 1) if (2 * parent_index + 1 < len)
    indices.push(2 * parent_index + 2) if (2 * parent_index + 2 < len)
    indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    return child_index / 2 if child_index % 2 == 1
    child_index / 2 - 1
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    children = BinaryMinHeap.child_indices(len, parent_idx)
    # default ascending
    prc = prc || Proc.new { |parent, child| parent <=> child }

    # children[0] should hold the largest or smallest element depending on what
    # the proc is checking against.
    # This method is to sort children in correct order
    if children.length > 1 && prc.call(array[children[0]], array[children[1]]) > 0
        children[0], children[1] = children[1], children[0]
    end

    # I only ever have to check against the first child due to sorting child0 to have priority
    if children.length > 0 && prc.call(array[parent_idx], array[children[0]]) >= 0
      array[parent_idx], array[children[0]] = array[children[0]], array[parent_idx]
      BinaryMinHeap.heapify_down(array, children[0], array.length, &prc)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    # default ascending
    prc = prc || Proc.new { |parent, child| parent <=> child }
    # root has no parents
    return array if child_idx == 0
    parent = BinaryMinHeap.parent_index(child_idx)
    if prc.call(array[parent], array[child_idx]) >= 0
      # swap parent and child based on proc
      array[parent], array[child_idx] = array[child_idx], array[parent]
      BinaryMinHeap.heapify_up(array, parent, array.length, &prc) if parent != 0
    end
    array
  end
end
