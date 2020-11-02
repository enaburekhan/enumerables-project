# Enumerable method
# rubocop:disable all
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    arr = self if self.class == Array
    arr = to_a if self.class == Range
    arr = flatten if self.class == Hash
    for i in self
      yield i
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    result = []
    arr = self if self.class == Array
    arr = to_a if self.class == Range || self.class == Hash
    for i in 0...arr.length
      result << yield(arr[i], i)
    end
    result
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    result = []
    my_each do |item|
      result.push(item) if yield(item)
    end
    result
  end

  def my_all?(arg = nil)
    if block_given?
      my_each { |item| return false if yield(item) == false }
      return true
    elsif arg.nil?
      my_each { |num| return false if num.nil? || num == false }
    elsif !arg.nil? && (arg.is_a? Class)
      my_each { |num| return false if !num.is_a?(arg) }
    elsif !arg.nil? && arg.class == Regexp
      my_each { |num| return false unless arg.match(num) }
    else
      my_each { |num| return false if num != arg }
    end
    true
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |item| return true if yield(item) }
      false
    elsif arg.nil?
      my_each { |num| return true if num }
    elsif !arg.nil? && (arg.is_a? Class)
      my_each { |num| return true if num.is_a?(arg) }
    elsif !arg.nil? && arg.class == Regexp
      my_each { |num| return true if arg.match(num) }
    else
      my_each { |num| return true if num == arg }
    end
    false
  end

  def my_none?(arg = nil)
    if !block_given? && arg.nil?
      my_each { |num| return false if num }
      return true
    end
    if !block_given? && !arg.nil?
      if arg.is_a? Class
        my_each { |num| return false if num.is_a?(arg) }
        return true
      end
      if !arg.nil? && arg.class == Regexp
        my_each { |num| return false if arg.match(num) }
        return true
      end
      my_each { |num| return false if num == arg }
      return true
    end
    my_any? { |item| return false if yield(item) }
    true
  end

  def my_count(arg = nil)
    array = self if self.class == Array
    array = to_a if self.class == Range
    return array.length unless block_given? || arg
    return array.my_select { |item| item == arg }.length if arg

    array.my_select { |item| yield(item) }.length
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

    new_array = []
    if proc
      my_each { |item| new_array << proc.call(item) }
    elsif block_given?
      my_each { |item| new_array << yield(item) }
    end
    new_array
  end

  def my_inject(start_number = nil, sym = nil)
    # We have to check elements in parentheses
    # because elements in parentheses have priority over the block
    if !block_given? && start_number.nil? && sym.nil?
      yield(start_number, sym)
    end
    if block_given?
      num = start_number
      my_each do |item|
        num = num.nil? ? item : yield(num, item)
      end
      num
    else
      sym = start_number.is_a?(String) || start_number.is_a?(Symbol) ? start_number : sym
      num = start_number.is_a?(String) || start_number.is_a?(Symbol) ? nil : start_number
      my_each do |item|
        num = num.nil? ? item : num.send(sym.to_sym, item)
      end
      num
    end
  end
end


public

def multiply_els(arr)
  arr.my_inject(1, '*')
end
