# Steps to finish this assignment

```ruby
rails new todolists
rails -v # 4.2.8
bundle _1.17.3_ install
rails generate rspec:install
rails g model user username password_digest
rake db:migrate
rspec -e rq02
rails generate model profile gender birth_year:integer first_name last_name user:references
rake db:migrate
rspec -e rq03
# add `has_one :profile` in user model file
rspec -e rq03
rspec -e rq04
rails generate model todo_list list_name list_due_date:date
rake db:migrate
rspec -e rq04
rspec -e rq05
# add `belongs_to :user` in todo_list.rb and `has_many :todo_lists` in user.rb
rspec -e rq05
rails g migration add_user_to_todo_lists user:references
rake db:migrate
rspec -e rq05
rspec -e rq06
rails g model todo_item due_date:date title description:text completed:boolean todo_list:references
rake db:migrate
rspec -e rq06
# specify `has_many :todo_items` in todo_list.rb file
rspec -e rq06
# add `, dependent: :destroy` to remove todoitem when todolist is destroyed
rspec -e rq06
rspec -e rq07
rspec -e rq08
# add `has_many :todo_items, through: :todo_lists, source: :todo_items` line to user.rb file
rspec -e rq08
# populate seed.rb with data
rspec -e rq09
# add `default_scope` to todo_list.rb and todo_item.rb
# add `dependent: :destory` to user.rb for each children item
rspec -e rq10
# update profile.rb with custom validators
rspec -e rq11
# add cascading
rspec -e rq12
# add new method in user.rb
rspec -e rq13
# add new method in profile.rb
rspec -e  rq14
rspec
```