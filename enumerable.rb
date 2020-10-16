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
end
