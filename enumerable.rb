module Enumerable
  def my_each
    arr = self
    if arr.kind_of?(Array)
      for i in 0..(arr.length - 1)
        yield(arr[i])
      end
      arr
    end
  end
  def my_each_with_index
    arr = self
    for i in 0..(arr.length - 1)
      yield(arr[i], i)
    end
    arr
  end
  def my_select
    result = []
    my_each do |item|
      if yield(item)
        result.push(item)
      end
    end
    puts "#{result}"
    result
  end
  def my_all?
    my_each do |num|
      if yield(num) == false
        puts false
        return false
      end
    end
    puts true
    return true
  end
  def my_any?
    my_each do |num|
      if yield(num) == true
        puts true
        return true
      end
    end
    puts false
    return false
  end
  def my_none?
    my_each do |num|
      if yield(num) == true
        puts false
        return false
      end
    end
    puts true
    return true
  end
  def my_count
    count = 0
    my_each do |acc|
      count += 1
    end
    puts count
    return count
  end
  def my_map
    array = []
    my_each do |item|
      array.push(yield(item))
    end
    puts "#{array}"
    array
  end
  def my_inject(start_number = nil, sym = nil)
    # We have to check elements in parentheses
    # because elements in parentheses have priority over the block
    if block_given? && sym.nil? && start_number.nil? # arr.my_inject{|item, number| item + number}
      start_number = 0
      my_each do |item|
        start_number = yield(start_number, item)
      end
    elsif block_given? && sym.nil? && !start_number.nil? # arr.my_inject(2){|item, number| item + number}
      my_each do |item|
        start_number = yield(start_number, item)
      end
    elsif !block_given? && (start_number.is_a?(String) || start_number.is_a?(Symbol)) # arr.my_inject("+")
      sym = start_number
      start_number = 0
      my_each do |item|
        start_number = start_number.send( sym.to_sym, item)
      end
    elsif !block_given? && !sym.nil? && !start_number.nil? # arr.my_inject(2, "+")
      my_each do |item|
        start_number = start_number.send( sym.to_sym, item)
      end
    end
    puts "the result is #{start_number}"
    return start_number
  end
  def multiply_els
    arr = self
    num = arr.my_inject(1, "*")
  end
end
