require "byebug"

def range(start_val, end_val)
  if end_val < start_val
    return []
  end

  if end_val == start_val
    return [start_val]
  end
  range(start_val, end_val - 1) + [end_val]
end

def sum_array_iterative(array)
  sum = 0
  array.each { |entry| sum += entry }
  sum
end

def sum_array_recursive(array)
  return array[0] if array.length == 1
  sum_array_recursive(array[0..-2]) + array[-1]
end

def expo_1(base, num)
  return 1 if num == 0
  base * expo_1(base, num - 1)
end

def expo_2(base, num)
  return 1 if num == 0
  return base if num == 1
  if num % 2 == 0
    temp = expo_2(base, num / 2)
    temp * temp
  else
    temp = expo_2(base, (num - 1) / 2)
    base * temp * temp
  end
end

class Array
  def deep_dup
    result = []
    self.each do |entry|
      if entry.is_a?(Array)
        result << entry.deep_dup
      else
        result << entry
      end
    end
    result
  end
end

def fibonacci_nums(n)
  return [1,1] if n == 2
  return [1] if n == 1
  return [] if n == 0
  result = []
  result += fibonacci_nums(n-1)
  result << result[-1] + result[-2]
end

def bsearch(arr, target)
  return nil if arr.length <= 1 && arr.first != target
  middle = arr.length / 2
  return middle if arr[middle] == target
  if arr[middle] < target
    result = bsearch(arr[middle + 1..-1], target)
    return nil if result.nil?
    result + middle + 1
  else
    bsearch(arr[0...middle], target)
  end
end

def make_change(num, arr)
  return [] if num == 0
  best = []
  arr.each_with_index do |coin, i|
    if coin <= num
      temp_best = make_change(num - coin, arr.drop(i)) + [coin]
    end
    if temp_best
      best = temp_best if temp_best.length < best.length || best.length == 0
    end
  end
  best
end

def merge_sort(array)
  return array if array.length < 2
  left = array[0...array.length/2]
  right = array[array.length/ 2..-1]
  sorted_left = merge_sort(left)
  sorted_right = merge_sort(right)
  merge(sorted_left, sorted_right)
end

def merge(array1, array2)
  result = []
  until array1.empty? || array2.empty?
    result << (array1.first <= array2.first ? array1.shift : array2.shift)
  end
  result + array1 + array2
end

def subsets(arr)
  return [[]] if arr.length == 0
  previous_subsets = subsets(arr[0..-2])
  previous_subsets + previous_subsets.map{ |el| el + [arr[-1]] }
end
