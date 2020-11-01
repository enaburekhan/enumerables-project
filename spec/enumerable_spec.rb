require_relative '../lib/enumerable.rb'

describe Enumerable do
  describe '#my_each' do
    let(:arr) { [1, 2, 3, 4] }
    it 'returns each element on the array' do
      expect(arr.my_each { |num| num }). to eql([1, 2, 3, 4])    
    end    
  end  

end