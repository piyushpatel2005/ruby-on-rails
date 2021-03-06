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

### Advanced Querying

If we want to seed the database with preliminary data.

```ruby
rails new advanced_ar
cd advanced_ar && bundle _1.17.3_ install
rails g model person first_name age:integer last_name
rake db:migrate
rake --describe db:seed
rake db:seed
```

Rails provides `db/seeds.rb` to populate the database with initial values.

Update this files and then run `rake db:seed`. The `create!` method informs us if something went wrong during seeding. Check the status of the database table.

```ruby
rails db
.headers on
.mode columns
select * from people
```

Sometimes, if we want to run unusual query, we can pass SQL fragments.
However, we have to be careful with SQL injection in this case.

```ruby
Person.where("age BETWEEN 30? and 33").to_a
Person.find_by("first_name LIKE '%man'")
rails g migration add_login_pass_to_people login pass
rake db:migrate
rake db:seed
```

There are two alternatives to directly specifying SQL literals to avoid SQL injections. (1) Array condition syntax, (2) Hash condition syntax. It automatically performs conversions on the input values and escapes strings in the SQL. This is immune to SQL injection.

```ruby
rails c
Person.where("age BETWEEN ? AND ?", 28, 34).to_a
Person.where("first_name LIKE ? OR last_name LIKE ?", '%J%', '%J%').to_a
# Arraysyntax has to keep track of the order or parameters in the end.
# Even if same variable is used, we have to specify the same multiple times like '%J%'

Person.where("age BETWEEN :min_age AND :max_age", min_age: 28, max_age: 32).to_a
Person.where("first_name LIKE :pattern OR last_name LIKE :pattern", pattern: '%J%')
```

### Making associations

We need to make relationship with different tables.
- One Person can have one Personal Info (One to One). One personal_info entry *belongs to* exactly one person. so, the "belongs to" side is the one with foreign key. The convention in Rails is to have foreign key as `[singular table name]_id` like person_id. This creates `has_one` attribute in persons table and `belongs_to` in personal_infos table.
One Person can do many jobs (one to many). One job entry *belongs to* exactly one person. The "belongs to" side is with a foreign key.
One person can have more than one hobby and the same hobby can be taken up by many people. (Many to Many)

**One to one association**

```ruby
rails g model personal_info height:float weight:float person:references # creates personal_infos table with person_id foreign key
rake db:migrate
.schema personal_infos
.exit
rails console
bill = Person.find_by first_name: "Bill"
bill.personal_info # if you get an error, ensure that has_one attribute is added to `person.rb` model
reload!
bill.personal_info
pi1 = PersonalInfo.create height:6.5, weight:270
bill.personal_info = pi1
```

In addition to directly assigning, `person` instance has two methods: `build_personal_info(hash)` and `create_personal_info(hash)`. `create_personal_info` creates record in the DB right away whereas `build` does not, it creates in memory. Both remove previous reference in the DB.

```ruby
bill = Person.find_by first_name: "Bill"
bill.personal_info
bill.build_personal_info height: 6.0, weight: 180
bill.save
josh = Person.find_by first_name: "Josh"
josh.create_personal_info height: 5.5, weight: 135 # creates record right away
```

**One to many associations**

```ruby
rails g model job title company position_id person:references
rake db:migrate
# this creates belongs_to attribute in job model
# we need to add `has_many` attribute in people table
rails c
ActiveRecord::Base.logger = nil
Job.create company: "MS", title: "Developer", position_id: "#1234"
p1 = Person.first
p1.jobs
p1.jobs << Job.first # append job to first person
Job.first.person # get the person associated with this job
```

If we have array of jobs as `jobs` object. We can replace person's jobs using `person.jobs = jobs` whereas `person.jobs << jobs` will append jobs. `person.jobs.clear` will disassociate jobs from this person by setting foreign key to NULL. The records will still remain in respective tables. We can have jobs assigned to any person. Check out [seeds file](coursera-rails-actionpack/advanced_ar/db/seeds.rb) and see how jobs are created for first and last person. This way jobs `create` and `where` function can be scoped to a person.

```ruby
rake db:seed
rails c
ActiveRecord::Base.logger = nil
Person.first.jobs.where(company: "MS").count
Person.last.jobs.where(company: "MS").to_a
```

We can also have custom query naming. For example, if we want our queries to have `Person.my_jobs` function, we can add an attribute in person model, `has_many :my_jobs, class_name: "Job"`. This will allow us to query just like we can do with `job` method.

```ruby
rails c
Person.first.jobs
Person.first.my_jobs # same query and result as above
```

`has_many`, `has_one` and `belongs_to` support `:dependent` option which lets you specify the fate of association when the parent gets destroyed. 
`:delete` - remove associated objects
`:destroy` - same as above, but remove the association by calling `destroy` on it.
`:nullify` - set the FK to NULL and leave associated entity alone, only disassociate.

For example, if we want personal_info to be removed, we can add `has_one :personal_info, dependent: :destroy`  to person model.

```ruby
mike = Person.find_by first_name: "Michael"
mike.personal_info
mike.destroy
PersonInfo.find 6 # could not find it
```

**Many to many associations**

ActiveRecord has `has_and_belongs_to_many` (habtm) for many to many associations. In this association, we need third join table that has primary key for creating association. The convention is to have plural model names separated by underscore and ordered alphabetically. This does not require a model. Many to many contains 2 models and 3 migrations.

```ruby
rails g model hobby name # This expects intermediate table hobbies_people and not people_hobbies.
rails g migration create_hobbies_people person:references hobby:references
rails db
.schema %hobbies%
# add `has_and_belongs_to_many` attribute in both classes.
rails c
josh = Person.find_by first_name: "Josh"
lebron = Person.find_by first_name: "LeBron"
programming = Hobby.create name: "Programming"
josh.hobbies << programming
lebron.hobbies << programming
programming.people
```

Sometimes, we need to keep some data on the join table. Sometimes, we also need to store grandchild relationships on a model, like user -> articles -> comments and we want to find comments for a particular user. In this example, let's say we have salary table and we want to find all salary ranges for a particular person.

For such scenarios, ActiveRecord provides a `:through` option for this. So, we have salary range for a job. and a job is associated with a person. Take a look at the syntax [person.rb](coursera-rails-actionpack/advanced_ar/app/models/person.rb). This makes finding approximate salary for a person to go through jobs model.

If we want to find max_salary for person model, we can add a method in the model.

```ruby
rails g model salary_range min_salary:float max_salary:float job:references
rake db:migrate
rails c
lebron = Person.find_by first_name: "LeBron"
lebron.jobs.count
lebron.jobs.pluck(:id) # returns 8,9 id numbers
Job.find(8).create_salary_range(min_salary: 10000.00, max_salary: 20000.00)
Job.find(8).create_salary_range(min_salary: 15000.00, max_salary: 35000.00)
lebron.approx_salaries # returns both salary ranges
lebron.max_salary
```

### Scopes in ActiveRecord

- **default_scope:** Class method for specifying how the records are retrieved by default form the database (instead of relying on the database default). We can specify `default_scope { order :name }` and it will order results for specific model by name. If we want results not by scope, then we can run query like `Hobby.unscoped.pluck :name` which will give results based on database defaults. Chec[hobby.rb](coursera-rails-actionpack/advanced_ar/app/models/hobby.rb). 
- **named scope:** requires name of scope and lambda for that scope. It acts as class methods. Look at [person.rb](coursera-rails-actionpack/advanced_ar/app/models/person.rb) for example.



```ruby
rails c
Hobby.pluck :name
Hobby.unscoped.pluck :name
Person.ordered_by_age.pluck :age
# chaining scopes
Person.ordered_by_age.starts_with("Jo").pluck :age, :first_name
Person.ordered_by_age>limit(2).starts_with("Jo").pluck :age, :first_name
```

### Validations

ActiveRecord provides many built-in validators. For example, 
- `presence: true` to make sure the field contains some data. 
- `uniqueness: true` checks to ensure that the column value is unique. Add `validates :title, :company, presence: true` line in job model.
- `:numericality` validates numeric input
- `:length` validates value of certain length
- `:format` validates value complies with some regular expression
- `:inclusion` validates value is inside specified range.
- `:excelusion` validates value is out of the specified range.

We can also write our own validators. We need to write a method that does some validation and calls `errors.add(columnname, error)` when an error occurs. Specify it as a symbol for `validate` method. Check [salary_range.rb](coursera-rails-actionpack/advanced_ar/app/models/salary_range.rb).

```ruby
rails c
job = Job.new
job.errors # no error yet
job.save # now saving process, so it first validates
job.errors # now contains error
job.errors.full_messages

sr = SalaryRange.create min_salary: 30000.00, max_salary: 10000.00
sr.errors
sr.errors.full_messages
sr.save! # throws exeption with bang
```

```ruby
rails c
Person.first.personal_info.weight
Person.all.each {|p| puts p.personal_info.weight } # runs individual queries for each person's weight, which is inefficient query. 
# It queries too many times to the database.
Person.includes(:personal_info).all.each{ |p| puts p.personal_info.weight }

# Creating transactions with different models
Account.transaction do
  balance.save!
  account.save!
end
```

## Action Pack

Action Pack is a ruby gem and allows to expose data to the world using REST API. ActionPack is combination of ActionController and ActionView.


```ruby
rails new my_blog
cd my_blog
bundle _1.17.3_ install
rails g scaffold post title content:text
rake db:migrate
```

Ruby code can be embedded in erb files using `<% ... %>` or evaluated using `<%= ... %>`.
Action controller is a ruby class containing one or more actions. Each action is responsible for responding to a request to perform some task. Unless stated, when action is finished, it renders a view with the same name as the action. The action always needs to be mapped in `config/routes.rb` file.

| HTTP Method | Named Routes | Parameters | Controller Action | Purpose |
|:------------|:-------------|:-----------|:------------------|:----------|
| GET | posts_path | | index | List all |
| GET | post_path | ID | show | Show one |
| GET | new_post_path |  | new | Provide form to input new post |
| POST | posts_path | Record hash | create | Create new record |
| GET | edit_post_path | ID | edit | Provide form to edit post |
| PUT/PATCH | post_path | ID and record hash | update | Update record |
| DELETE | post_path | ID | destroy | Remove record |

```shell
rake routes # list all available routes
```

Application routing maps to `app/controllers/posts_controller.rb` file where it specifies what to do when a request is made to specific end point. By default, it will send the view with the same name, for example, `/posts` will execute `index` method from respective controller and dispaly `index.html.erb` from views.

Before executing `show`, `edit`, `update` or `destroy` method, we need to set the post. That is what is specified using `before_action :set_post, only: [:show, :edit, :update, :destroy]` at the beginning of the class. 

Rails has helper `respond_to` that specifies how to respond to a request based on request format. It takes an optional block where the argument is the format (html, json, xml, etc). There is `redirect_to` helper which asks browser to redirect to another URL (takes full URL).

`new` method is used to create new empty post which will be displayed in form. When the form is filled up, it is added to database using `create` method. Once the object has been saved, we redirect to `show` template. If unsuccessful, render the `new` action template again. Strong parameters make sure we are updating only the expect number of fields.

```ruby
def post_params
  params.require(:post).permit(:title, :content)
end
```

We can use flash to send messages to client after the posts has been created, updated or deleted. This is available for only one request after the first successful or unsuccessful request. It is done using `flash[:attribute] = value`. For example, `:notice` and `:alert` are used for such messages.

Similar to `new` and `create` methods, `edit` and `update` methods work together. One shows the form to update the fields and another respond to post method and update the actual record.

`application.html.erb` layouts code for entire application. Partials are similar to regular templates but have a more refined set of capabilities. They are named with underscore as leading character. When rendered, they are rendered wiwht `render 'partialname'` (no underscore). `render` method also accepts a second argument as hash of local variables. We can also pass a specific object to it. For example, `<%= render @post %>` will render a partial from `app/views/posts/_post.html.erb` and automatically assign a local variable `post`. We can render a collection of partials using `<%= render @posts %>` which is same as iterating on post objects and rendering that post partial.

In form partial, `form_for` helper, works for new post or update of the post. `form_for` generates form tag for passed in object. Unlike regular HTML form, Rails uses POST by default. There is `f.label` which generates label tag. We can also pass second string parameter to customize it. `f.text_field` generates input type="text" field. It uses `:placeholder` hash entry to specify a placeholder to be displayed inside the field until the user proves a value. Similarly, there is `f.text_area` which has size. `f.date_select` will generate year, month and day selection. There is `f.time_select`, `f.datetime_select`. There is `distance_of_time_in_words_to_now` to display duration. Other helpers include `search_field`, `telephone_field`, `url_field`, `email_field`, `number_field`, `range_field` for new type of form fields. `f.submit` will create submit button. It will automatically create "Create Post".

```ruby
<%= f.label :title, "Heading" %>
<%= f.text_field :title, placeholder: "Fill up your description" %>
<%= f.text_area :content, size: "10x3" %>
<%= f.date_select %>
```

We can have `posts.html.erb` which will be layout for all posts templates. Inside controller also, we can have `layout` method to set a layout for the entire controller like `layout 'some_layout'`. We can also specify layout for a specific action with an explicit call to `render layout: 'my_layout'` inside the action. If we don't want a layout, we can say `render layout: false`.


## Security

```shell
rails new i_reviewed
cd i_reviewed
bundle _1.17.3_ install
```

There will be three tables reivewers, books and notes table. A book can be reviewed by many reviewers.

```shell
rails g model reviewer name password_digest -q # -q means quiet operation
rails g model book name author reviewer:references -q
rails g model note title note:text book:references -q
rake db:migrate
rake db:seed
rails db
.headers on
.mode columns
select * from books;
.exit
rails g scaffold_controller book name author # create only controllers and views for models
```

Note resource depends on a book. Notes are on a book. Rails calls such resources as "nested resources"

```shell
rails g controller notes
```

In Routes, we can specify notes as nested resources using

```ruby
resources :books do
  resources :notes
end
```

`rake  routes` shows which routes are created with this changes. If we want only specific actions, we can specify that in  `routes.rb` file. Specify `resources :notes, only: [:create, :destroy]`.

Rails has  `content_tag` which is helper to generate HTML content.


```shell
rails c
helper.content_tag :p, "Hello World"
helper.content_tag(:div, helper.content_tag(:p, "Cool"), class: "world")
```

### Authentication and Authorization


For authentication, we can store `has_secure_password`. We need to enable `bcrypt-ruby` and run `bundle install`. We need to have a column `password_digest`. In Reviewer model, we add `has_secure_password` which says that this model has virtual column in database which is password_digest by convention. The password will be stored in hashed format which is one way process and difficult to decrypt the data.

```shell
rails c
Reviewer.column_names
Reviewer.create! name: "Joe", password: "abc123"
joe = Reviewer.find_by name: "Joe"
joe.authenticate("somepassword") # false
joe.authenticate("abc123") # joe object returned
```

`has_secure_password` enables `authenticate` method.

```shell
rails c
Reviewer.first.books.count
Reviewer.last.books.count
Reviewer.first.books.pluck :name
Reviewer.last.books.pluck :name
```

Cookies and sessions enable us to maintain state between client and server. Session is created and made available through `session` hash. The server sends the browser a cookie with the session information, which the browser stores and sends back to the server on all subsequent requests (until session ends).

```shell
rails g controller sessions new create destroy -q
```

Add routes to `routes.rb` file. We can think of `new` action as login page and `destroy` as a logout page for session. We need new and create actions for creating and destroy action to destroy session. We add custom routing which will be for `/login` and `/logout` routes. We refer to this routes as `logout_path` and `login_path` by passing `as: "login"` in `routes.rb` file.

If we want to lock down any action, we can have a `before_action` in the ApplicationController (from which all controllers inherit) that will make you login if you are not logged in yet. Now that everything is blocked, controllers can override `before_action` with `skip_before_action` method.

So, look at [application_controller.rb](coursera-rails-actionpack/i_reviewed/app/controllers/application_controller.rb) for this example. In [sessions_controller.rb](coursera-rails-actionpack/i_reviewed/app/controllers/sessions_controller.rb), we have `skip_before_action :ensure_login, only [:new, :create]` which enables to login even if everything is blocked.

If we want to define our own helper methods, for example, we want `logged_in?` and `current_user` helper methods and make them available to all controllers and views via `helper_method` in `application_controller.rb`. We can add logic to `application.html.erb` for logging out and information about who is logged in.

To limit the visiblity of books, we can use `current_user` in `books_controller.rb` file.

For **pagination**, we need to include `will_paginate` gem. Run `bundle`. Include one line code in controller and view.

In `books_contoller.rb` file, we added `@books = current_user.books.paginate(page: params[:page], per_page: 10)` line in `index` method. In `books/index.html.erb` this line is added `<%= will_paginate @books %>` which will display pages with links.

```shell
rails c
Reviewer.first.books.paginate(page: 3, per_page: 10)
```

To **deploy to Heroku**, we have to include postgres in production gem.

```ruby
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
```

Then, we run `bundle --without production`. Make our git repository ready for deploying.

```shell
heroku login
heroku create ireview_books # this adds remote to heroku where we can push
git push heroku master # this runs tests and deploys app
# we have to run migrations for database
heroku run rake db:migrate
heroku run rake db:seed # seed the data
heroku logs
```

To enable SSL, in `config/environments/production.rb` file enable ssl using `config.force_ssl=true`. Again commit and push to heroku remote.