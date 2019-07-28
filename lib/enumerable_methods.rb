# frozen_string_literal: true

# Enumerable module
module Enumerable
  def my_each
    return to_my_enum unless block_given?

    to_a.my_each { |e, i| yield([e.first, e.last], i) } if instance_of? Hash
    length.times { |i| yield(self[i], i) } if instance_of? Array
    self
  end

  def my_each_with_index
    unless block_given?
      # need to add index to an array before onverting it to Enumerator
      res = []
      my_each { |e, i| res << [e, i] }
      return res.to_my_enum
    end

    my_each { |e, i| yield(e, i) }
  end

  # converts an array to Enumerator, because it uses #each
  def to_my_enum
    Enumerator.new { |y| my_each { |e| y << e } }
  end

  def my_select
    return to_my_enum unless block_given?

    res = []
    my_each { |e| res << e if yield(e) }

    instance_of?(Hash) ? res.to_h : res
  end

  def my_all?(pattern = nil)
    unless pattern.nil?
      return false if instance_of?(Hash)

      return my_all? { |e| pattern.match(e) }
    end

    return my_all? { |e| e } unless block_given?

    my_each { |e| return false unless yield(e) }
    true
  end

  def my_any?(pattern = nil)
    unless pattern.nil?
      return false if instance_of?(Hash)

      return my_any? { |e| pattern.match(e) }
    end

    return my_any? { |e| e } unless block_given?

    my_each { |e| return true if yield(e) }
    false
  end

  def my_none?(*pattern)
    return !my_any?(*pattern) unless block_given?

    !my_any? { |e| yield(e) }
  end

  def my_count(arg = nil)
    return my_select { |e| yield(e) }.length if block_given?
    return my_select { |e| e == arg }.length unless arg.nil?

    length
  end

  def my_map
    res = []
    return to_my_enum unless block_given?

    my_each { |e| res << yield(e) }
    res
  end

  def my_inject(memo = nil, sym = nil)
    # make sure it can take custom memo and symbol procs like :+
    return my_inject(nil, memo) if memo.is_a? Symbol

    return my_inject(memo) { |mem, e| :+.to_proc.call(mem, e) } unless sym.nil?

    my_each { |e| memo = memo.nil? ? first : yield(memo, e) }
    memo
  end
end
