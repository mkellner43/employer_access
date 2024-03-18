# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
49.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    role: ['user', 'agent', 'admin'].sample
  )
end

User.create!(
  email: "do-not-reply@anthem.com",
  password: 'password',
  first_name: "Anthem",
  last_name: "Automated Emails",
  role: 'robot'
)

# Create 100 conversations
users = User.all
100.times do
  sender, receiver = users.sample(2)
  Conversation.create!(sender: sender, receiver: receiver, status: 'active',
                       groups: ["koch", "georgia pacific", "infor", "molex", "guardian", "sharecare"].sample)
end

# Create 1000 messages
conversations = Conversation.all
1000.times do
  conversation = conversations.sample
  user = [conversation.sender, conversation.receiver].sample
  Message.create!(content: Faker::Lorem.sentence(word_count: 10), conversation: conversation, user: user)
end
