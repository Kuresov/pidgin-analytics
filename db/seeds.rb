# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

require 'faker'

# Create Users
3.times do
  user = User.new(
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(8)
  )
  user.save!
end

admin = User.new(
  email:    "alex@pidgin.com",
  password: "password"
)
admin.save!

users = User.all

12.times do
  application = RegisteredApplication.new(
    user: users.sample,
    name: Faker::Lorem.words(2).join(' '),
    url:  Faker::Internet.url
  )
  application.save!
end

applications = RegisteredApplication.all

possible_events = ["Visit", "Error", "SomethingElse"]
50.times do
  event = Event.create(
    registered_application: applications.sample,
    name:                   possible_events.sample
  )
end


puts "#{users.count} users created"
puts "#{applications.count} applications created"
puts "#{Event.all.count} events created"
