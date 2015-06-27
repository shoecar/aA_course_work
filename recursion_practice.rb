require "byebug"

#Problem 1: You have array of integers. Write a recursive solution to find the
#sum of the integers.

def sum_recur(array)
  return 0 if array.length == 0
  sum_recur(array[0...array.length - 1]) + array.last
end

# p sum_recur([1, 3, 5, 7, 9, 2, 4, 6, 8]) # 45

#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def includes?(array, target)
  return false if array.length == 0
  return true if target == array.first
  includes?(array.drop(1), 9)
end

# p includes?([1, 3, 5, 7, 9, 2, 4, 6, 8], 9) #true

# Problem 3: You have an unsorted array of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.length == 0
  count = array.first == target ? 1 : 0
  count += num_occur(array.drop(1), target)
end

# p num_occur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 5) # 4

# Problem 4: You have array of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length < 2
  return true if array[0] + array[1] == 12
  add_to_twelve?(array.drop(1))
end

# p add_to_twelve?([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6]) # false

# Problem 5: You have array of integers. Write a recursive solution to determine
# if the array is sorted.

def sorted?(array)
  return true if array.length < 2
  return false if array[0] > array[1]
  sorted?(array.drop(1))
end

# p sorted?([1, 2, 3, 4, 4, 5, 6, 7]) # true

# Problem 6: Write a recursive function to reverse a string. Don't use any
# built-in #reverse methods!

def reverse(string)
  return string if string.length == 1
  reverse(string.slice(1, string.length)) + string[0]
end

# p reverse("kongfuzi")  # "izufgnok"

def bubble_sort(array)
  array = array.dup
  return array if array.count < 2
  (0...array.count - 1).each do |idx|
    array[idx], array[idx + 1] = array[idx + 1], array[idx] if array[idx] > array[idx + 1]
  end
  bubble_sort(array[0..-2]) + [array.last]
end

# p bubble_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]


def quick_sort(array)
  return array if array.count < 2
  pivot_idx = rand(array.length)
  pivot = array[pivot_idx]
  array = array.take(pivot_idx) + array.drop(1 + pivot_idx)
  left, right = [], []
  until array.empty?
    array.first < pivot ? left << array.shift : right << array.shift
  end
  quick_sort(left) + [pivot] + quick_sort(right)
end

# p quick_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]

def heap_sort(array)
  return [array.first] if array.count < 2
  heap = []
  array.each do |num|
    if heap.empty?
      heap << num
      next
    end
    num > heap.first ? heap.unshift(num) : heap << num
  end

  heap_sort(heap.drop(1)) + [heap.first]
end

# p heap_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]
