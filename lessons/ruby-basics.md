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