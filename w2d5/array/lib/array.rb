class Array

  def my_uniq
    result = []
    self.each do |element|
      result << element unless result.include?(element)
    end
    result
  end

  def two_sum
    result = []
    (0...(count - 1)).each do |idx1|
      ((idx1 + 1)...count).each do |idx2|
        result << [idx1, idx2] if self[idx1] + self[idx2] == 0
      end
    end
    result
  end

  def median
    middle = count/2
    if count.even?
      (self[middle] + self[middle - 1])/2
    else
      self[middle]
    end
  end

  def my_transpose
    result = Array.new(count) { Array.new }
    each do |row|
      row.each_with_index do |ele, idx|
        result[idx] << ele
      end
    end
    result
  end

end
