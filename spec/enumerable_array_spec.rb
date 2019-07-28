# frozen_string_literal: true

require_relative '../lib/enumerable_methods'

RSpec.describe Enumerable do
  describe 'when called on an Array' do
    array = [1, 2, 3, 4]
    even_array = [2, 4]
    odd_array = [1, 3]

    describe '#my_each' do
      result = []

      it 'will return the array itself' do
        expect(array.my_each { |e| result << e**2 }).to eq(array)
      end

      it 'will call the given block once for each element in self, passing that element as a parameter' do
        expect(result).to eq([1, 4, 9, 16])
      end

      context 'when no block is given' do
        it 'will return self as an Enumerator' do
          expect(array.my_each).to be_an(Enumerator)
          expect(array.my_each.to_a).to eq(array)
        end
      end
    end

    describe '#my_each_with_index' do
      result = []

      it 'will return the array itself' do
        expect(array.my_each_with_index { |e, i| result << e * i }).to eq(array)
      end

      it 'will call block with two arguments, the element and its index, for each item in enum.' do
        expect(result).to eq([0, 2, 6, 12])
      end

      context 'when no block is given' do
        it 'will return self as an Enumerator that includes the index.' do
          expect(array.my_each_with_index).to be_an(Enumerator)
          expect(array.my_each_with_index.to_a).to eq([[1, 0], [2, 1], [3, 2], [4, 3]])
        end
      end
    end

    describe '#my_select' do
      it 'will return an array containing all elements of ary for which the given block returns a true value. ' do
        expect(array.my_select(&:even?)).to eq(even_array)
      end

      it 'will return empty array if array is empty.' do
        expect([].my_select(&:even?)).to eq([])
      end

      context 'when no block is given' do
        it 'will return self as an Enumerator' do
          expect(array.my_select).to be_an(Enumerator)
          expect(array.my_select.to_a).to eq(array)
        end
      end
    end

    describe '#my_all?' do
      it 'will return true if the block never returns false or nil.' do
        expect(even_array.my_all?(&:even?)).to be true
      end

      it 'will return false if the block ever returns false or nil.' do
        expect(array.my_all?(&:even?)).to be false
      end

      it 'will return true if array is empty.' do
        expect([].my_all?(&:even?)).to be true
      end

      context 'when given a pattern.' do
        it 'returns whether pattern === element for every element' do
          expect(%w[ant bear cat].my_all?(/t/)).to be false
          expect(%w[ant beat cat].my_all?(/t/)).to be true
        end
      end

      context 'when no block is given, it adds an implicit block of { |obj| obj }' do
        it 'will return true when none are false or nil.' do
          expect(array.my_all?).to be true
        end

        it 'will return false when any are false or nil.' do
          expect([true, false].my_all?).to be false
          expect([true, nil].my_all?).to be false
        end
      end
    end

    describe '#my_any?' do
      it 'will return true if the block ever returns a value other than false or nil.' do
        expect(array.my_any?(&:even?)).to be true
      end

      it 'will return false if the block never returns a value other than false or nil.' do
        expect(odd_array.my_any?(&:even?)).to be false
      end

      it 'will return false if array is empty.' do
        expect([].my_any?(&:even?)).to be false
      end

      context 'when given a pattern.' do
        it 'will return whether pattern === element for any element' do
          expect(%w[ant bear cat].my_any?(/t/)).to be true
          expect(%w[ann bear car].my_any?(/d/)).to be false
        end
      end

      context 'when no block is given' do
        it 'returns true if any element are neither false or nil.' do
          expect(array.my_any?).to be true
        end
        it 'returns false if any element is false or nil.' do
          expect([true, false, nil].my_any?).to be true
          expect([false, nil].my_any?).to be false
        end
      end
    end

    describe '#my_my_none?' do
      it 'will return true if the block never returns true.' do
        expect(odd_array.my_none?(&:even?)).to be true
      end

      it 'will return false if the block ever returns true.' do
        expect(array.my_none?(&:even?)).to be false
      end

      context 'when given a pattern.' do
        it 'returns whether pattern === element for my_none of collection member' do
          expect(%w[anr bear car].my_none?(/t/)).to be true
          expect(%w[ant beat cat].my_none?(/t/)).to be false
        end
      end

      context 'when no block is given' do
        it 'will return false if any of the collection members is true.' do
          expect(array.my_none?).to be false
        end
        it 'will return true only if my_none of the collection members is true.' do
          expect([false, false].my_none?).to be true
        end
      end
    end

    describe '#my_count' do
      it 'will return number of items in array.' do
        expect(array.my_count).to eq(4)
        expect(odd_array.my_count).to eq(2)
      end

      context 'when given an argument.' do
        it 'will return the number of items equal to the argument.' do
          expect(array.my_count(3)).to eq(1)
        end
      end

      context 'when given an argument.' do
        it 'will return the number of elements yielding a true value.' do
          expect(array.my_count(&:even?)).to eq(2)
        end
      end
    end

    describe '#my_map' do
      it 'will return a new array with the results of running block once for every element in enum.' do
        expect(array.my_map { |e| e * 5 }).to eq [5, 10, 15, 20]
        expect(array.my_map { |_e| 5 }).to eq [5, 5, 5, 5]
      end

      context 'when no block is given.' do
        it 'will return an enumerator instead' do
          expect(array.my_map).to be_an(Enumerator)
          expect(array.my_map.to_a).to eq(array)
          expect(even_array.my_map.to_a).to eq(even_array)
        end
      end
    end
  end
end
