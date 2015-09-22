require "multi_iterator"

describe MultiIterator do
  it "interleaves multiple pre-sorted iterators in order" do
    iterator = described_class.new [].each, (1..5).each, [1, 1, 2, 3, 5, 8, 13].each, [4].each
    expect(iterator.to_enum.to_a).to eq [1, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 8, 13]
  end
end
