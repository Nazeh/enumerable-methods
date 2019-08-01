# enumerable_methods

Implementation of some Enumerable Methods with Ruby, with support for Arrays and Hashes.

>The Enumerable mixin provides collection classes with several traversal and searching methods, and with the ability to sort. The class must provide a method each*, which yields successive members of the collection.
[Read more](https://ruby-doc.org/core-2.6.3/Enumerable.html)

## Limitations

In this respositry I tried to replicate most of the behaviour of the original methods. however, there is two main differences:

- Unlike **#each** which is provided by each enumerable object, **#my_each** as to add special clause for each object type, input the key-value pair in parentheses.
  
- Unlike the original methods, you have to always input the key-value pair in paranthesis.

``` c
hash.my_each { |(k, v)| result << "#{k}: #{v**2}" }
hash.my_each_with_index { |(k, v), i| result << "#{k}: #{v**2}, i:#{i}" }
hash.my_all? { |(_k, v)| v.even? }
```

- In **#my_select** method, you need to add special clause for each object type.

## Installation

### Prerequisites

**[Ruby 2.5.0+](https://www.ruby-lang.org/en/downloads/)**

#### RSpec 3.0+

```console
gem install rspec
```

### Install

```console
git clone git@github.com:Nazeh/enumerable-methods.git
cd enumerable-methods
```

### Run

**Run tests:**

```console
rspec
```
See result in [Specs.md](Specs.md)

## Live version

Check it on **[Repl.it](https://repl.it/@Nazeh1/Eenumerable-methods)**

## Authors

- **[Ar Nazeh](https://github.com/Nazeh)**
