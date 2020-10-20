# rubocop:disable all
module Enumerable
  def my_each(array)
    for item in array
      yield item
    end
  end

  def my_each_with_index(array)
    for i in (0...array.length)
      yield i, array[i]
    end
  end

  def my_select(array, filter)
    for i in array
      yield i if i != filter
    end
  end

  def my_all(array)
    for i in 0...array.length
      if (!yield array[i])
        return false
      end
    end
    return true
  end

  def my_any(array)
    for i in 0...array.length
      if (yield array[i])
        return true
      end
    end
    return false
  end

  def my_none(array)
    for i in 0...array.length
      if (yield array[i])
        return false
      end
    end
    return true
  end

  def my_count(array)
    count = 0
    for i in 1..array.length
      count += 1
    end
    count
  end

  def my_map(array, funct)
    result_array = []
    for item in array
      result_array.push(method(funct).call(item))
    end
    return result_array
  end

  def my_inject(array, result, funct)
    for item in array
      result = method(funct).call(result, item)
    end
    return result
  end
end
