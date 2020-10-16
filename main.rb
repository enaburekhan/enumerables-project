require './enumerable.rb'

# my_each method
arr = [2, 3, 1]
arr.my_each{ |num| puts num }

# my_each_with_index
array = [4, 5, 6]
array.my_each_with_index do |num, index|
  puts "#{num} : #{index}"  
end    
