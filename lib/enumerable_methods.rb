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
