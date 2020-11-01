require_relative '../lib/enumerable.rb'

describe Enumerable do
  describe '#my_each' do
    let(:arr) { [1, 2, 3, 4] }
    let(:range) { (1..7) }
    context 'Where an array and block are given' do
      let(:custom_test) { [] }
      let(:ruby_test) { [] } 
      it 'should iterate through the array' do
        arr.my_each { |num| custom_test << num }
        arr.each { |num| ruby_test << num }
        expect(custom_test).to eql(ruby_test)
      end     
    end 

    context 'Where a range and block are given' do
      let(:custom_test) { [] }
      let(:ruby_test) { [] }
      it 'iterate through the array' do
        range.my_each { |num| custom_test << num }
        range.each { |num| custom_test << num }
      end      
    end         
  end

  describe '#my_each_with_index' do
    let(:arr) { %w[one two three] }
    it 'returns each element with the index value' do
      expect(arr.my_each_with_index { |num, index| "#{num} #{index}" }).to eql(['one 0', 'two 1', 'three 2'])
    end
  end

  describe '#my_select' do
    let(:arr) { [1, 2, 3, 4, 5, 6] }
    it 'returns an array of even numbers on the block' do
      expect(arr.my_select(&:even?)). to eql([2, 4, 6])
    end

    it 'returns an array of odd numbers on the block' do
      expect(arr.my_select(&:odd?)). to eql([1, 3, 5])
    end
  end

  describe '#my_all' do
    let(:arr1) { [1, 2, 3, 4, 5, 6] } 
    let(:arr2) { [nil, 4, 5, 9] }
    let(:arr3) { [4, 8.24, 'd'] }
    let(:arr4) { %w[cat cow] }
    let(:arr5) { %w[cat cow bear] } 
    let(:arr6) { [7, 7, 7] }

    context 'where value is given as argument' do
      it 'returns true or false base on the arg given' do
        expect(arr1.my_all?(5)).to be(false)
        expect(arr6.my_all?(7)).to be(true)      
      end    
    end 

  context 'where class is given as argument' do
    it 'returns true or false base on the arg given' do
      expect(arr1.my_all?(Integer)).to be(true)
      expect(arr3.my_all?(Integer)).to be(false)      
    end    
  end
  
  context 'where Regex is given as argument' do
    it 'returns true or false base on arg given' do
      expect(arr4.my_all?(/c/)).to be(true)
      expect(arr5.my_all?(/c/)).to be(false)    
    end
  end 
  
  context 'where block is not given' do
    it 'returns true or false base on the condition given' do
      expect(arr1.my_all?).to be(true)
      expect(arr2.my_all?).to be(false)    
    end    
  end

  context 'where block is given' do
    it 'returns true or false base on condition given' do
      expect(arr1.my_all? { |num| num >= 1 }).to be(true)
      expect(arr1.my_all? { |num| num >= 3 }).to be(false)    
    end    
  end    
end  

  describe '#my_any?' do
    let(:arr1) { [1, 2, 3, 4, 5, 6] } 
    let(:arr2) { [nil, 4, 5, 9] }
    let(:arr3) { [4, 8.24, 'd'] }
    let(:arr4) { %w[cat cow] }
    let(:arr5) { %w[cat cow bear] } 
    let(:arr6) { [7, 7, 7] }

    context 'where a value is given as an arg' do
      it 'returns true or false base on arg given' do
        expect(arr1.my_any?(7)).to be(false)
        expect(arr1.my_any?(5)).to be(true)
      end      
    end    

    context 'where a block is given' do
      it 'returns true or false base on condition given' do
        expect(arr1.my_any? { |num| num >= 4}).to be(true)
        expect(arr1.my_any? { |num| num > 6 }).to be(false)
      end      
    end 
    
    context 'where a class is given as argument' do
      it 'should return true or false base on the given arg' do
        expect(arr1.my_any?(Integer)).to be(true)
        expect(arr1.my_any?(Float)).to be(false)
      end      
    end 
    
    context 'where Regex is given as argument' do
      it 'returns true or false base on arg given' do
        expect(arr5.my_any?(/c/)).to be(true)
        expect(arr5.my_any?(/z/)).to be(false)
      end      
    end    
  end

  describe '#my_none' do
    let(:arr1) { [1, 2, 3, 4, 5, 6] } 
    let(:arr2) { [nil, 4, 5, 9] }
    let(:arr3) { [nil, false, nil] }

    context 'where an argument is given' do
      it 'returns true or false base on the arg given' do
        expect(arr1.my_none?(7)).to be(true)
        expect(arr1.my_none?(6)).to be(false)
      end      
    end    
    
    context 'where block is given' do
      it 'returns true or false base on the condition given' do
        expect(arr1.my_none? { |num| num <= 8}).to be(false)
        expect(arr1.my_none? { |num| num >= 8}).to be(true)
      end      
    end 
    
    context 'where no block is given' do
      it 'returns true or false base on condition given' do
        expect(arr3.my_none?).to be(true)
        expect(arr1.my_none?).to be(false)
      end      
    end    
  end

  describe '#my_count' do
    let(:arr) { [1, 2, 4, 2] }
    
    context 'where arg are given' do
      it 'should return the number of arguments' do
        expect(arr.my_count(2)).to eql(2)
      end      
    end 
    
    context 'where block is given' do
      it 'returns the number of elements that matches the block condition' do
        expect(arr.my_count { |num| num > 2 }).to eql(1)
      end      
    end    
  end

  describe '#my_map' do
    let(:arr) { [1, 2, 3, 4]}

    context 'where an array and block are given' do
      let(:custom_arr) { [] }
      it 'returns a new array containing the values returned by the block' do
        arr.my_map { |num| custom_arr << num * 2}
        expect(custom_arr).to eql([2, 4, 6, 8])
      end      
    end 
    
    context 'when the arg is passed a proc' do
      it 'should call the proc' do
        new_proc = proc { |num| num * 2 }
        expect(arr.my_map(&new_proc)).to eql([2, 4, 6, 8])
      end 
    end       
  end

  describe '#my_inject' do
    let(:arr) { [2, 3, 4] }

    context 'where an array is given' do
      it 'returns a new array containing the values returned by the block' do
        custom_value = arr.my_inject { |a, b| a * b }
        expect(custom_value).to eql(24) 
      end      
    end
    
    context 'when a symbol is given as an argument' do
      it 'returns the operation of the given symbol' do
        expect(arr.my_inject(:+)).to eql(9)
      end      
    end 
    
    context 'when a string is given as an argument' do
      it 'returns the operation of the given string' do
        expect(arr.my_inject('+')).to eql(9)
      end      
    end  
    
    context 'where both initial value and symbol are given as argument' do
      it 'returns the operation of the given symbol plus the initial value' do
        expect(arr.my_inject(1, :+)).to eql(10)
      end      
    end    
  end

  describe '#multiply_els' do
    let(:arr) { [2, 4, 5] }
    it 'it returns the product of elements in enum' do
      expect(multiply_els(arr)).to eql(40)
    end
  end
end
