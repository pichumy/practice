require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |parent, child| child <=> parent }
    self.each_with_index do |_, idx|
      self[0..idx] = BinaryMinHeap.heapify_up(self[0..idx], idx, self[0..idx].length, &prc)
    end
    # sort
    i = self.length - 1
    while i > 0
      self[0], self[i] = self[i], self[0]
      self[0...i].each_with_index do |_, _|
        self[0...i] = BinaryMinHeap.heapify_down(self[0...i], 0, self[0...i].length, &prc)
      end
      i -= 1
    end
    self
  end
end
