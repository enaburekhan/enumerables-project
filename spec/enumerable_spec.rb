require_relative '../lib/enumerable.rb'

describe Enumerable do
  describe '#my_each' do
    let(:arr) { [1, 2, 3, 4] }
    it 'returns each element on the array' do
      expect(arr.my_each { |num| num }). to eql([1, 2, 3, 4])
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

  describe '#my_all?' do
    let(:arr) { %w[ant bear cat] }
    it 'returns true if it matches atleast one condition on the block' do
      expect(arr.my_any? { |word| word.length >= 3 } ).to eql(true)
    end
    it 'returns false if it matches no condition on the block' do
      expect(arr.my_any?(/d/)).to eql(false)
    end
  end

  describe '#my_none' do
    let(:arr) { %w[ant bear cat] }
    it 'returns false if it matches atleast one condition on the block' do
     expect(arr.none? { |word| word.length >= 3 } ).to eql(false)
    end
    it 'returns true if it matches no condition on the block' do
     expect(arr.none?(/d/)).to eql(true)
    end
  end

  describe '#my_count' do
    let(:arr) { [1, 2, 4, 2] }
    it 'counts and returns the number of elements for which the block returns a true value' do
      expect(arr.my_count(&:even?)).to eql(3)
    end
  end

  describe '#my_map' do
    let(:range) {(1..4)}
    it 'returns a new array with the result for running block once for every element in enum' do
      expect(range.my_map{ |num| num * num }).to eql([1, 4, 9, 16])
    end
  end

  describe '#my_inject' do
    let(:range) {(5..10)}
    it 'it returns a new value combining all elements of enum by applying the giving binary operation' do
        expect(range.my_inject { |sum, n| sum + n }).to eql(45)    
    end  
  end 
  
  describe '#multiply_els' do
    let(:arr) { [2, 4, 5] }
    it 'it returns the product of elements in enum' do
        expect(multiply_els(arr)).to eql(40)
    end
  end    
end