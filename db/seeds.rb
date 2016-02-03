# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
# admin for testing
example1 = User.new(
  name: 'Example Admin',
  email: 'exampleadmin@bloc.co.uk',
  password: 'Test1234',
  role: 'admin'
)

example1.save

# standard user for testing
example2 = User.new(
  name: 'Example Standard',
  email: 'examplestandard@bloc.co.uk',
  password: 'Test1234',
)

example2.save

# another user who will be upgraded and downgraded for testing
example3 = User.new(
  name: 'Example Second Standard',
  email: 'examplesecondstandard@bloc.co.uk',
  password: 'Test1234'
)

example3.save

users = User.all
puts "#{User.count} users created."

# Create wikis
20.times do
  wiki = Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
end

wikis = Wiki.all
puts "#{wikis.count} wikis created."
