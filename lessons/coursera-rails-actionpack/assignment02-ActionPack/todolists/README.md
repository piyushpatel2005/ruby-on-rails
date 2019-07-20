```shell
rails new todolists
cd todolists
bundle _1.17.3_ install
rspec -e rq01
rspec -e rq02
rails generate scaffold todo_item due_date:date title description:text completed:boolean
rake db:migrate
rspec -e rq02
rspec -e rq03
rspec -e rq04
rspec -e rq05
rspec -e rq06
# redirect to todo_items_url in create action
rspec -e rq06
# remove edit link from index.html.erb
rspec -e rq07
# edit _form.html.erb to add condition
rspec -e rq08
# edit model.rb, controller and index.html.erb
rspec -e rq09
rspec
```