# Enumerable method
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

  # def my_all?
  #   return false unless block_given?

  #   my_each do |num|
  #     if yield(num) == false
  #       puts false
  #       return false
  #     end
  #   end
  #   puts true
  #   true
  # end

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

  # def my_any?
  #   my_each do |num|
  #     if yield(num) == true
  #       puts true
  #       return true
  #     end
  #   end
  #   puts false
  #   false
  # end

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

  def my_none?
    my_each do |num|
      if yield(num) == true
        puts false
        return false
      end
    end
    puts true
    true
  end

  def my_count
    count = 0
    my_each do |_acc|
      count += 1
    end
    puts count
    count
  end

  def my_map
    array = []
    my_each do |item|
      array.push(yield(item))
    end
    puts array.to_s
    array
  end

  # rubocop:disable Metrics/PerceivedComplexity
  # rubocop:disable Metrics/CyclomaticComplexity
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
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def multiply_els
    arr = self
    arr.my_inject(1, '*')
  end

  def my_map_proc(proc = nil)
    new_array = []
    if proc
      my_each { |item| new_array << proc.call(item) }
    elsif block_given?
      my_each { |item| new_array << yield(item) }
    end
    p new_array
    new_array
  end
end
