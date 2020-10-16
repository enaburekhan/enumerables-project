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
  end
  def my_select
    my_each do |item|
      if yield(item)
        puts item
      end
    end
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
end
