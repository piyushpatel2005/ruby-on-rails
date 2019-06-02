# Ruby Basics

Ruby is highly object-oriented language. It is interpreted language.

```ruby
1.next.next # 3
# If we want to find the methods for an object
1.methods # returns methods
1.methods.sort # sort the methods in order
2.between?(1,3) # passing arguments to method
3.+(4) # invoke + method on number 3
```

Ruby makes exception in its syntactic rules for commonly used operators so you don't have to use periods to invoke them on objects.

```ruby
1 + 2 # same as 1.+(2)
words = ["foo", "bar", "baz"]
words.[](1) # same as words[1]
words[1]
```

We can create Strings using single quotes or double quotes. Double quotes allow for string interpolation and escape sequences like '\n', '\t', etc.

```ruby
'test'.length # find length of a string
a = 1
puts "The number is #{a}" # print with string interpolation

# defining function
def string_length_interpolater(incoming_string)
  "The string you just gave me has a length of #{incoming_string.length}"
end

"Hello world".include?("world")
"Hello world".starts_with?("Hello")
"Hello world".ends_with?('world')
"Hello world".index('w')
"Hello".upcase
"Hello".downcase
"Hello".swapcase
"Hello World".split(' ')
"Hello".concat("World") # same as "Hello"+"World"
"I am not the one but I want to be".sub('I','We') # replace first match with another
"I am not the one but I want to be".gsub('I','We') # replace all match with another
'Hello'.gsub(/[aeiou]/,'1') # search with regex
'Hello World is great'.match(/ ./) # find character next to space
'Hello world is great'.match(/ ./, 6) # find second match
```

## Conditionals

Ruby provides conditional statements like `if ... elsif ... else ... end`. The conditional expressions also work with truthiness of objects.

```ruby
def check_sign(number)
  if number > 0
    "#{number} is positive"
  elsif number == 0
    "#{number} is zero"
  else
    "#{number} is negative"
  end        
end

# unless structure
age = 10
unless age >= 18
    puts "Sorry, you need to be at least eighteen to drive a car. Grow up fast!"
end

# ternary operator
def check_sign(number)
  number > 0 ? "#{number} is positive" : "#{number} is negative"
end
```

# Loops

In Ruby, instance methods are indicated as `Array#select` and `Array#each`.

```ruby
# Infinite loops
a = 1
loop do
  a += 1
  break if a == 5
end

# run a block N times
5.times do
  puts "Hello"
end
```

## Arrays

We can create array using `[]` or using `Array.new`. Ruby Array objects can contain data of different types and one array can contain another nested array. We can use negative indexes to retrieve elements of an array.

```ruby
arr = [1,2,3,4,5]
arr[1] # 2
arr[-5] # 5
# Add elements to array
arr << 6
arr.push(6)
arr.map { |i| i + 1 } # transforming array
[1,2,3,4,5,6].select {|number| number % 2 == 0} # filter elements
[1,2,3,4].delete(3) # delete 3 from array
[1,2,3,4,5,6,7].delete_if{|i| i < 4 }

array = [1, 2, 3, 4, 5]
for i in array
  puts i
end

def array_copy(source)
  destination = []
  # your code
  for number in source
    destination.push(number) if number < 4
  end
  return destination
end

array = [1, 2, 3, 4, 5]
array.each do |i|
  puts i
end
```

## Hash

Hash is a key-value pair. It can be created with `{}`.

```ruby
restaurant_menu = {
  "Ramen" => 3,
  "Dal Makhani" => 4,
  "Tea" => 2
}
restaurant_menu["Ramen"] # fetching value
restaurant_menu["Dal Makhani"] = 4.5 # change value
# Iterating through hashes
restaurant_menu.each do | item, price |
  puts "#{item}: $#{price}"
end
restaurant_menu.keys # get keys
restaurant_menu.values # get values
```


## Classes

Classes are created using `new` method. They are named with capital letters. Classes can contain state and behaviour using attributes and methods. In Ruby last expression is returned by the method, so we don't need to use return statement.

```ruby
# check class of an object
puts 1.class
# ask a class if it is of some class type
1.is_a?(String) # check if 1 is a string
1.is_a?(Integer)
1.class.class
Object.new # object can also be build using new method

# Create a class Rectangle with perimeter method
class Rectangle
  def perimeter
  end
end

# Instance variables are defined using @ symbol. We don't need to declare them upfront like java.
class Rectangle
  def perimeter
    2 * (@length + @breadth)
  end
end

# class with constructor named `initialize` in Ruby
class Rectangle
  def initialize(length, breadth)
    @length = length
    @breadth = breadth
  end

  def perimeter
    2 * (@length + @breadth)
  end
end

next_method_object = 1.method("next")
puts next_method_object.call # 2
```

In Ruby, parameters can have default values too. For passing multiple parameters, we can use splat operator (*). We can use `inject` method to iterate over arguments. This allows to provide first value if we want to do sum. We can also use splat operator to convert arrays to parameter list.

```ruby
def add(*numbers)
  numbers.inject(0) { |sum, number| sum + number }
end
# convert array to parameter list
def add(a_number, another_number, yet_another_number)
  a_number + another_number + yet_another_number
end

numbers_to_add = [1, 2, 3] # Without a splat, this is just one parameter
puts add(*numbers_to_add)

def add(*numbers)
  numbers.inject(0) { |sum, number| sum + number }
end

def add_with_message(message, *numbers)
  "#{message} : #{add(*numbers)}"
end

puts add_with_message("The Sum is", 1, 2, 3)

def introduction(age, gender, *names)
  name_str = names.join(" ")
  return "Meet #{name_str}, who's #{age} and #{gender}"
end

def add(a_number, another_number, options = {})
  sum = a_number + another_number
  sum = sum.abs if options[:absolute]
  sum = sum.round(options[:precision]) if options[:round]
  sum
end

puts add(1.0134, -5.568)
puts add(1.0134, -5.568, absolute: true)
# Ruby allows to skip curly braces if the last parameter is a hash.
# We can pass options to modify the output of the function.
puts add(1.0134, -5.568, absolute: true, round: true, precision: 2)

def add(*numbers)
  numbers.inject(0) { |sum, number| sum + number }  
end

def subtract(*numbers)
  current_result = numbers.shift
  numbers.inject(current_result) { |current_result, number| current_result - number }  
end

def calculate(*arguments)
  # if the last argument is a Hash, extract it 
  # otherwise create an empty Hash
  options = arguments[-1].is_a?(Hash) ? arguments.pop : {}
  options[:add] = true if options.empty?
  return add(*arguments) if options[:add]
  return subtract(*arguments) if options[:subtract]
end
```

## Lambdas

Lambda is just an anonymous function. The last expression of lambda is the return value. In Ruby, the convention is to use `{}` for single line lambda functions.

```ruby
l = lambda { "Do or do not" }
puts l.call

l = lambda do |string|
  if string == "try"
    return "There's no such thing" 
  else
    return "Do or do not."
  end
end
puts l.call("try")
```

A block is a piece of code that can't be stored in a variable and isn't an object. It is faster than a lambda


```ruby
# block example
def demonstrate_block(number)
  yield(number)
end

puts demonstrate_block(1) { |number| number + 1 }
```

## Modules

Modules allow us to create group of methods that we can include or mix into any number of classes. Modules only hold behavior.
In order to include a module into a class, we use the method `include` which takes on parameter - the name of a module. All modules in Ruby are instances of `Module`. This `Module` is superclass of `Class`.

```ruby
module WarmUp
  def push_ups
    "Phew, I need a break!"
  end
end

class Gym
  include WarmUp
  
  def preacher_curls
    "I'm building my biceps."
  end
end

puts Gym.new.push_ups

module Perimeter
  def perimeter
    sides.inject(0) { |sum, side| sum + side }
  end
end

class Rectangle
  # Your code here
  include Perimeter
  
  def initialize(length, breadth)
    @length = length
    @breadth = breadth
  end

  def sides
    [@length, @breadth, @length, @breadth]
  end
end

class Square
  # Your code here
  include Perimeter
  
  def initialize(side)
    @side = side
  end

  def sides
    [@side, @side, @side, @side]
  end
end
```

**Namespacing** is a way of bundling related objects together. This allows classes or modules with conflicting names to co-exist while avoiding collisions. Modules can also have classes to avoid namespace collision. `::` is a lookup operator that looks for Array class only in the `Perimeter` module.

```ruby
module Perimeter
  class Array
    def initialize
      @size = 400
    end
  end
end

our_array = Perimeter::Array.new
ruby_array = Array.new

p our_array.class
p ruby_array.class

# class Push
#   def up
#     40
#   end
# end
require "gym" # up returns 40
gym_push = Push.new
p gym_push.up

# class Push
#   def up
#     30
#   end
# end
require "dojo" # up returns 30
dojo_push = Push.new
p dojo_push.up
```

We can import modules using `require` method. We can also namespace constants.

```ruby
module Dojo
  A = 4
  module Kata
  	B = 8
    module Roulette
      class ScopeIn
        def push
          15
        end
      end
    end
  end
end

A = 16
B = 23
C = 42

puts "A - #{A}"
puts "Dojo::A - #{Dojo::A}"

puts

puts "B - #{B}"
puts "Dojo::Kata::B - #{Dojo::Kata::B}"

puts

puts "C - #{C}"
puts "Dojo::Kata::Roulette::ScopeIn.new.push - #{Dojo::Kata::Roulette::ScopeIn.new.push}"

module Kata
  A = 5
  module Dojo
    B = 9
    A = 7
    
    class ScopeIn
      def push
      # If we prepend constant with :: without a parent, the scoping happens on the topmost level
        ::A # 10
      end
    end
  end
end

A = 10
```

## I/O Streams and classes

An input/output stream is a sequence of data bytes that are accessed sequentially or randomly. Ruby defines constants `STDOUT`, `STDIN` and `STDERR` that are IO objects pointing to your program's output, input and error streams that you can use through terminal. Whenever we call `puts`, the output is sent to the `IO` object that `STDOUT` points to. The `Kernel` module provides us with global variables `$stdout`, `$stdin` and `$stderr` which points to the same IO objects.

```ruby
p STDOUT.class
p STDOUT.fileno
  
p STDIN.class
p STDIN.fileno

p STDERR.class 
p STDERR.fileno
```

We can use `File` class to open and read files.

```ruby
mode = "r+"
file = File.open("friend-list.txt", mode)
puts file.inspect
puts file.read
file.close

what_am_i = File.open("clean-slate.txt", "w") do |file|
  file.puts "Call me Piyush."
end

p what_am_i

File.open("clean-slate.txt", "r") {|file| puts file.read }

file = File.open("master", "r+")

p file.read
file.rewind
buffer = ""
p file.read(23, buffer)
p buffer

file.close

p File.read("sample.txt")

File.open("sample.txt") do |f|
  f.seek(20, IO::SEEK_SET)
  p f.read(10)
end

# user readlines
lines = File.readlines("monk")
p lines # print lines as array
p lines[0] # read only first line
```

To write to an I/O stream, we can use `IO#write` method and pass string.

```ruby
File.open("test.txt", "r") do |f|
  puts f.read
end


File.open("test.txt", "w") do |f|
  File.write("Test text")
end
```