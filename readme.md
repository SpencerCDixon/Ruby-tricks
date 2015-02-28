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
