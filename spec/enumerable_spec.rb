# frozen_string_literal: true

require_relative '../lib/enumerable_methods'

RSpec.describe Enumerable do
  array = [1, 2, 3, 4]
  hash = { a: 1, b: 2, c: 3, d: 4 }

  describe '#my_each' do
    context 'when called on an Array object' do
      result = []
      my_block = proc { |e| result << e**2 }
      array.my_each(&my_block)

      it 'will call the given block once for each element in self, passing that element as a parameter' do
        expect(result).to eq([1, 4, 9, 16])
      end

      it 'will return the array itself' do
        expect(array.my_each(&my_block)).to eq(array)
      end

      context 'when no block is given' do
        it 'returns an Enumerator' do
          expect(array.my_each).to be_an(Enumerator)
          expect(array.my_each.to_a).to eq(array)
        end
      end
    end

    context 'when called on a Hash object' do
      result = []
      hash_block = proc { |k, v| result << "#{k}: #{v ** 2}" }
      hash.my_each(&hash_block)

      it 'will call block once for each key in hsh, passing the key-value pair as parameters.' do
        expect(result).to eq(["a: 1", "b: 4", "c: 9", "d: 16"])
      end

      it 'will return the array itself' do
        expect(hash.my_each(&hash_block)).to eq(hash)
      end

      context 'when no block is given' do
        it 'returns an Enumerator' do
          expect(hash.my_each).to be_an(Enumerator)
          expect(hash.my_each.to_h).to eq(hash)
        end
      end
    end
  end

  describe '#my_each_with_index' do
  end
end
