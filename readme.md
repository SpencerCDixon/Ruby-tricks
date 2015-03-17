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

### Ruby Koan Learning:

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

## Method Information:

`#scan` will return an array of what it finds

```ruby
  def test_scan_is_like_find_all
    assert_equal ["one", "two", "three"], "one two-three".scan(/\w+/)
  end

  def test_sub_is_like_find_and_replace
    assert_equal "one t-three", "one two-three".sub(/(t\w*)/) { $1[0, 1] }
  end

  def test_gsub_is_like_find_and_replace_all
    assert_equal "one t-t", "one two-three".gsub(/(t\w*)/) { $1[0, 1] }
  end
```

Methods with splat arguments will return an empty array if no args are provided,
will prevent nil calls.

```ruby
  def method_with_var_args(*args)
    args
  end

  def test_calling_with_variable_arguments
    assert_equal Array, method_with_var_args.class
    assert_equal [], method_with_var_args
    assert_equal [:one], method_with_var_args(:one)
    assert_equal [:one, :two], method_with_var_args(:one, :two)
  end
```

method with keyword arguments:
```ruby
def method_with_var_args(*args)
  args
end

def test_calling_with_variable_arguments
  assert_equal Array, method_with_var_args.class
  assert_equal [], method_with_var_args
  assert_equal [:one], method_with_var_args(:one)
  assert_equal [:one, :two], method_with_var_args(:one, :two)
end
```

Error inheritance structure in Ruby:
```ruby
  def test_exceptions_inherit_from_Exception
    assert_equal RuntimeError, MySpecialError.ancestors[1]
    assert_equal StandardError, MySpecialError.ancestors[2]
    assert_equal Exception, MySpecialError.ancestors[3]
    assert_equal Object, MySpecialError.ancestors[4]
  end
```

Calling Lamdas with brackets:
```ruby
def test_blocks_can_be_assigned_to_variables_and_called_explicitly
  add_one = lambda { |n| n + 1 }
  assert_equal 11, add_one.call(10)

  # Alternative calling syntax
  assert_equal 11, add_one[10]
end
```

Methods with blocks being called:
```ruby
def method_with_explicit_block(&block)
  block.call(10)
end

def test_methods_can_take_an_explicit_block_argument
  assert_equal 20, method_with_explicit_block { |n| n * 2 }

  add_one = lambda { |n| n + 1 }
  assert_equal 11, method_with_explicit_block(&add_one)
end
```

Sandwhich code (technique for making methods):
```ruby
# Sandwich code is code that comes in three parts: (1) the top slice
# of bread, (2) the meat, and (3) the bottom slice of bread.  The
# bread part of the sandwich almost always goes together, but
# the meat part changes all the time.
```

Classes have a method called #instance_variable_get
```ruby
def test_you_can_politely_ask_for_instance_variable_values
  fido = Dog2.new
  fido.set_name("Fido")

  assert_equal "Fido", fido.instance_variable_get("@name")
end
```

Trying to define a class thats not available will give NameError:
```ruby
def test_dog_is_not_available_in_the_current_scope
  assert_raise(NameError) do
    Dog.new
  end
end
```
Constants can be looked up:
```ruby
def test_constants_can_be_looked_up_explicitly
  assert_equal true, PI == AboutScope.const_get("PI")
  assert_equal true, MyString == AboutScope.const_get("MyString")
end
```
Using method missing in Ruby
```ruby
class WellBehavedFooCatcher
  def method_missing(method_name, *args, &block)
    if method_name.to_s[0,3] == "foo"
      "Foo to you too"
    else
      super(method_name, *args, &block)
    end
  end
end

def test_foo_method_are_caught
  catcher = WellBehavedFooCatcher.new

  assert_equal "Foo to you too", catcher.foo_bar
  assert_equal "Foo to you too", catcher.foo_baz
end
```

Method Missing:
```ruby
class Proxy

  attr_accessor :messages

  def initialize(target_object)
    @object = target_object
    @messages = []
  end

  def method_missing(arg, params = nil)
    if @object.respond_to?(arg)
      messages << arg

      if !params.nil?
        @object.send(arg, params)
      else
        @object.send(arg)
      end
    else
      raise NoMethodError
    end
  end

  def called?(symbol)
    messages.include?(symbol)
  end

  def number_of_times_called(symbol)
    count = 0
    messages.each do |message|
      if message == symbol
        count += 1
      end
    end
    count
  end
end
```

## Sandi Metz POODR

```ruby
class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio 
    chainring / cog.to_f
  end

  def gear_inches
    ratio * (rim + (tire * 2))
  end
end
```

Given that class how can we determine if it has too many responsibilities? Ask
questions like:

*  'Mr. Gear, what is your ratio?' (seems good)  
*  'Mr. Gear, what are your gear_inches?' (shaky ground)  
*  'Mr. Gear, what is your tire size? (downright ridiculous)  
