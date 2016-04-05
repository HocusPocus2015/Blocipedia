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

# premium to test private wikis and collaborators
example4 = User.new(
  name: 'Example Premium',
  email: 'examplepremium@bloc.co.uk',
  password: 'Test1234',
  role: 'premium'
)

example4.save

example5 = User.new(
  name: 'Example Second Premium',
  email: 'examplesecondpremium@bloc.co.uk',
  password: 'Test1234',
  role: 'premium'
)

example5.save

users = User.all
premium_users = User.where(role: ["premium", "admin"])
puts "#{User.count} users created."

# Create wikis
20.times do
  wiki = Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
end

# create some private and collaborated wikis
6.times do
  wiki = Wiki.create!(
    user: premium_users.sample,
    title: "Private: #{Faker::Lorem.sentence}",
    body: Faker::Lorem.paragraph,
    private: true
  )
end

wikis = Wiki.all
private_wikis = Wiki.where(private: true)

10.times do
  owner = premium_users.sample
  wiki = owner.wikis.sample
  user = User.where.not(id: owner.id).sample

  collab = Collaborator.create!(
    user: user,
    wiki: wiki
  )
end

wikis = Wiki.all
puts "#{Wiki.count} wikis created."
puts "#{User.count} users created."
puts "#{Collaborator.count} collaborators created."
