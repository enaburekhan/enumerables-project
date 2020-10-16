require './enumerable.rb'

# my_each method
arr = [2, 3, 1]
arr.my_each{ |num| puts num }

# my_each_with_index
array = [4, 5, 6]
array.my_each_with_index do |num, index|
  puts "#{num} : #{index}"
end

# my_select
array = [4, 5, 3, 8, 9]
array.my_select{|item| item.even?}

# my_all?
arr = [2, 2, 2]
arr.my_all? { |num| num == 2 }

# my_any?
arr = [2, 2, 2, 4]
arr.my_any? { |num| num > 3 }

# my_none?
arr = [2, 2, 2, 4]
arr.my_none? { |num| num < 1 }
