## Ruby Tricks

### Table of Contents


Returning multiple values:
```ruby
def multiple
  return 1, 2
end

x = multiple
# => [ 1, 2 ]
x
# => [ 1, 2 ]
```

assigning multiple variables to a method that returns two things:
```ruby
x, y = multiple
# => [ 1, 2 ]
x
# => 1
y
# => 2
```

switching the references in memory:
```ruby
a, b = 1, 2
# => [1, 2]
a, b = b, a
# => [2, 1]
a
# => 2
b
# => 1
```

Here is an example from Ruby Koans of this object reassignment:
```ruby
def test_swapping_with_parallel_assignment
  first_name = "Roy"
  last_name = "Rob"
  first_name, last_name = last_name, first_name
  assert_equal "Rob", first_name
  assert_equal "Roy", last_name
end
```


Multiple assignment with splat operator (ruby koans)
```ruby
def test_parallel_assignments_with_splat_operator
  first_name, *last_name = ["John", "Smith", "III"]
  assert_equal "John", first_name
  assert_equal ["Smith", "III"], last_name
end
```

Hashes are not ordered:
```ruby
def test_hash_is_unordered
  hash1 = { :one => "uno", :two => "dos" }
  hash2 = { :two => "dos", :one => "uno" }

  assert_equal true, hash1 == hash2
end
```

Setting a hash's default as an array will only use one array, not a new one for
each key/value pair:
```ruby
def test_default_value_is_the_same_object
  hash = Hash.new([])

  hash[:one] << "uno"
  hash[:two] << "dos"

  assert_equal ["uno", "dos"], hash[:one]
  assert_equal ["uno", "dos"], hash[:two]
  assert_equal ["uno", "dos"], hash[:three]

  assert_equal true, hash[:one].object_id == hash[:two].object_id
end
```

Making hash with a block default in order to set each key/value pair:
```ruby
def test_default_value_with_block
  hash = Hash.new {|hash, key| hash[key] = [] }

  hash[:one] << "uno"
  hash[:two] << "dos"

  assert_equal ["uno"], hash[:one]
  assert_equal ["dos"], hash[:two]
  assert_equal [], hash[:three]
end
```

Shovel operator (<<) will modify original string:
```ruby
def test_the_shovel_operator_modifies_the_original_string
  original_string = "Hello, "
  hi = original_string
  there = "World"
  hi << there
  assert_equal "Hello, World", original_string

  # THINK ABOUT IT:
  #
  # Ruby programmers tend to favor the shovel operator (<<) over the
  # plus equals operator (+=) when building up strings.  Why?
end
```

Not only do method names become symbols but so do constants:
```ruby
RubyConstant = "What is the sound of one hand clapping?"
def test_constants_become_symbols
  all_symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }

  assert_equal true, all_symbols_as_strings.include?("RubyConstant")
end
```

Symbols can be made with string interpolation:
```ruby
def test_symbols_with_interpolation_can_be_built
  value = "and"
  symbol = :"cats #{value} dogs"

  assert_equal "cats and dogs".to_sym, symbol
end
```

Regexp \b word boundary example:
```ruby
def test_slash_b_anchors_to_a_word_boundary
  assert_equal "vines", "bovine vines"[/\bvine./]
end
```

Using parenthesis in Regexp to capture specific parts of a regex:
```ruby
def test_parentheses_also_capture_matched_content_by_number
  assert_equal "Gray", "Gray, James"[/(\w+), (\w+)/, 1]
  assert_equal "James", "Gray, James"[/(\w+), (\w+)/, 2]
end
```

Regexp will save global variables in number format to access specific pieces of
the regex:
```ruby
def test_variables_can_also_be_used_to_access_captures
  assert_equal "Gray, James", "Name:  Gray, James"[/(\w+), (\w+)/]
  assert_equal "Gray", $1
  assert_equal "James", $2
end
```

Using send to execute methods with paramters:
```ruby
class Klass
  def hello(*args)
    "Hello " + args.join(' ')
  end
end
k = Klass.new
k.send :hello, "gentle", "readers"   #=> "Hello gentle readers"
```

