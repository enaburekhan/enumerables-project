# frozen_string_literal: true

# Enumerable method
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = self if self.class == Array
    arr = to_a if self.class == Range
    arr = flatten if self.class == Hash
    (0..(arr.length - 1)).each do |i|
      yield(arr[i])
    end
    arr
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    arr = self if self.class == Array
    arr = to_a if self.class == Range
    arr = flatten if self.class == Hash
    (0..(arr.length - 1)).each do |i|
      yield(arr[i], i)
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    my_each do |item|
      result.push(item) if yield(item)
    end
    puts result.to_s
    result
  end

  def my_all?(arg = nil)
    if block_given?
      my_each { |item| return false if yield(item) == false }
      return true
    elsif arg.nil?
      my_each { |num| return false if num.nil? || num == false }
    elsif !arg.nil? && (arg.is_a? Class)
      my_each { |num| return false if num.class != arg }
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
      my_each { |num| return true if num.class == arg }
    elsif !arg.nil? && arg.class == Regexp
      my_each { |num| return true if arg.match(num) }
    else
      my_each { |num| return true if num == arg }
    end
    false
  end

  def my_none?(arg = nil)
    if !block_given? && arg.nil?
      my_each { |item| return false if yield(item) }
      true
    end
    if !block_given? && !arg.nil?
      if arg.is_a? Class
        my_each { |num| return false if num.class == arg }
        true
      end
      if !arg.nil? && arg.class == Regexp
        my_each { |num| return false if arg.match(num) }
        true
      end
      my_each { |num| return false if num == arg }
      true
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
    p new_array
    new_array
  end

  def my_inject(start_number = nil, sym = nil)
    # We have to check elements in parentheses
    # because elements in parentheses have priority over the block
    if block_given? && sym.nil?
      start_number ||= 0
      my_each do |item|
        start_number = yield(start_number, item)
      end
    else
      sym = start_number.is_a?(String) || start_number.is_a?(Symbol) ? start_number : sym
      start_number = start_number.is_a?(String) || start_number.is_a?(Symbol) || start_number.nil? ? 0 : start_number
      my_each do |item|
        start_number = start_number.send(sym.to_sym, item)
      end
    end
    puts "the result is #{start_number}"
    start_number
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength

public

def multiply_els(arr)
  arr.my_inject(1, '*')
end
