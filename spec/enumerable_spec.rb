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
        expect(hash.my_each { |(k, v)| result << "#{k}: #{v**2}" }).to eq(hash)
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

  describe '#my_select' do
    context 'when called on an Array object' do
      it 'will return an array containing all elements of enum for which the given block returns a true value. ' do
        expect(array.my_select(&:even?)).to eq([2, 4])
      end
      context 'when no block is given' do
        it 'returns self as an Enumerator' do
          expect(array.my_select).to be_an(Enumerator)
          expect(array.my_select.to_a).to eq(array)
        end
      end
    end
    context 'when called on a Hash object' do
      it 'will return an array containing all elements of enum for which the given block returns a true value. ' do
        expect(hash.my_select { |(_k, v)| v.even? }).to eq(a: 4, c: 2)
      end
      context 'when no block is given' do
        it 'returns self as an Enumerator' do
          expect(hash.my_select).to be_an(Enumerator)
          expect(hash.my_select.to_a).to eq(hash.to_a)
        end
      end
    end
  end

  describe '#my_all?' do
    context 'when called on an Array object' do
      it 'The method returns true if the block never returns false or nil.' do
        expect(array.my_all?(&:even?)).to be false
      end

      context 'when given a pattern.' do
        it 'returns whether pattern === element for every collection member' do
          expect(%w[ant bear cat].my_all?(/t/)).to be false
          expect(%w[ant beat cat].my_all?(/t/)).to be true
        end
      end

      context 'when no block is given' do
        it 'returns true if no element  are false or nil.' do
          expect(array.my_all?).to be true
        end
        it 'returns false if any element is false or nil.' do
          expect([true, false].my_all?).to be false
        end
      end
    end

    context 'when called on a Hash object' do
      it 'The method returns true if the block never returns false or nil.' do
        expect(hash.my_all? { |(_k, v)| v.even? }).to be false
      end

      context 'when given a pattern.' do
        it 'returns false' do
          expect(hash.my_all?(/t/)).to be false
        end
      end

      context 'when no block is given' do
        it 'returns true.' do
          expect(hash.my_all?).to be true
        end
      end
    end
  end

  describe '#my_any?' do
    context 'when called on an Array object' do
      it 'The method returns true if the block ever returns false or nil.' do
        expect(array.my_any?(&:even?)).to be true
      end

      context 'when given a pattern.' do
        it 'returns whether pattern === element for any collection member' do
          expect(%w[ant bear cat].my_any?(/t/)).to be true
          expect(%w[ann bear car].my_any?(/d/)).to be false
        end
      end

      context 'when no block is given' do
        it 'returns true if any element are neither false or nil.' do
          expect(array.my_any?).to be true
        end
        it 'returns false if any element is false or nil.' do
          expect([true, false].my_any?).to be true
        end
      end
    end

    context 'when called on a Hash object' do
      it 'The method returns true if the block ever returns false or nil.' do
        expect(hash.my_any? { |(_k, v)| v.even? }).to be true
      end

      context 'when given a pattern.' do
        it 'returns false' do
          expect({ a: 'cat' }.my_any?(/t/)).to be false
        end
      end

      context 'when no block is given' do
        it 'returns true unless hash is empty.' do
          expect({}.my_any?).to be false
          expect(hash.my_any?).to be true
        end
      end
    end
  end

  describe '#my_none?' do
    context 'when called on an Array object' do
      it 'The method returns true if the block never returns false or nil.' do
        expect(array._none?(&:even?)).to be true
      end

      context 'when given a pattern.' do
        it 'returns whether pattern === element for every collection member' do
          expect(%w[ant bear cat].none?(/t/)).to be true
          expect(%w[ant beat cat].none?(/t/)).to be false
        end
      end

      context 'when no block is given' do
        it 'returns true if no element  are false or nil.' do
          expect(array.none?).to be false
        end
        it 'returns false if any element is false or nil.' do
          expect([true, false].none?).to be true
        end
      end
    end

    context 'when called on a Hash object' do
      it 'The method returns true if the block never returns false or nil.' do
        expect(hash.none? { |(_k, v)| v.even? }).to be true
      end

      context 'when given a pattern.' do
        it 'returns false' do
          expect(hash.none?(/t/)).to be true
        end
      end

      context 'when no block is given' do
        it 'returns true.' do
          expect(hash.none?).to be false
        end
      end
    end
  end
end
