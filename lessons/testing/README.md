# Ruby Unit Testing

Unit Tests are important for Ruby. Ruby ships with `Test::Unit` framework. The idea is to write a class that extends `Test::Unit::TestCase`. We prefix method names with `test_`. If one of the methofs fails, other tests keep going. We can use `setup()` and `teardown()` method for setting up and cleaning test class.

[Calculator test class](calculator_test.rb)

## Rspec

RSpec allows for writing intuitive test codes.

To install rspec,

```shell
gem install rspec
# to write rspec test codes
rspec --init # It creates spec directory as well as .rspec file
```

Top level method in RSpec is `describe` which are group of tests. This method takes a string or a class. All specs must be inside describe block. In RSpec, there is no TestCase class to inherit from. There are `before()` and `after()` methods to setup and teardown. In Rspec, we can specify `:all` or `:each` to specify whether this before block runs before all tests or before each test. The main tests happen inside `it()` method. It takes string which describes behavior being tested.
To run tests, type `rspec`.

RSpec has many **matchers**. It relies on `to` and `not_to` methods on all outcome of expectations. Both these methods take one parameter (a matcher) like 
- be_true/be_false
- eq 3
- raise_error(SomeError)

If the object on which the test is operating has a predicate method - we automatically get a `be_predicate` matcher.

```ruby
it "should sum two odd numbers and become even" do 
  expect(@calculatr.add(3,3)).to be_even
  expect(@calculatr.add(3,3)).not_to be_even
end
```

It displays `..` for passing tests. To prepare documentation of tests or to see which tests are passing actually.

```shell
rspec --format documentation
```


**Capybara** helps us write Acceptance tests. PhantomJS is a headless browser. So, when running Capybara tests, we don't need to see browser opening and running tests. `poltergeist` comes with PhantomJS.

```shell
gem install rspec
gem install selenium-webdriver
gem install capybara
gem install poltergeist
```

```ruby
Capybara.default_driver = :selenium
# Capybara.default_driver = :poltergeist

Capybara.app_host = "http://search-coursera-jhu.herokuapp.com/"

describe "Coursera App" do

  describe "visit root" do
  	before { visit '/' }
    
    it "displays 'Johns Hopkins' (default)" do
      expect(page).to have_content 'Johns Hopkins'
    end

    it "displays table element that has a row with 3 columns" do
      expect(page).to have_selector(:xpath, "//table//tr[count(td)=3]")
    end

    it "column 1 should have the thumbnail inside img tag" do
      expect(page).to have_selector(:xpath, "//table//tr/td[1]//img")
    end
  end

  it "displays 'The Meat We Eat' when looking_for=diet" do
    visit "?looking_for=diet"
    expect(page).to have_content 'The Meat We Eat'  	
  end

end
```