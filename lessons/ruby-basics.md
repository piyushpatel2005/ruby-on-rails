# Ruby Basics

Ruby was created by Yukihiro Matsumoto (Matz). It is dynamic, object-oriented language. It is influenced by Perl, Smalltalk, Eiffel and Lisp.


```ruby
3.times { puts "Hello World" }
```

In Ruby, use 2 space indentation. # is used for comments. `p` is also used to print internal representation of an object. Ruby variables should be lowercased with snake_case convention. Constants are capital whereas classes and modules are Camel case. We don't need semi colons in Ruby code. For writing multiple statements in same line (which is not recommended), we can use semicolons.

We can run Ruby in interactive mode. We can open Ruby interactive shell by typing `irb` in shell.

Relational operations:
In Ruby, `false` and `nil` are the only objects that are false.

```ruby
puts "0 is true" if 0 # => 0 is true 
puts "false is true?" if "false" # => false is true? 
puts "no way - false is false" if false # => NOTHING PRINTED
puts "empty string is true" if "" # => empty string is true 
puts "nil is true?" if "nil" # => nil is true? 
puts "no way - nil is false" if nil # => NOTHING PRINTED
```

## Conditionals

The conditional control structure looks like this:

```ruby
a = 5 # declare a variable

if  a == 3                    
  puts "a is 3"                  
elsif a == 5 
  puts "a is 5"                   
else                              
  puts "a is not 3 or 5"
end 

# => a is 5

a = 5 

unless a == 6
  puts "a is not 6"
end

# => a is not 6
```

Ruby has modifier form which makes the code very readable.

```ruby
# if modifier form

a = 5 
b = 0 

puts "One liner" if a == 5 and b == 0 
# => One liner

# while modifier form

times_2 = 2 
times_2 *= 2 while times_2 < 100 
puts times_2 # => 128
```

Ruby has triple equals operation which allows to compare regular expression.

```ruby
if /sera/ === "coursera"
  puts "Triple Equals"
end
# => Triple Equals

if "coursera" === "coursera"
  puts "also works"
end
# => also works

if Integer === 21
  puts "21 is an Integer"
end
```

In Ruby, there are two types of case expressions.

```ruby
age = 21

case # 1ST FLAVOR
  when age >= 21
    puts "You can buy a drink" 
  when 1 == 0 
    puts "Written by a drunk programmer"  
  else 
    puts "Default condition"
end 
# => You can buy a drink

name = 'Fisher' 
case name # 2nd FLAVOR
  when /fish/i then puts "Something is fishy here"
  when 'Smith' then puts "Your name is Smith"
end

#=> Something is fishy here
```

## Loops

For loop:

```ruby
for i in 0..2 
  puts i 
end 
```

While loop:

```ruby
a = 10

while a > 9 
  puts a                      
  a -= 1 
  # same as a = a - 1
end

# => 10

# Until Example
a = 9

until a >= 10 
  puts a                       
  a += 1                       
end 

# => 9
```

## Functions

In Ruby, every function/method has at least one class it belongs to. For functions, parenthese are optional both when defining and calling a method. We don't need to declare the datatypes for each parameters. The last expression in the method is the return value for that method, `return` keyword is optional. We can have methods ending with `?`. The methods ending with `!` show methods with side effects.

```ruby

def can_divide_by?(number)
  return false if number.zero?
  true
end

puts can_divide_by? 3 # => true
puts can_divide_by? 0 # => false
```

We can also pass default arguments to methods.

```ruby
def factorial_with_default (n = 5) 
   n == 0? 1 : n * factorial_with_default(n - 1) 
end 

puts factorial 5 # => 120
puts factorial_with_default # => 120 
puts factorial_with_default(3) # => 6
```

Splat arguments allow to pass multiple parameters to methods.

```ruby
def max(one_param, *numbers, another)
  # Variable length parameters passed in 
  # become an array
  numbers.max
end

puts max("something", 7, 32, -4, "more") # => 32
```

In Ruby, **blocks** are iterators. They are usually inside curly braces or inside `do...end` keywords.

```ruby
1.times { puts "Hello World!" }   
# => Hello World! 

2.times do |index| 
  if index > 0 
    puts index 
  end 
end 
# => 1

2.times { |index| puts index if index > 0 }
```

We can use blocks in our code as follows. With implicit method, we use `block_given?` to verify if the block is given. In the explicit way, we include `&` in argument to see if we received any block. If we received block, we call `call` method of the block.

```ruby
# Implicit blocks
def two_times_implicit 
  return "No block" unless block_given? 
  yield 
  yield 
end 

puts two_times_implicit { print "Hello "} # => Hello 
										  # => Hello 
puts two_times_implicit # => No block

# Explicit block
def two_times_explicit (&i_am_a_block) 
  return "No block" if i_am_a_block.nil? 
  i_am_a_block.call 
  i_am_a_block.call 
end 

puts two_times_explicit # => No block 
two_times_explicit { puts "Hello"} # => Hello 
                                   # => Hello 
```

## Files

```ruby
# Reading from a file.
if File.exist? 'test.txt'

  File.foreach( 'test.txt' ) do |line|
    puts line.chomp
  end
end

# Handling exception

begin

  File.foreach( 'do_not_exist.txt' ) do |line|   
    puts line.chomp 
  end

rescue Exception => e
  puts e.message
  puts "Let's pretend this didn't happen..."
end

# Write to a file
# Closing file automatically once block is executed.

File.open("test1.txt", "w") do |file|  
  file.puts "One line"
  file.puts "Another" 
end

# Read and write to environment variable
puts ENV["EDITOR"] # => subl
```

[Case statement assignment](coursera-ruby-on-rails-intro/case-assignment)

## Strings

Strings can be written with single quotes and double quotes. Only double quoted strings allow for string interpolation as well as interpretation of special escape characters. With `%Q`, we can create multi-line string.

```ruby
single_quoted = 'ice cream \n followed by it\'s a party!'
double_quoted = "ice cream \n followed by it\'s a party!" 

puts single_quoted # => ice cream \n followed by it's a party!
puts double_quoted # => ice cream 
                   # =>   followed by it's a party! 

def multiply (one, two) 
  "#{one} multiplied by #{two} equals #{one * two}" 
end 
puts multiply(5, 3) 
# => 5 multiplied by 3 equals 15

my_name = " tim" 
puts my_name.lstrip.capitalize # => Tim 
p my_name # => " tim" 
my_name.lstrip! # (destructive) removes the leading space 
my_name[0] = 'K' # replace the fist character 
puts my_name # => Kim 

cur_weather = %Q{It's a hot day outside 
			     Grab your umbrellas…} 

cur_weather.lines do |line| 
  line.sub! 'hot', 'rainy' # substitute 'hot' with 'rainy' 
  puts "#{line.strip}" 
end 
# => It's a rainy day outside 
# => Grab your umbrellas...
```

Strings api includes many useful methods. Another kind of string is symbol. Symbol is `:` followed by a string. They are highly optimized strings. They are constant names which we don't need to declare before using. Symbols are guaranteed to be unique and immutable. We can convert to string using `to_s` or we can convert string to symbol using `to_sym` method. They are used for method names or keys in Hashes.

We can get all methods names for any object using `"hello".methods.grep /case/` which will give all methods that include "case" word in method names.

## Arrays

Arrays are collection of object references. Arrays can be indexed with negative numbers or ranges. In Runy, arrays can be of heterogeneous types in the same array. We can use `%w{str1 str2}` for string array creation. We can append element using `push` or `<<`, remove elements using `pop` or `shift` method. We can pull random element(s) using `sample` method as well as sort or reverse using `sort!` or `reverse!` method.
Array also has iterator methods like `each`, `select`, `reject` and `map`.

```ruby
het_arr = [1, "two", :three] # heterogeneous types 
puts het_arr[1] # => two (array indices start at 0) 

arr_words = %w{ what a great day today! } 
puts arr_words[-2] # => day
puts "#{arr_words.first} - #{arr_words.last}" # => what - today! 
p arr_words[-3, 2] # => ["great", "day"] (go back 3 and take 2) 

# (Range type covered later...)
p arr_words[2..4] # => ["great", "day", "today!"] 

# Make a String out of array elements separated by ‘,’
puts arr_words.join(',') # => what,a,great,day,today!

# You want a stack (LIFO)? Sure 
stack = []; stack << "one"; stack.push ("two") 
puts stack.pop # => two 

# You need a queue (FIFO)? We have those too... 
queue = []; queue.push "one"; queue.push "two" 
puts queue.shift # => one 

a = [5,3,4,2].sort!.reverse! 
p a # => [5,4,3,2] (actually modifies the array) 
p a.sample(2) # => 2 random elements

a[6] = 33 
p a # => [5, 4, 3, 2, nil, nil, 33]

a = [1, 3, 4, 7, 8, 10] 
a.each { |num| print num } # => 1347810 (no new line) 
puts # => (print new line) 

new_arr = a.select { |num| num > 4 } 
p new_arr # => [7, 8, 10] 
new_arr = a.select { |num| num < 10 }
           .reject{ |num| num.even? } 
p new_arr # => [1, 3, 7] 

# Multiply each element by 3 producing new array
new_arr = a.map {|x| x * 3} 
p new_arr # => [3, 9, 12, 21, 24, 30] 
```

**Ranges** are natural consecutive sequences. For example, 1 to 20, 'a' to 'd'. If there are two dots(..), means all inclusive. If there are three dots (...), last element is exclusive. They are efficient as only start and end is stored. They can be converted to an array using `to_a` method.

```ruby
some_range = 1..3 
puts some_range.max # => 3 
puts some_range.include? 2 # => true 

puts (1...10) === 5.3 # => true 
puts ('a'...'r') === "r" # => false (end-exclusive) 

p ('k'..'z').to_a.sample(2) # => ["k", "w"]
# or another random array with 2 letters in range

age = 55 
case age 
  when 0..12 then puts "Still a baby" 
  when 13..99 then puts "Teenager at heart!" 
  else puts "You are getting older..." 
end 
# => Teenager at heart!
```

## Hashes

Hashes are indexed collections of object references. They are created with `{}` or `Hash.new` method. They are known as associative arrays, maps in other languages. Index can be anything in a Hash. The elements are accessed using `[]`. Values are set using `=>`(hash racket) or `[]`.
If Hash is created with `Hash.new(0)`, then if a key doesn't exists and we try to access a values for that key, we will get 0 else we'll get error.


```ruby
editor_props = { "font" => "Arial", "size" => 12, "color" => "red"} 

# THE ABOVE IS NOT A BLOCK - IT'S A HASH 
puts editor_props.length # => 3 
puts editor_props["font"] # => Arial 

editor_props["background"] = "Blue" 
editor_props.each_pair do |key, value| 
  puts "Key: #{key} value: #{value}" 
end
# => Key: font value: Arial 
# => Key: size value: 12 
# => Key: color value: red 
# => Key: background value: Blue

# Word frequency counter
word_frequency = Hash.new(0) 

sentence = "Chicka chicka boom boom" 
sentence.split.each do |word| 
  word_frequency[word.downcase] += 1 
end 

p word_frequency # => {"chicka" => 2, "boom" => 2}
```

After Ruby 1.9, the order of elements inside Hash is maintained. If we use symbols as elements, there is `symbol:` syntax for creating Hash. If Hash is last argument to a method, we can drop `{}`.

```ruby
family_tree_19 = {oldest: "Jim", older: "Joe", younger: "Jack"} 
family_tree_19[:youngest] = "Jeremy" 
p family_tree_19 
# => {:oldest=>"Jim", :older=>"Joe", :younger=>"Jack“, :youngest => “Jeremy”}

# Named parameter "like" behavior... 
def adjust_colors (props = {foreground: "red", background: "white"}) 
  puts "Foreground: #{props[:foreground]}" if props[:foreground] 
  puts "Background: #{props[:background]}" if props[:background] 
end 
adjust_colors # => foreground: red 
              # => background: white 
adjust_colors ({ :foreground => "green" }) # => foreground: green 
# This works as hash is last element in the method.
adjust_colors background: "yella" # => background: yella 
adjust_colors :background => "magenta" # => background: magenta
```

If we don't assign Hash to a variable, and try to print it directly, Ruby interpreter might get confused as shown below.

```ruby
# Let's say you have a Hash 
a_hash = { :one => "one" } 

# Then, you output it 
puts a_hash # => {:one=>"one"} 

# If you try to do it in one step - you get a SyntaxError 
# puts { :one => "one" } 

# RUBY GETS CONFUSED AND THINKS {} IS A BLOCK!!!

# To get around this - you can use parens 
puts ({ :one => "one" }) # => {:one=>"one"} 

# Or drop the {} altogether... 
puts one: "one"# => {:one=>"one"} 
```

[Collections Assignment](coursera-ruby-on-rails-intro/collections-assignment)

## Classes

Objects are instances of things. Classes are things or blueprints of a thing. Objects contain instance variables (state). Instance variables begin with `@` character. Instance variables are not declared. Objects are created using `new` method on class which calls `initialize` method in class. Object's states are initialized in initializer method. To access instance variables, we have to define getters and setters. Methods by default have public access.

```ruby

class Person 
  def initialize (name, age) # "CONSTRUCTOR" 
    @name = name  # we don't need to declare name instance variable
    @age = age 
  end 
  def get_info 
    @additional_info = "Interesting" 
    "Name: #{@name}, age: #{@age}" 
  end 
end 

person1 = Person.new("Joe", 14) 
p person1.instance_variables # [:@name, :@age] 
puts person1.get_info # => Name: Joe, age: 14 
p person1.instance_variables # [:@name, :@age, :@additional_info] 
```

```ruby
# Getters and setters

class Person 
  def initialize (name, age) # "CONSTRUCTOR" 
    @name = name 
    @age = age 
  end 
  def name 
    @name 
  end 
  def name= (new_name) 
    @name = new_name 
  end 
end 

person1 = Person.new("Joe", 14) 
puts person1.name # Joe 
person1.name = "Mike" 
puts person1.name # Mike 
# puts person1.age # undefined method `age' for #<Person:
```

If we want to create setter and getter methods for all variables, we can easily define them using following.

- `attr_accessor`: getter and setter
- `attr_reader`: getter only
- `attr_writer`: setter only

```ruby
class Person 
  attr_accessor :name, :age # getters and setters for name and age
end 

person1 = Person.new 
p person1.name # => nil 
person1.name = "Mike" 
person1.age = 15 
puts person1.name # => Mike 
puts person1.age # => 15 
person1.age = "fifteen" 
puts person1.age # => fifteen 
```

If we want to customize initialization of instances, we can define `initialize` method inside class. By default, Person is in an uninitialized state. We also want to control age to some numbers. Such customizations are possible with constructor. Inside instance methods, `self` refers to instances whereas outside instance methods `self` refers to class itself. This allows to create static methods like Java which are classwide.

```ruby
class Person 
  attr_reader :age 
  attr_accessor :name 

  def initialize (name, ageVar) # CONSTRUCTOR 
    @name = name 
    self.age = ageVar # call the age= method 
    puts age 
  end 
  def age= (new_age) 
    @age = new_age unless new_age > 120 
  end 
end 

person1 = Person.new("Kim", 13) # => 13 
puts "My age is #{person1.age}" # => My age is 13 
person1.age = 130 # Try to change the age 
puts person1.age # => 13 (The setter didn't allow the change)
```

`||` operator is used to assign to a variable if it hasn't been initialized like `@x = @x || 5`. The short form of this is `@x ||= 5`.

```ruby
class Person 
  attr_reader :age 
  attr_accessor :name 
  
  def initialize (name, age) # CONSTRUCTOR 
    @name = name 
    self.age = age # call the age= method 
  end 
  def age= (new_age) 
    @age ||= 5 # default 
    @age = new_age unless new_age > 120 
  end 
end 
person1 = Person.new("Kim", 130) 
puts person1.age # => 5 (default) 
person1.age = 10 # change to 10 
puts person1.age # => 10 
person1.age = 200 # Try to change to 200 
puts person1.age # => 10 (still) 
```

Class variables begin with `@@`.

```ruby
# Three ways to define class methods
class MathFunctions 
  def self.double(var) # 1. Using self 
    times_called; var * 2; 
  end 
  class << self # 2. Using << self 
    def times_called 
      @@times_called ||= 0; @@times_called += 1 
    end 
  end 
end 
def MathFunctions.triple(var) # 3. Outside of class 
  times_called; var * 3 
end

# No instance created! 
puts MathFunctions.double 5 # => 10 
puts MathFunctions.triple(3) # => 9 
puts MathFunctions.times_called # => 3 
```

Every class implicitly inherits from `Object` and Object inherits from `BasicObject`. Ruby doesn't support multiple inheritance. We can use mixins to get behavior of multiple classes.

```ruby
class Dog 
  def to_s 
    "Dog" 
  end 
  def bark 
    "barks loudly" 
  end 
end 
# SmallDog inherits from Dog class
class SmallDog < Dog 
  def bark # Override 
    "barks quietly" 
  end 
end 

dog = Dog.new # (btw, new is a class method) 
small_dog = SmallDog.new 
puts "#{dog}1 #{dog.bark}" # => Dog1 barks loudly 
puts "#{small_dog}2 #{small_dog.bark}" # => Dog2 barks quietly 
```

## Modules

Module is a container for classes, methods and constants. It serves two main purposes; make namespace and uses of mixins.

```ruby
# module to separate two classes of same name
module Sports 
  class Match
    attr_accessor :score 
  end 
end 

module Patterns 
  class Match 
    attr_accessor :complete 
  end 
end 

match1 = Sports::Match.new
match1.score = 45; puts match1.score # => 45

match2 = Patterns::Match.new
match2.complete = true; puts match2.complete # => true
```

In object oriented languages, we have interfaces. Mixins provide a way to share (mix-in) ready code among multiple classes. 

```ruby
# Module as a mixin
module SayMyName 
  attr_accessor :name 
  def print_name 
    puts "Name: #{@name}" 
  end 
end 

class Person 
  # include SayMyName module and print_name method
  include SayMyName 
end 
class Company 
  include SayMyName 
end 

person = Person.new 
person.name = "Joe" 
person.print_name # => Name: Joe 
company = Company.new 
company.name = "Google & Microsoft LLC" 
company.print_name # => Name: Google & Microsoft LLC
```

Array class actually includes Enumerable module. For including this module in your class, we have to provide implementation of `each` method.

```ruby
# player.rb file
class Player 

  attr_reader :name, :age, :skill_level

  def initialize (name, age, skill_level) 
    @name = name 
    @age = age
    @skill_level = skill_level 
  end

  def to_s 
    "<#{name}: #{skill_level}(SL), #{age}(AGE)>" 
  end 

end 

# team.rb file
class Team 
  include Enumerable # LOTS of functionality

  attr_accessor :name, :players 
  def initialize (name) 
    @name = name 
    @players = [] 
  end 
  def add_players (*players) # splat 
    @players += players
  end 
  def to_s 
    "#{@name} team: #{@players.join(", ")}" 
  end 
  def each 
    @players.each { |player| yield player }
  end 
end 

# picks.rb file using team and player classes
require_relative 'player'
require_relative 'team'

player1 = Player.new("Bob", 13, 5); player2 = Player.new("Jim", 15, 4.5) 
player3 = Player.new("Mike", 21, 5) ; player4 = Player.new("Joe", 14, 5) 
player5 = Player.new("Scott", 16, 3)

red_team = Team.new("Red") 
red_team.add_players(player1, player2, player3, player4, player5) # (splat) 

# select only players between 14 and 20 and reject any player below 4.5 skill-level
elig_players = red_team.select {|player| (14..20) === player.age } 
                       .reject {|player| player.skill_level < 4.5} 
puts elig_players # => <Jim: 4.5(SL), 15(AGE)>
          # => <Joe: 5(SL), 14(AGE)>
```

Methods and classes begin new scope for variables. Outer scope variables do not get carried over to the inner scope. Use `local_variables` method to see which variables are in the current scope.

```ruby
v1 = "outside"

class MyClass 
  def my_method
  	# p v1 EXCEPTION THROWN - no such variable exists
    v1 = "inside"
    p v1
    p local_variables 
  end 
end 

p v1 # => outside
obj = MyClass.new 
obj.my_method # => inside 
              # => [:v1] 
p local_variables # => [:v1, :obj]
p self # => main
```

Constants begin with uppercase. Inner scope can see constants defined in outer scope and can also override outer constants. Value, however, remains unchanged outside.

```ruby
module Test 
  PI = 3.14 
  class Test2 
    def what_is_pi 
      puts PI 
    end 
  end 
end 
Test::Test2.new.what_is_pi # => 3.14 

module MyModule 
  MyConstant = 'Outer Constant' 
  class MyClass 
    puts MyConstant # => Outer Constant 
    MyConstant = 'Inner Constant' 
    puts MyConstant # => Inner Constant 
  end
  puts MyConstant # => Outer Constant 
end
```

Blocks inherit outer scope. Block is a closure.

```ruby
class BankAccount 
  attr_accessor :id, :amount 
  def initialize(id, amount) 
    @id = id 
    @amount = amount 
  end 
end 

acct1 = BankAccount.new(123, 200) 
acct2 = BankAccount.new(321, 100) 
acct3 = BankAccount.new(421, -100) 
accts = [acct1, acct2, acct3] 

total_sum = 0 
accts.each do |eachAcct| 
  total_sum += eachAcct.amount 
end 

puts total_sum # => 200
```

In block, a variable created inside the block is only available to the block. Parameters to the block are always local to block even if they have same name as variables in the outer scope. We can explicitly declare block-local variables after a semicolon in the block parameter list.

```ruby

arr = [5, 4, 1] 
cur_number = 10 
arr.each do |cur_number| 
  some_var = 10 # NOT available outside the block 
  print cur_number.to_s + " " # => 5 4 1 
end 
puts # print a blank line 
puts cur_number # => 10 

adjustment = 5 
arr.each do |cur_number;adjustment|  # treat adjustment as a local variable and not as outer variable
  adjustment = 10 
  print "#{cur_number + adjustment} " # => 15 14 11 
end 
puts 
puts adjustment # => 5 (Not affected by the block)
```

There are three levels of access control in class: public, protected, private
We can specify access control by using keywords and until another access control, all methods within those lines are having specified access control. By default, access control is public. Public methods can be access by any other class. Protected methods can be accessed from objects of this class or subclasses. Private access control doesn't allow any other class to access these methods with an explicit receiver.

```ruby
class MyAlgorithm
  private # all private methods
    def test1
      "Private"
    end
  protected
    def test2 # test2 is protected.
      "Protected"
    end
  public
    def public_again
      "Public"
    end
end

class Another
  def test1
    "Private, as declated later on"
  end
  private :test1 # another way to define methods as private
end
```

[Classes assignment](coursera-ruby-on-rails-intro/classes-assignment)

If we want to make web requests to web services, we can use HTTParty Rubygem.

`gem install httparty`

To use this gem, we first need to include that gem.

```ruby
require 'httparty'  
require 'pp'

class Coursera 
  include HTTParty
  base_uri = 'https://api.coursera.org/api/catalog.v1/courses'
  default_params fields: "smallIcon,shortDescription", q: "search"
  format :json

  def self.for term
    get("", query: {query: term })["elements"]
  end
end

pp Coursera.for "python" # pretty print
```

[HTTParty assginment](coursera-ruby-on-rails-intro/http-client-assignment)