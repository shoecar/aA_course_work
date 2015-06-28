require "byebug"

#Problem 1: You have array of integers. Write a recursive solution to find the
#sum of the integers.

def sum_recur(array)
  return array[0] if array.count < 2
  array.pop + sum_recur(array)
end

# p sum_recur([1, 3, 5, 7, 9, 2, 4, 6, 8]) # 45

#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def includes?(array, target)
  return false if array.count == 0
  return true if array.last == target
  includes?(array[0...-1], target)
end

# p includes?([1, 3, 5, 7, 9, 2, 4, 6, 8], 9) #true

# Problem 3: You have an unsorted array of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.empty?
  count = array.last == target ? 1 : 0
  num_occur(array[0...-1], target) + count
end

# p num_occur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 5) # 4

# Problem 4: You have array of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.count < 2
  return true if array[1] + array.shift == 12
  add_to_twelve?(array)
end

# p add_to_twelve?([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6]) # false

# Problem 5: You have array of integers. Write a recursive solution to determine
# if the array is sorted.

def sorted?(array)
  return true if array.count < 2
  return false if array[1] < array.shift
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

def bubble_sort(array)
  return array if array.count < 2
  (0...array.count - 1).each do |idx|
    array[idx], array[idx + 1] = array[idx + 1], array[idx] if array[idx + 1] < array[idx]
  end
  bubble_sort(array[0...-1]) + [array.last]
end

# p bubble_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]


def quick_sort(array)
  return array if array.count < 2
  pivot_idx = rand(array.count)
  pivot = array[pivot_idx]
  array = array.take(pivot_idx) + array.drop(1 + pivot_idx)
  left, right = [], []
  until array.empty?
    pivot > array.first ? left << array.shift : right << array.shift
  end
  quick_sort(left) + [pivot] + quick_sort(right)
end

p quick_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]

def heap_sort(array)
  return array if array.count < 2
  big = 0
  array.each do |num|
    big = num if num > big
  end
  heap = array.index(big)
  array = array[0...heap] + array[heap + 1..-1]
  heap_sort(array) + [big]
end

# p heap_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]

def merge_sort(array)
  return array if array.count < 2
  left, right = array.take(array.count / 2), array.drop(array.count / 2)
  l, r = merge_sort(left), merge_sort(right)
  merged = []
  until l.empty? || r.empty?
    l.first < r.first ? merged << l.shift : merged << r.shift
  end
  merged + l + r
end

# p merge_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]
