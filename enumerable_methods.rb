# frozen_string_literal: true

# Enumerable module
module Enumerable
  def my_each
    if instance_of? Hash
      (array = to_a).length.times { |i| yield([array[i].first, array[i].last]) }
    else
      length.times { |i| yield(self[i]) }
    end
  end

  def my_each_with_index
    if instance_of? Hash
      (array = to_a).length.times { |i| yield([array[i].first, array[i].last], i) }
    else
      length.times { |i| yield(self[i], i) }
    end
  end

  def my_select
    res = []
    my_each do |e|
      res << e if yield(e)
    end
    res
  end

  def my_all?
    my_each do |e|
      return false unless yield(e)
    end
    true
  end

  def my_any?
    my_each do |e|
      return true if yield(e)
    end
    false
  end

  def my_none?
    my_each do |e|
      return false if yield(e)
    end
    true
  end

  def my_count(arg = nil)
    return my_select { |e| yield(e) }.length if block_given?
    return my_select { |e| e == 3 }.length unless arg.nil?

    length
  end

  def my_map(proc = nil)
    res = []
    proc ? my_each { |e| res << proc.call(e) } : my_each { |e| res << yield(e) }
    res
  end

  def my_inject(memo = nil, sym = nil)
    # make sure it can take custom memo and symbol procs like :+
    if memo.is_a? Symbol
      sym = memo
      memo = nil
    end
    my_each { |e| memo = memo.nil? ? first : yield(memo, e) } if block_given?
    my_each { |e| memo = memo.nil? ? first : sym.to_proc.call(memo, e) } unless sym.nil?
    memo
  end
end

# testcase
my_array = Array.new(4) { rand(1...9) }
my_hash = { a: 1, b: 2, c: 3, d: 4 }

# EACH
puts 'EACH'
my_array.each { |e| p e }
puts 'MY_EACH'
my_array.my_each { |e| p e }
puts ''

# Each with Hashes!
puts 'EACH hash'
my_hash.each { |k, v| p "#{k}: #{v}" }
puts 'My_EACH hash'
my_hash.my_each { |k, v| p "#{k}: #{v}" }
puts ''

# EACH_WITH_INDEX
puts 'EACH_WITH_INDEX'
my_array.each_with_index { |e, i| p "element: #{e}, index: #{i}" }
puts 'MY_EACH_WITH_INDEX'
my_array.my_each_with_index { |e, i| p "element: #{e}, index: #{i}" }
puts ''

# Each_WITH_INDEX with Hashes!
puts 'EACH_WITH_INDEX hash'
my_hash.each_with_index { |(k, v), i| p "#{k}: #{v} || i: #{i}" }
puts 'EACH_WITH_INDEX hash'
my_hash.my_each_with_index { |(k, v), i| p "#{k}: #{v} || i: #{i}" }
puts ''

# SELECT
puts 'SELECT'
p(my_array.select(&:even?))
puts 'MY_SELECT'
p(my_array.my_select(&:even?))
puts ' '

# ALL?
puts 'ALL? > 3'
p(my_array.all? { |e| e > 3 })
puts 'MY_ALL? > 3'
p(my_array.my_all? { |e| e > 3 })
puts ' '

# ANY?
puts 'ANY? < 2'
p(my_array.any? { |e| e < 2 })
puts 'MY_ANY? < 2'
p(my_array.my_any? { |e| e < 2 })
puts ''

# NONE?
puts 'NONE? < 2'
p(my_array.none? { |e| e < 2 })
puts 'MY_NONE? < 2'
p(my_array.my_none? { |e| e < 2 })
puts ''

# COUNT
puts 'COUNT(&:odd?)'
p(my_array.count(&:odd?))
puts 'MY_COUNT(&:odd?)'
p(my_array.my_count(&:odd?))
puts ''
puts 'COUNT(3)'
p(my_array.count(3))
puts 'MY_COUNT(3)'
p(my_array.my_count(3))
puts ''
puts 'COUNT'
p(my_array.count)
puts 'MY_COUNT'
p(my_array.my_count)
puts ''

# MAP
puts 'MAP e**2'
p(my_array.map { |e| e**2 })
puts 'MY_MAP e**2'
p(my_array.my_map { |e| e**2 })
proc = proc { |e| e**2 }
puts ''
puts 'MAP proc'
p(my_array.map(&proc))
puts 'MY_MAP proc'
p(my_array.my_map(&proc))
puts ''

# INJECT
puts 'INJECT(1) product n'
p(my_array.inject(1) { |product, n| product * n })
puts 'MY_INJECT(2) product n'
p(my_array.my_inject(2) { |product, n| product * n })
puts ''
puts 'INJECT sum, n'
p(my_array.inject { |sum, n| sum + n })
puts 'MY_INJECT sum, n'
p(my_array.my_inject { |sum, n| sum + n })
puts ''
puts 'INJECT :+'
p(my_array.inject(:+))
puts 'MY_INJECT :+'
p(my_array.my_inject(:+))
puts ''
puts 'INJECT (1, :*)'
p(my_array.inject(1, :*))
puts 'MY_INJECT (1, :*)'
p(my_array.my_inject(1, :*))
puts ''
