# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(user_name: Faker::Name.name)
15.times do |i|
  User.create!(user_name: Faker::Name.name)
  Poll.create!(title: Faker::Company.name, author: (i + 2))
  Question.create!(text: Faker::Hacker.say_something_smart + "?", poll_id: i + 1)
  AnswerChoice.create!(text: Faker::Hacker.noun, question_id: i + 1)
  Response.create!(user_id: i + 1, answer_id: i + 1)
end
