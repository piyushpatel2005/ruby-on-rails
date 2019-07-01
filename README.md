# Ruby Language Lessons

1. [Ruby Quick Notes](lessons/ruby-notes.md)

2. [Ruby Basics](lessons/ruby-basics.md)

3. [Unit Testing](lessons/testing/README.md)

4. [Rails Intro](lessons/rails-intro/README.md)


## Deploying Applications to Heroku

We need to install Heroku toolbelt. It is a command line application tool that allows to manage Heroku applications. Heroku uses postgres and recommends `rails_12factor` gem. For specifying different DB, we can use group in Gemfile.

```ruby
gem 'sqlite3', group: :development
... ...

group :development, :test do 
... ...
end

group :production do 
  gem 'pg'
  gem 'rails_12factor'
end
```

After making these changes, Run `bundle`.

```shell
# From Ruby app directory type,
heroku login
heroku create <custom_subdomain>
git remote -v # it has added heroku remote as well
git push heroku master # pushes master branch to heroku master
heroku open # opens heroku application
```

Your app is deployed to `https://<custom_subdomain>.herokuapp.com`.

To view logs on failure, we can use `heroku logs` to view the latest logs.

Then, we try to run the program locally in local environment to replicate the error. We can use the interactive console when we get exception in local environment.

After fixing error.

```shell
git add .
git commit -m "commit message"
git push heroku master
```