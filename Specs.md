```console
Enumerable
  when called on an Array
    #my_each
      will return the array itself
      will call the given block once for each element in self, passing that element as a parameter
      when no block is given
        will return self as an Enumerator
    #my_each_with_index
      will return the array itself
      will call block with two arguments, the element and its index, for each item in enum.
      when no block is given
        will return self as an Enumerator that includes the index.
    #my_select
      will return an array containing all elements of ary for which the given block returns a true value.
      will return empty array if array is empty.
      when no block is given
        will return self as an Enumerator
    #my_all?
      will return true if the block never returns false or nil.
      will return false if the block ever returns false or nil.
      will return true if array is empty.
      when given a pattern.
        will return whether pattern === element for every element
      when no block is given, it adds an implicit block of { |obj| obj }
        will return true when none are false or nil.
        will return false when any are false or nil.
    #my_any?
      will return true if the block ever returns a value other than false or nil.
      will return false if the block never returns a value other than false or nil.
      will return false if array is empty.
      when given a pattern.
        will return whether pattern === element for any element
      when no block is given
        will return true if any element are neither false or nil.
        will return false if any element is false or nil.
    #my_my_none?
      will return true if the block never returns true.
      will return false if the block ever returns true.
      when given a pattern.
        returns whether pattern === element for my_none of collection member
      when no block is given
        will return false if any of the collection members is true.
        will return true only if my_none of the collection members is true.
    #my_count
      will return number of items in array.
      when given an argument.
        will return the number of items equal to the argument.
      when given an argument.
        will return the number of elements yielding a true value.
    #my_map
      will return a new array with the results of running block once for every element in enum.
      when no block is given.
        will return an enumerator instead
    #my_inject
      when given block
        will be passed an accumulator value (memo) and the element, for each element then return memo.
        when when no initial value for memo is  explicitly specify.
          will use the first element as the initial value of memo
      when given symbol instead of block
        will be passed an accumulator value (memo) and the element, for each element then return memo.
        when when no initial value for memo is  explicitly specify.
          will use the first element as the initial value of memo

Enumerable
  when called on a Hash
    #my_each
      will return the hash itself
      will call block once for each key in hash, passing the key-value pair as parameters.
      when no block is given
        will return self as an Enumerator
    #my_each_with_index
      will return the array itself
      will call block with two arguments, the (key, value) pair and its index, for each item in hash.
      when no block is given
        will return self as an Enumerator that includes the index.
    #my_select
      will return a new hash consisting of entries for which the block returns true.
      will return empty hash if hash is empty.
      when no block is given
        will return self as an Enumerator
    #my_all?
      will return true if the block never returns false or nil.
      will return false if the block ever returns false or nil
      will return true if hash is empty
      when given a pattern.
        will always return false
      when no block is given
        will always return true
    #my_any?
      will return true if the block ever returns a value other than false or nil.
      will return false if the block never returns a value other than false or nil.
      will return false if hash is empty.
      when given a pattern.
        will always return false
      when no block is given
        will return true unless hash is empty.
    #my_my_none?
      will return true if the block never returns true.
      will return false if the block ever returns true.
      will return true if hash is empty.
      when given a pattern.
        will always return true
      when no block is given
        will return false unless hash is empty.
    #my_count
      will return number of items in hash.
      when given an argument.
        will return Zero because it cant take an argument of key-value pair
      when given an argument.
        will return the number of elements yielding a true value.
    #my_map
      will return a new array with the results of running block once for every element in enum.
      when no block is given.
        will return an enumerator instead
    #my_inject
      when given block
        will be passed an accumulator value (memo) and the element, for each element then return memo.

Finished in 0.01527 seconds (files took 0.12413 seconds to load)
65 examples, 0 failures
```