# frozen_string_literal: true

# Enumerable module
module Enumerable
  def my_each
    return to_my_enum unless block_given?

    (array = to_a).length.times { |i| yield(array[i].first, array[i].last, i) } if instance_of? Hash
    length.times { |i| yield(self[i], i) } if instance_of? Array
    self
  end

  def my_each_with_index
    unless block_given?
      # need to add index to an array before onverting it to Enumerator
      res = []
      my_each_with_index { |(k, v), i| res << [[k, v], i] } if instance_of? Hash
      my_each_with_index { |e, i| res << [e, i] } if instance_of? Array
      return res.to_my_enum
    end

    return my_each { |e, i| yield(e, i) } if instance_of? Array

    my_each { |k, v, i| yield([k, v], i) } if instance_of? Hash
  end

  # converts an array to Enumerator, because I think it uses #each
  def to_my_enum
    Enumerator.new do |y|
      my_each { |e| y << e } if instance_of? Array
      my_each { |k, v| y << [k, v] } if instance_of? Hash
    end
  end

  def my_select
    res = []
    my_each { |e| res << e if yield(e) }
    res
  end

  def my_all?
    my_each { |e| return false unless yield(e) }
    true
  end

  def my_any?
    my_each { |e| return true if yield(e) }
    false
  end

  def my_none?
    my_each { |e| return false if yield(e) }
    true
  end

  def my_count(arg = nil)
    return my_select { |e| yield(e) }.length if block_given?
    return my_select { |e| e == arg }.length unless arg.nil?

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
