require './enumerable.rb'

# rubocop:disable Lint/AmbiguousBlockAssociation
# my_each method
puts 'my_each'
arr = { 'two' => 2, 'three' => 3, 'one' => 1 }
arr.my_each { |num| puts num }

# my_each_with_index
puts 'my_each_with_index'
array = [4, 5, 6]
array.my_each_with_index do |num, index|
  puts "#{num} : #{index}"
end

# my_select
puts 'my_select'
array = [4, 5, 3, 8, 9]
array.my_select(&:even?)

# my_all?
puts 'my_all'
arr = [2, 2, 2]
puts arr.my_all? { |num| num > 1 }

# my_any?
puts 'my_any'
arr = [2, 2, 2, 4]
puts arr.my_any? { |num| num > 3 }

# my_none?
puts 'my_none'
arr = [2, 2, 2]
puts arr.my_none? { |num| num > 1 }

# my_count
puts 'my_count'
arr = [2, 2, 2, 4, 5]
puts arr.my_count { |item| item > 2 }

# my_map
puts 'my_map'
arr = %w[one two three]
arr.my_map(&:upcase)

# my_inject
arr = [1, 2, 3, 4]
arr.my_inject { |item, number| item + number }

# multiply_els
puts 'multiply_els'
multiply_els([2, 4, 5])

# rubocop:enable Lint/AmbiguousBlockAssociation
