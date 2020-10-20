require './enumerable.rb'

# rubocop:disable all
# my_each method
puts 'my_each Array'
[1, 3, 5, 7].my_each do |num|
  puts num
end

puts 'my_each Range'
(1..7).my_each do |num|
  puts num
end

# my_each_with_index
puts 'my_each_with_index Array'
array = [4, 5, 6]
array.my_each_with_index do |num, index|
  puts "#{num} : #{index}"
end

puts 'my_each_with_index Range'

(1..7).my_each_with_index do |num, index|
  puts "#{num} : #{index}"
end

# my_select
puts 'my_select'
array = [4, 5, 3, 8, 9]
p array.my_select(&:even?)

# my_all?
puts 'my_all'
arr = [2, 2, 2]
puts arr.my_all? { |num| num.is_a? Numeric }

# my_any?
puts 'my_any'
arr = [2, 2, 2, 4]
puts arr.my_any? { |num| num.is_a? Numeric }

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
p arr.my_map { |i| i.upcase }

# my_inject
puts 'my_inject'
arr = [1, 2, 3, 4]
puts arr.my_inject(:+)

p %w[cat sheep bear].my_inject { |memo, word| memo.length > word.length ? memo : word }

# multiply_els
puts 'multiply_els'
puts multiply_els([2, 4, 5])

# rubocop:enable Lint/AmbiguousBlockAssociation
