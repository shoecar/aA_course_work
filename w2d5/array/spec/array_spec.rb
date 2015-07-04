require 'array'
require 'rspec'

describe Array do
  describe "#my_uniq" do
    it "returns unique elements of an array" do
      expect([1,2,1,3,3].my_uniq).to eq([1,2,3])
    end
  end

  describe "#two_sum" do
    it "returns pairs of positions where elements sum to zero" do
      expect([-1,0,2,-2,1].two_sum).to eq([[0,4], [2,3]])
    end
  end

  describe "#median" do
    it "returns median of an array when length is odd" do
      expect([1,2,3,4,5].median).to eq(3)
    end

    it "returns averge of middle two numbers if length is even" do
      expect([1,2,4,4].median).to eq(3)
    end
  end

  describe "#my_transpose" do
    matrix = [
              [0, 1, 2],
              [3, 4, 5],
              [6, 7, 8]
            ]
    it "return a transposed matrix" do
      expect(matrix.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end
  end

end
