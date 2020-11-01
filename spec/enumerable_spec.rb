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

end