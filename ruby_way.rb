### Notes From The Ruby Way ####

=begin
The Law of Least Astonishment (aka Principle of Least Surprise) - the program should
always respond to the user in the way that astonishes him least.
=end

# Executing system commands in ruby:

puts `ls -al`

# Shortcut for writing arrays of strings:
%w{one two there four five}

# Shortcut for writing arrays of symbols:
%i{one two there four five}

module IncludeTest
  def hello
    puts "hello world"
  end
end

class IncludedClass
  include IncludeTest
end

class ExtendedClass
  extend IncludeTest
end

a = IncludedClass.new
a.hello # => "hello world"
ExtendedClass.hello_world # => "hello world"

# Extending a class is the same as including a module in the singleton
class SecondExtendedClass
  class << self
    include IncludeTest
  end
end
SecondExtendedClass.hello # => "hello world"

# Named Parameters

def mymethod(name: "default", options: {})
  options.merge!(name: name)
  some_action_with(options)
end

# Memoizing behind the hood

x ||= 5

# is equivalent to:

x = x || 5

# Whats difference between:
# mymethod param1, foobar do ... end
# and
# mymethod param1, foobar { ... }

# Singleton Class

str = "hello"
class << str
  def hyphenated
    self.split("").join("-")
  end
end

str.hyphenated   # "h-e-l-l-o"

# Think about it: class methods are just singleton methods on a given class
# object

