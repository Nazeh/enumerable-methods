# frozen_string_literal: true

require_relative '../lib/enumerable_methods'

RSpec.describe Enumerable do
  array = [1, 2, 3, 4]
  hash = { a: 4, b: 3, c: 2, d: 1 }

  describe '#my_each' do
    context 'when called on an Array object' do
      result = []

      it 'will return the array itself' do
        expect(array.my_each { |e| result << e**2 }).to eq(array)
      end

      it 'will call the given block once for each element in self, passing that element as a parameter' do
        expect(result).to eq([1, 4, 9, 16])
      end

      context 'when no block is given' do
        it 'returns self as an Enumerator' do
          expect(array.my_each).to be_an(Enumerator)
          expect(array.my_each.to_a).to eq(array)
        end
      end
    end

    context 'when called on a Hash object' do
      result = []

      it 'will return the hash itself' do
        expect(hash.my_each { |k, v| result << "#{k}: #{v**2}" }).to eq(hash)
      end

      it 'will call block once for each key in hash, passing the key-value pair as parameters.' do
        expect(result).to eq(['a: 16', 'b: 9', 'c: 4', 'd: 1'])
      end

      context 'when no block is given' do
        it 'returns self as an Enumerator' do
          expect(hash.my_each).to be_an(Enumerator)
          expect(hash.my_each.to_a).to eq(hash.to_a)
        end
      end
    end
  end

  describe '#my_each_with_index' do
    context 'when called on an Array object' do
      result = []

      it 'will return the array itself' do
        expect(array.my_each_with_index { |e, i| result << e * i }).to eq(array)
      end

      it 'will call block with two arguments, the element and its index, for each item in array.' do
        expect(result).to eq([0, 2, 6, 12])
      end

      context 'when no block is given' do
        it 'returns self as an Enumerator that includes the index.' do
          expect(array.my_each_with_index).to be_an(Enumerator)
          expect(array.my_each_with_index.to_a).to eq([[1, 0], [2, 1], [3, 2], [4, 3]])
        end
      end
    end

    context 'when called on a Hash object' do
      result = []

      it 'will return the array itself' do
        expect(hash.my_each_with_index { |(k, v), i| result << "#{k}: #{v**i}" }).to eq(hash)
      end

      it 'will call block with two arguments, the (key, value) pair and its index, for each item in hash.' do
        expect(result).to eq(['a: 1', 'b: 3', 'c: 4', 'd: 1'])
      end

      context 'when no block is given' do
        it 'returns self as an Enumerator that includes the index.' do
          expect(hash.my_each_with_index).to be_an(Enumerator)
          expect(hash.my_each_with_index.to_a).to eq([[[:a, 4], 0], [[:b, 3], 1], [[:c, 2], 2], [[:d, 1], 3]])
        end
      end
    end
  end
end
