class MultiIterator
  include Enumerable

  def initialize *iterators
    @iterators = iterators
  end

  def each
    8.times do
      next_index = @iterators.map(&:peek).each_with_index.sort.first.last
      yield @iterators[next_index].next
    end
  end
end
