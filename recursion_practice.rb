require "byebug"

#Problem 1: You have array of integers. Write a recursive solution to find the
#sum of the integers.

def sum_recur(array)
  return array[0] if array.count < 2
  array.shift + sum_recur(array)
end

# p sum_recur([1, 3, 5, 7, 9, 2, 4, 6, 8]) # 45

#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def includes?(array, target)
  return false if array.empty?
  return true if array.last == target
  includes?(array.take(array.count - 1), target)
end

# p includes?([1, 3, 5, 7, 9, 2, 4, 6, 8], 9) #true

# Problem 3: You have an unsorted array of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.empty?
  temp = 0
  temp = 1 if array.pop == target
  num_occur(array, target) + temp
end

# p num_occur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 5) # 4

# Problem 4: You have array of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.count < 2
  return true if array.shift + array.first == 12
  add_to_twelve?(array)
end

# p add_to_twelve?([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6]) # false

# Problem 5: You have array of integers. Write a recursive solution to determine
# if the array is sorted.

def sorted?(array)
  return true if array.count < 2
  return false if array.shift > array.first
  sorted?(array)
end

# p sorted?([1, 2, 3, 4, 4, 5, 6, 7]) # true

# Problem 6: Write a recursive function to reverse a string. Don't use any
# built-in #reverse methods!

def reverse(string)
  return string if string.length < 2
  string[-1] + reverse(string[0...-1])
end

# p reverse("kongfuzi")  # "izufgnok"

def bubble_sort(array, &prc)
  return array if array.count < 2
  prc ||= Proc.new { |x, y| x <=> y }
  (0...array.count - 1).each do |idx|
    if prc.call(array[idx], array[idx + 1]) > 0
      array[idx], array[idx + 1] = array[idx + 1], array[idx]
    end
  end
  bubble_sort(array[0...array.count - 1], &prc) + [array.last]
end

# p bubble_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]
# prc = Proc.new  { |x, y| y <=> x }
# p bubble_sort([3,5,2,7,2,1], &prc) # [7, 5, 3, 2, 2, 1]

def quick_sort(array)
  return array if array.count < 2
  pivot_idx = array.count / 2
  pivot = array[pivot_idx]
  array.delete_at(pivot_idx)
  left, right = [], []
  until array.empty?
    array.first < pivot ? left << array.shift : right << array.shift
  end
  quick_sort(left) + [pivot] + quick_sort(right)
end

# p quick_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]

def heap_sort(array)
  return array if array.count < 2
  big = -1
  big_idx = -1
  array.each_with_index do |num, idx|
    if num > big
      big = num
      big_idx = idx
    end
  end
  array.delete_at(big_idx)
  heap_sort(array) + [big]
end

# p heap_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]

def merge_sort(array)
  return array if array.count < 2
  left = merge_sort(array.take(array.count / 2))
  right = merge_sort(array.drop(array.count / 2))
  merged = []
  until left.empty? || right.empty?
    merged << (left.first < right.first ? left.shift : right.shift)
  end
  merged + left + right
end

# p merge_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]

def binary_search(array, target)
  idx = array.count / 2
  return idx if array[idx] == target
  if array[idx] > target
    binary_search(array.take(idx), target)
  else
    binary_search(array.drop(idx + 1), target) + idx + 1
  end
end

# p binary_search([1, 2, 2, 3, 5, 7, 9], 7) # 5

def factors(num)
  return [] if num < 2
  facs = factors(num)

end

# p factors(84) # [2, 3, 4, 6, 7, 12, 14, 21, 28, 42]

def CoinDeterminer(num)
  return 0 if num == 0
  best, temp_best, coins = num, num, [11, 9, 7, 5, 1]
  coins.each do |coin|
    temp_best = 1 + CoinDeterminer(num - coin) if coin <= num
    best = temp_best if temp_best < best
  end
  best
end

# p CoinDeterminer(21)
