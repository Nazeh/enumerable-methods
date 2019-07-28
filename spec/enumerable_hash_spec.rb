# frozen_string_literal: true

require_relative '../lib/enumerable_methods'

RSpec.describe Enumerable do
  describe 'when called on a Hash' do
    hash = { a: 4, b: 3, c: 2, d: 1 }
    even_hash = { a: 4, c: 2 }
    odd_hash = { b: 3, d: 1 }

    describe '#my_each' do
      result = []

      it 'will return the hash itself' do
        expect(hash.my_each { |(k, v)| result << "#{k}: #{v**2}" }).to eq(hash)
      end

      it 'will call block once for each key in hash, passing the key-value pair as parameters.' do
        expect(result).to eq(['a: 16', 'b: 9', 'c: 4', 'd: 1'])
      end

      context 'when no block is given' do
        it 'will return self as an Enumerator' do
          expect(hash.my_each).to be_an(Enumerator)
          expect(hash.my_each.to_a).to eq(hash.to_a)
        end
      end
    end

    describe '#my_each_with_index' do
      result = []

      it 'will return the array itself' do
        expect(hash.my_each_with_index { |(k, v), i| result << "#{k}: #{v**2}, i:#{i}" }).to eq(hash)
      end

      it 'will call block with two arguments, the (key, value) pair and its index, for each item in hash.' do
        expect(result).to eq(['a: 16, i:0', 'b: 9, i:1', 'c: 4, i:2', 'd: 1, i:3'])
      end

      context 'when no block is given' do
        it 'will return self as an Enumerator that includes the index.' do
          expect(hash.my_each_with_index).to be_an(Enumerator)
          expect(hash.my_each_with_index.to_a).to eq([[[:a, 4], 0], [[:b, 3], 1], [[:c, 2], 2], [[:d, 1], 3]])
        end
      end
    end

    describe '#my_select' do
      it 'will return a new hash consisting of entries for which the block returns true.' do
        expect(hash.my_select { |(_k, v)| v.even? }).to eq(even_hash)
      end

      it 'will return empty hash if hash is empty.' do
        expect({}.my_select(&:even?)).to eq({})
      end

      context 'when no block is given' do
        it 'will return self as an Enumerator' do
          expect(hash.my_select).to be_an(Enumerator)
          expect(hash.my_select.to_a).to eq(hash.to_a)
        end
      end
    end

    describe '#my_all?' do
      it 'will return true if the block never returns false or nil.' do
        expect(even_hash.my_all? { |(_k, v)| v.even? }).to be true
      end

      it 'will return false if the block ever returns false or nil' do
        expect(hash.my_all? { |(_k, v)| v.even? }).to be false
      end

      it 'will return true if hash is empty' do
        expect({}.my_all? { |(_k, v)| v.even? }).to be true
      end

      context 'when given a pattern.' do
        it 'will always return false' do
          expect({ a: 'cat' }.my_all?(/t/)).to be false
        end
      end

      context 'when no block is given' do
        it 'will always return true' do
          expect({}.my_all?).to be true
          expect({a: false, b: nil}.my_all?).to be true
        end
      end
    end

    describe '#my_any?' do
      it 'will return true if the block ever returns a value other than false or nil.' do
        expect(hash.my_any? { |(_k, v)| v.even? }).to be true
      end

      it 'will return false if the block never returns a value other than false or nil.' do
        expect(hash.my_any? { |(_k, v)| v.even? }).to be true
      end

      it 'will return false if hash is empty.' do
        expect({}.my_any?(&:even?)).to be false
      end

      context 'when given a pattern.' do
        it 'will always return false' do
          expect({ a: 'cat' }.my_any?(/t/)).to be false
        end
      end

      context 'when no block is given' do
        it 'will return true unless hash is empty.' do
          expect(hash.my_any?).to be true
        end
      end
    end

    describe '#my_my_none?' do
      it 'will return true if the block never returns true.' do
        expect(odd_hash.my_none? { |(_k, v)| v.even? }).to be true
      end

      it 'will return false if the block ever returns true.' do
        expect(hash.my_none?{ |(_k, v)| v.even? }).to be false
      end

      it 'will return true if hash is empty.' do
        expect({}.my_none?{ |(_k, v)| v.even? }).to be true
      end

      context 'when given a pattern.' do
        it 'will always return true' do
          expect(hash.my_none?(/t/)).to be true
        end
      end

      context 'when no block is given' do
        it 'will return false unless hash is empty.' do
          expect(hash.my_none?).to be false
        end
      end
    end
  end
end
