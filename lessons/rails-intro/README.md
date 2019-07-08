# Rails Introduction

Rails is a framework for creating dynamic web applications. It was created by David Heinemeier Hansson. It relies on convention over configuration. If we rely on rails conventions, it can result in less code and we can create application very quickly. Rails also comes with ORM which allows developers not to write any SQL query at all. 
Rails comes with SQLite database by default. It uses MVC pattern which allows for separation of concerns.
Rails also provides built-in web server.

To create application,

```shell
rails new my_first_app
rails new -h # see help for rails command line tool
cd my_first_app
bundle install # resolve dependencies and install
git init
git add .
git commit -m "Initial commit"
rails server # or rails s
```

The directory structure of rails looks as below.

- `app/` includes controllers, views, models and helpers
- `config/` includes configuration files like Database settings
- `db/` contains files related to your DB and migration scripts. It also includes SQLite database files.
- `public/` has all static files including HTML, CSS, Javascript
- `Gemfile` and `Gemfile.lock` contains dependencies and these files are used by bundler.


When request is made, server first looks into `public` directory before looking anywhere else. 

**Controllers** contain actions and orchestrate web requests. We can generate controller using:

```shell
rails generate controller controller_name [action1] [action2]
rails g controller controller_name
rails g controller greeter hello # generate greeter controller with hello action
```

The view files are HTML files, but includes `.erb` extension. This is embedded ruby. It includes two tags

`<% ... ruby code ... %>` which is used to evaluate Ruby code inside HTML.
`<%= ruby code %>` outputs evaluated Ruby code.

When we define a method witout any implementation inside controller. It looks for the view named `<method_name>.html.erb` and returns that view when that method is called.

Before controller can orchestrate where the web request goes - the web request needs to get routed to proper method. All the routes need to be specified in the `config/routes.rb` file. To add a new route

```ruby
get 'greeter/hello' => "greeter#hello" # send request to GreeterController#hello method.
get 'greeter/goodbye'
```

**Rake** is Ruby's build language. It is written in Ruby. Rails uses Rake to automate certain tasks. To see a list of rake tasks type `rake --tasks`. We can use `rake --describer task_name` to describe what this task does.

If action method is not doing anything, we can remove it. As long as there is a proper route defined and there is a properly named view file/template, the action method does not have to be there and Rails will find the correct template by convention. Instance variables from controller action are available in the view. Every new request will create a new instance of controller. For storing such variables, we can use session or a database.

Ruby also defines several **helpers**. Every time we generate a controller, a helper is also generated. The methods inside helper are available to any view in the application. Rails has `link_to` helper which generates a hyperlink.

`link_to name, path`

Here `path` can be routes defined in `routes.rb` ending with `_url` (full path) or `_path` (relative path) or it can be external path. Full path is required in cases of redirection.

```ruby
<%= link_to "Google", "http://www.google.com" %>
<%= link_to "Goodbye", greeter_goodbye_path %> # This points to GreeterController#goodbye action
```

## HTTParty

Ruby gems are packages for Ruby. Gem is a package manager for Ruby. To check if a gem is installed, we can type `gem list httparty`. To install, we can type `gem install httparty`.
We can also type `gem list httparty -d` to see more details about this gem. HTTParty is a restful web services client. HTTParty provides automatic parsing of JSON and XML into Ruby hashes. It also provides support for basic authentication and request query parameters. To use this, `include HTTParty`. We can specify `base_uri` for requests and `default_params` (API developer key for example), `format` to specify which format the data is in. 

**Bundler** provides consistent environment by tracking and installing exact version of gems. It uses `Gemfile`. Bundler can resolve dependencies in Rails. To use it `bundle install` or `bundle` to install gems. To modify, we can do `bundle update`. We can also specify environments in which only specific gems should be installed.

```ruby
group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end
```

If we don't specify version of gem, it installs latest version.

```ruby
gem "nokogiri" # install latest
gem "rails", "3.0.0" # exact version
gem "rack", ">=1.0"
gem "thin", ">=1.1", "<2.0" # greater than 1.1 and less than 2.0
gem "thin", "~>1.1" # only use minor version but not major version
```

Sometimes, the gem name and the require statement would be different.
Bundler creates a `Gemfile.lock` file, which contains actual gem versions your app is using with their associated dependencies. `bundle exec` is used sometimes to use specific version of gem in Gemfile.

To integrate Httparty in Rails, we install httparty. We need to restart the server when we update Gemfile. The gem files are loaded at start of the server. By convention, controller names are plural and model names are singular.

We can specify root path in routes using `root "courses#index"`. We uses `params` helper to parse request parameters.

**Scaffolding** is a ability to generate code (views, controllers and processes). Rails by default uses SQLite for database.**Migrations** are regular ruby code that allows to modify databases. They also allows to rollback to previous state.

Scaffolding is  code generator for entities. It gets you up and running quickly.

```shell
rails new fancy_cars
gem bundle _1.17.3_ install # install bundler older than 2.0
bundle _1.17.3_ install # bundle install with specific bundler version
# Create resource Car and column names and types (default type is string)
rails g scaffold car make color year:integer
rake db:migrate # create migration file
rails s # now it has various routes for /cars endpoints.
```

Scaffolding can create migration, controller, views, routes, models, etc.

For setting up database, we have `config/database.yml` file for configuring database.

We can use `rails db` and it opens up SQLite console. From there we can type different commands using `.help`. There is also DB Browser for SQLite which is GUI for SQLite database.

```shell
.help
.tables
.headers on
.mode columns
.schema cars
select * from cars;
.exit
```

All tables have `created_at` and `updated_at` columns.

Migrations allows for easy migration from one database to another or to make changes to databas schemas. Migrations are Ruby classes that extend `ActiveRecord::Migration`. File name needs to strat with a timestamp and followed by some name of the class. This timestamp defines the sequence of how the migrations are applied and acts as a database version of sorts or snapshot in time. Scaffolding generate migration file, but if the database is setup and we don't need to generate migration file, we can use `--no-migrtion` flag. Once migration is created, it needs to be applied to a database in order to migrate the database to its new state. No two migrations can have the same class name. Migration code maintains a table called `schema_migrations` table with one column called *version*. So, if we run `rake db:migrate` multiple times, nothing will happen.

Inside migration file, `ActiveRecord::Migration` subclass, we can have `up` or `down` method, which are used to do and undo changes to the schema. Usually there will be one method `change` and Rails knows how to undo changes. We can rollback using `rake db:rollback`. Migration also gives us database independence. Ruby database adapter translates ruby code to specific database dialect. The data types we can specify include binary, boolean, date, datetime, decimal, float, integer, string ,text, time. We can also specify constraints like `null`, `unique`, `limit`, `default`, `precision`, `scale` etc.

Table names in Rails are always named plural. An id column is automatically created to be used as primary key. `timestamp` method creates `created_at` and `updated_at` columns. `create_table` and `drop_table` is how the table is created and dropped. For adding columne, `add_column`, to remove column `remove_column` with table name and column name.

Let's add price column to cars model. `add_column` takes table name, column name and extra has for attributes.

```ruby
rails g migration add_price_to_cars 'price:decimal{10,2}'
rake db:migrate
rails g migration rename_make_to_company # rename a column
rake db:migrate
```

There is also `config/schema.rb` file wihch is the latest version of the schema. If we have hundreds of migrations, we can run `rake db:schema:load` which will load this final version of schema instead of going through all migration files one at a time. When we rename a column, it is not easy. We have to add code to migration file and also make changes to view. So, Rails provides one way migrations which cannot be rolled back.

## Meta Programming

In static languges, compiler requires you to define all methods upfront. In dynamic languages, such as Python or Ruby methods don't have to be predefined - they need to be found when invoked. 

We can call methods of an object using dot notation. There is another way to call a method in Ruby - using `send` method. The first parameter is the `method name/symbol` and the rest are `method arguments`.

```ruby
class Dog
  def bark
    puts "Woof. Woof!"
  end
  def greet (greeting)
    puts greeting
  end
end

dog = Dog.new
dog.bark # Woof. Woof!
dog.send("bark") # Woof.Woof!
dog.send(:bark) # same as above
method_name = :bark
dog.send method_name # same
dog.send(:greet, "hello") # hello
```

This is called Dynamic dispatching. We can decide at runtime which methods to call. The code doesn't need to find which method it should call.

```ruby
props  = {name: "John", age: 15 }
class Person
  attr_accessor :name, :age
end

person = Person.new
props.each { |key, value | person.send("#{key}=", value)} # sets the values based on props hash
```

With Dynamic methods, we can also define method dynamically. To define methods dynamically, we have `define_method :method_name` and a block which contains the method definition. This creates instance method for a class

```ruby
class Whatever
  define_method :make_it_up do
    puts "Whatever ..."
  end
end

whatever = Whatever.new
whatever.make_it_up # Whatever...
```

We can define methods from another class into new class using this feature.

```ruby
require_relative 'store'
class ReportingSystem

  def initialize
    @store = Store.new
    @store.methods.grep(/^get_(.*)_desc/) { ReportingSystem.define_report_methods_for $1 }
  end
  
  def self.define_report_methods_for (item)
    define_method("get_#{item}_desc") { @store.send("get_#{item}_desc") } # these methods are defined inside Store class.
    define_method("get_#{item}_price") { @store.send("get_#{item}_price")}
  end
end

rs = ReportingSystem.new
puts "#{rs.get_piano_desc} costs #{rs.get_piano_price.to_s.ljust(6,'0')}"
```

This way if someone adds new item to Store class, ReportingSystem already knows about it as long as same method naming pattern is used. This can dramatically reduce the amount of code that needs to be written.

When a method is invoked, Ruby looks for the method in the class to which it belongs. Then it goes up the ancestors tree (classes and modules). If it still doesn't find the method, it calls `method_missing` method which will throw NoMethodFoundError. As this is just a method, we can override it.

```ruby
class Mystery
  def method_missing (method, *args) 
    puts "Looking for ..."
    puts "\"#{metohhd}\" with params (#{args.join(',')}) ?"
    puts "Sorry... not found ..."
    yield "Ended up in method_missing" if block_given?
  end
end

m = Mystery.new
m.solve_mystery("abc", 123123) do |answer|
  puts "And the answer is : #{answer}"
end
```

`method_missing` gives the power to fake the methods and that's why they are called **ghost methods**. We can use `Struct` and `OpenStruct` to create classes.

```ruby
# define Customer class
Customer = Struct.new(:name, :address) do
  def to_s
    "#{name} lives at #{address}"
  end
end

jim = Customer.new ("Jim", "1000 Wall Street")
```

Now with `method_missing`, we can delegate all missing methods to superclass.

```ruby
require_relative 'store'

class ReportingSystem
  def initialize
    @store = Store.new
  end
  def method_missing(name, *args)
  # if method doesn't exist even in Store object, then handle it in Object class
    super unless @store.respond_to?(name)
    @store.send(name)
  end
end
```

## ActiveRecord

ORM bridges between RDBMS and objects. It simplifies writing code for accessing database. Active Record is a design pattern in which we have model and we store attributes in that model. The logic of how this should be stored in database is also included in model. ActiveRecord is Rails default ORM. The active record classes are stored in `app/models/` directory.

```ruby
class Car < ActiveRecord::Base
end
```

It uses conventions as follows.

- ActiveRecord has to know how to find database (when Rails is loaded, this infor is read from `config/database.yml` file.)
- By convention, the table name is plural name that corresponds to `ActiveRecord::Base` subclass with a singular name. (Car class correspond to cars table)
- By convention, ActiveRecord expects the table to have a primary key named `id`.

Open Rails console using `rails c` or `rails console`.

```ruby
Car.column_names # get column names
Car.primary_key # get primary key
exit
```

We can generate model using `rails g model person first_name last_name`. When we generate a model, it knows that person model should have people table. It knows this through a file `config/initializers/inflections.rb`. It knows only those model names. If we are already in the rails console and we generated a new model. Rails console does not know about the new migration, but we can reload new models using `reload!` and then we can run `Person.column_names`.

```shell
rails g model person first_name last_name
rake db:migrate
```

### ActiveRecord CRUD

To **create** new record, we can call empty constructor and attributes to set the values and then call `save`. We can also pass a hash of attributes into the constructor and then call `save`. There is third option to use create method with a hash to `create` an object and save it to the database in one step.

To **retrieve/read**, we can use `find(id)` or `find(id1, id2)`. If id is not found, it throws a `RecordNotFound` exception. We can use `first`, `last`, `take`, `all` to find records. They return `nil` if record is not found. We can also order by some column name using `order(:column)` or `order(column: :desc)` to order in descending or ascending order.
There is `pluck` method to narrows down which fields are coming back.
With `where(hash)`, we can supply conditions for search. This also returns `ActiveRecord::Relation` object. We can use `find_by(condition_hash)` which returns single result or `nil`.  `find_by!` will throw exception if result is not found. The `limif(n)` limits how many records are retrieved. `offset(n)` will skip to given number and bring the results. We can combine these to page through large collection of records.

To **update** record in database, we can retrieve a record, modify and then `save`. We can also do it by retrieving a record, then call `update` method passing in a hash of attributes with new values. There is also `update_all` to update many records. For this method, we retrieve multiple records using `where` instead of `find_by`.

To **delete** a record, we can use `destroy(id)` or retrieve a record and call `destroy` on that object. It removes a particular instance from the DB. It also instantiates an object first and performs callbacks before removing. Another way to delete a record is to use `delete(id)`. It removes the row from DB. There is also `delete_all` which is dangerous.

```ruby
p1 = Person.new;
p1.first_name = "Joe"; p1.last_name = "Smith"
p1.save

p2 = Person.new(first_name: "John", last_name: "Doe"); p2.save

p3 = Person.create(first_name: "Jane", last_name: "Doe")

Person.all.order(first_name: :desc) # gives ActiveRecord::Relation object which can be converted to array using to_a
Person.all.order(first_name: :desc).to_a
Person.first
Person.all.first
Person.all[0]
Person.take # gives any random record
Person.take 2
Person.all.map { |person| person.first_name }
Person.pluck(:first_name) # same as above, but more performant
Person.where(last_name: "Doe")
Person.where(last_name: "Doe").first
Person.where(last_name: "Doe").pluck(:first_name) # pluck returns array
Person.find_By(last_name: "Doe") # will give one record only
Person.find_by(last_name: "Nosuchdude") # returns nil
Person.find_by!(last_name: "Unknown") # gives Exception ActiveRecord::RecordNotFound
Person.count
Person.offset(2).limit(1).map{ |person| "#{person.first_name} #{person.last_name}" }
Person.offset(1).limit(1).all.map { |person| "#{person.first_name} #{person.last_name}" }

jane = Person.find_by first_name: "Jane"
jane.last_name = "Smithie"
jane.save
Person.find_by(last_name: "Smith").update(last_name: "Smithson")

Person.count # 3
jane = Person.find_by first_name: "Jane"
jane.destroy
joe = Person.find_By first_name: "Joe"
Person.delete(joe.id)
Person.count # 1
```