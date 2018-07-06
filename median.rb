require_relative 'heap'

class MedianStream
  attr_reader :minheap, :maxheap
  def initialize()
    # Min heap holds the big values
    @minheap = BinaryMinHeap.new([], &Proc.new { |parent, child| parent <=> child })
    # Max heap holds small values
    @maxheap = BinaryMinHeap.new([], &Proc.new { |parent, child| child <=> parent })
  end

  def add(val)
    # Add to maxheap if both are empty
    return @maxheap.push(val) if @minheap.count == 0 && @maxheap.count == 0
    # Case for max heap being bigger
    if @maxheap.count > @minheap.count
      if @maxheap.peek > val
        val2 = @maxheap.extract
        @minheap.push(val2)
        @maxheap.push(val)
      else
        @minheap.push(val)
      end
    # Case for min heap being bigger
    elsif @minheap.count > @maxheap.count
      if val > @minheap.peek
        val2 = @minheap.extract
        @maxheap.push(val2)
        @minheap.push(val)
      else
        @maxheap.push(val)
      end
    # Case for being the same length
    elsif @minheap.count == @maxheap.count
      if val >= @minheap.peek
        @minheap.push(val)
      else
        @maxheap.push(val)
      end
    end

  end

  def find_median
    return (@minheap.peek + @maxheap.peek) / 2.0 if @minheap.count == @maxheap.count
    return @minheap.peek if @minheap.count > @maxheap.count
    return @maxheap.peek if @maxheap.count > @minheap.count
  end
end
