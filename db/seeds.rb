# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
# admin for testing
alice1 = User.new(
  name: 'Alice Admin',
  email: 'alicesuckling@live.co.uk',
  password: 'Test1234',
  role: 'admin'
)
alice1.skip_confirmation!
alice1.save

# standard user for testing
alice2 = User.new(
  name: 'Alice Standard',
  email: 'alicesuckling@live.co.uk',
  password: 'Test1234',
)
alice2.skip_confirmation!
alice2.save

# another user who will be upgraded and downgraded for testing
alice3 = USer.new(
  name: 'Alice Second Standard',
  email: 'alicesuckling@live.co.uk',
  password: 'Test1234'
)
alice3.skip_confirmation!
alice3.save

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
