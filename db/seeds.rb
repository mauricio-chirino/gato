# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



20.times do
  User.create!(email: Faker::Internet.email, password: 'password', name: Faker::Name.name)
end

20.times do
  Post.create!(title: Faker::Book.title, body: Faker::Lorem.paragraph, user: User.all.sample)
end

100.times do
  Comment.create!(body: Faker::Lorem.sentence, post: Post.all.sample, user: User.all.sample)
end

100.times do
  Reaction.create!(post: Post.all.sample, user: User.all.sample, like: [true, false].sample)
end