# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'date'
User.destroy_all
Profile.destroy_all
TodoList.destroy_all
TodoItem.destroy_all

User.create! [
  {username: 'Fiorina', password_digest: 'tothetop'},
  {username: 'Trump', password_digest: 'alwayswinnng'},
  {username: 'Carson', password_digest: 'whipsers'},
  {username: 'Clinton', password_digest: 'personalemails'}
]

User.find_by(username: 'Fiorina').create_profile(
  gender: 'female', birth_year: 1954, first_name: 'Carly', last_name: 'Fiorina')
User.find_by(username: 'Trump').create_profile(
  gender: 'male', birth_year: 1946, first_name: 'Donald', last_name: 'Trump')
User.find_by(username: 'Carson').create_profile(
  gender: 'male', birth_year: 1951, first_name: 'Ben', last_name: 'Carson')
User.find_by(username: 'Clinton').create_profile(
  gender: 'female', birth_year: 1947, first_name: 'Hillary', last_name: 'Clinton')


due_date = Date.today + 1.year

User.find_by(username: 'Fiorina').todo_lists.create!(
  list_name: 'Vote for elections', list_due_date: due_date)
User.find_by(username: 'Trump').todo_lists.create!(
  list_name: 'Run the country', list_due_date: due_date)
User.find_by(username: 'Carson').todo_lists.create!(
  list_name: 'Workout everyday', list_due_date: due_date)
User.find_by(username: 'Clinton').todo_lists.create!(
  list_name: 'Delete E-mails', list_due_date: due_date)

TodoList.find_by(list_name: 'Vote for elections').todo_items.create! [
  { due_date: due_date, title: 'Find a suitable candidate',
    description: "Lets find a suitable candidate to win the lottery" },
  { due_date: due_date, title: 'Raise Money',
    description: "We need a lot a lot of money" },
  { due_date: due_date, title: 'Make country rich',
    description: "Think about ideas that can be used to make country richer." },
  { due_date: due_date, title: 'Wash clothes',
    description: "Need to do laundry" },
  { due_date: due_date, title: 'Get groceries',
    description: "Ask someone to get my groceries" }
]

TodoList.find_by(list_name: 'Run the country').todo_items.create! [
  { due_date: due_date, title: 'Think about jobs',
    description: "Develop new job opportunities for the youth" },
  { due_date: due_date, title: 'Improve education',
    description: "Improve the level of education in the country to compete other nations." },
  { due_date: due_date, title: 'Remove the Losers',
    description: "There's no room for losers here folks. None at all." },
  { due_date: due_date, title: 'Motivate large organizations',
    description: "Always encourage large companies to invest more in the country so that more jobs can be developed." },
  { due_date: due_date, title: 'be approchable',
    description: "Make good relationship with other nations" }
]

TodoList.find_by(list_name: 'Workout everyday').todo_items.create! [
  { due_date: due_date, title: 'Try not to be creepy',
    description: "But I'm studying brains, this may be hard" },
  { due_date: due_date, title: "Where's Waldo",
    description: "I seriously need to find this guy" },
  { due_date: due_date, title: 'Work on Debate Skills',
    description: "Debate with self in the mirror each morning" },
  { due_date: due_date, title: 'Mystery Meat',
    description: "Find out what brains are made from" },
  { due_date: due_date, title: 'Work on people skills',
    description: "People thing I'm a little creepy" }
]

TodoList.find_by(list_name: 'Delete E-mails').todo_items.create! [
  { due_date: due_date, title: 'Clear Inbox',
    description: "Delete all e-mails from inbox" },
  { due_date: due_date, title: 'Destroy Hard Drives',
    description: "Put hard drives in the microwave" },
  { due_date: due_date, title: 'Delete personal accounts',
    description: "Deactivate g-mail and yahoo accounts" },
  { due_date: due_date, title: 'Obtain Amnesia',
    description: "What e-mails????" },
  { due_date: due_date, title: 'Iron my pant suit',
    description: "Looking a little wrinkly these days" }
]