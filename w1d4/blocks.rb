class Array
  def my_each(&block)
    counter = 0
    while counter < self.length
      block.call(self[counter])
      counter += 1
    end
    self
  end

  def my_map(&block)
    arr = []
    self.my_each { |x| arr << block.call(x) }
    arr
  end

  def my_select(&block)
    arr = []
    self.my_each { |x| arr << x if block.call(x) }
    arr
  end

  def my_inject(&block)
    num = 0
    self.my_each { |x| num = block.call(num, x) }
    num
  end

  def my_sort!(&block)
    loop do
      self.each_index do |idx|
        return self if idx == self.length - 1
        if block.call(self[idx], self[idx + 1]) > 0
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          break
        end
      end
    end
  end

  def my_sort(&block)
    self.dup.my_sort!(&block)
  end
end

# a = [1,2,3].my_each { |num| puts num }
# p a
#
# b = [1,2,3].my_map { |num| num * 2 }
# p b
#
# c = [1,2,3].my_select { |num| num == 2 }
# p c

# d = [1,2,3].my_inject { |sum, num| sum + num }
# p d

# e = [3,6,2,7,2]
# e.my_sort { |num1, num2| num1 <=> num2 }
# p e

def eval_block(*args, &block)
  return puts "NO BLOCK GIVEN" unless block_given?
  block.call(*args)
end

# eval_block("Kerry", "Washington", 23) do |fname, lname, score|
#   puts "#{lname}, #{fname} won #{score} votes."
# end
#
# b = eval_block(1,2,3,4,5) do |*args|
#   args.inject(:+)
# end
