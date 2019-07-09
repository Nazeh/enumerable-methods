# frozen_string_literal: true

# Enumerable module
module Enumerable
  def my_each
    # code here
  end
end

# testcase
my_array = (1..4).to_a

# EACH
my_array.each{ |e| p e }
my_array.my_each{ |e| p e }

# EACH_WITH_INDEX
my_array.each_with_index{ |e, i| p "element: #{e}, index: #{i}" }
my_array.my_each_with_index{ |e, i| p "element: #{e}, index: #{i}" }

# SELECT
p my_array.select{ |item| item%2==0 }
p my_array.my_select{ |item| item%2==0 }

# ALL?
p my_array.all?{ |e| e > 1 }
p my_array.my_all?{ |e| e > 1 }

# ANY?
p my_array.any?{ |e| e < 1 }
p my_array.my_any?{ |e| e < 1 }

# NONE?
p my_array.none?{ |e| e > 1 }
p my_array.my_none?{ |e| e > 1 } 

# COUNT
p my_array.count { |e| e%2 == 1 }
p my_array.my_count { |e| e%2 == 1 }
p my_array.count 3
p my_array.my_count 3

# MAP
p my_array.map { |e| e ** 2 }
p my_array.my_map { |e| e ** 2 }
proc = Proc.new { |e| e ** 2 }
p my_array.my_map(proc)

# INJECT
p my_array.inject(:+)
p my_array.my_inject(:+)
p my_array.inject(1) { |product, n| product * n }
p my_array.my_inject(1) { |product, n| product * n }
p my_array.inject(1, :*)
p my_array.my_inject(1, :*)          
p my_array.inject{ |sum, n| sum + n }
p my_array.my_inject{ |sum, n| sum + n }
p multiply_els([2,4,5])