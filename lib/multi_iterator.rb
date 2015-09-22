class MultiIterator
  include Enumerable

  def initialize *iterators
    @iterators = iterators
  end

  def each
    loop do
      values = next_values
      break if values.empty?
      yield values.sort_by {|k,v| v }.first.first.next
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
