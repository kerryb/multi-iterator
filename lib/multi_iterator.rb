class MultiIterator
  class IteratorOutOfOrder < RuntimeError
  end

  include Enumerable

  def initialize *iterators
    @iterators = iterators
  end

  def each
    loop do
      values = next_values
      break if values.empty?
      iterator, value = values.sort_by {|k,v| v }.first
      iterator.next
      begin
        raise IteratorOutOfOrder if value > iterator.peek
      rescue StopIteration
      end
      yield value
    end
  end

  private

  def next_values
    @iterators.each_with_object({}) do |iterator, values|
      begin
        values[iterator] = iterator.peek
      rescue StopIteration
        next
      end
    end
  end
end
