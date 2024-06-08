# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# seeds.rb

# Clear existing data
Feature.destroy_all
User.destroy_all
Vote.destroy_all
Comment.destroy_all

# Create 12 users
users = 12.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
  )
end

# Create 12 features
features = 12.times.map do
  Feature.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    status: Feature.statuses.keys.sample,
    user: users.sample
  )
end

# Create 12 votes
12.times do
  Vote.create!(
    user: users.sample,
    feature: features.sample
  ) rescue ActiveRecord::RecordInvalid # Skip if vote already exists
end

# Create 12 comments
12.times do
  Comment.create!(
    content: Faker::Lorem.sentence,
    user: users.sample,
    feature: features.sample
  )
end

puts "Seeded #{User.count} users, #{Feature.count} features, #{Vote.count} votes, and #{Comment.count} comments."
