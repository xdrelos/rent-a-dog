# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'
require 'json'

user_1 = User.new(
  first_name: "Jean",
  last_name: "Durant",
  email: "jdurant@example.com",
  username: "jdurant",
  password: "password"
)
user_1.skip_confirmation_notification!
user_1.skip_confirmation!
user_1.save!

user_2 = User.new(
  first_name: "Cecile",
  last_name: "Marchand",
  email: "cmarchand@example.com",
  username: "cmarchand",
  password: "password"
)
user_2.skip_confirmation_notification!
user_2.skip_confirmation!
user_2.save!

url = "https://dog.ceo/api/breeds/list/all"
file = open(url).read
results = JSON.parse(file)
results["message"].each do |result|
  if result[1]
    result[1].each do |subreed|
      Breed.create!(name: "#{subreed} #{result[0]}".capitalize)
    end
  else
    Breed.create!(name: result[0].capitalize)
  end
end

25.times do
  Dog.create!(
    name: Faker::FunnyName.name,
    breed: Breed.all.sample,
    description: Faker::Lorem.paragraph(sentence_count: 20),
    palmares: rand(1..50),
    city: ["Paris", "Toulouse", "Bordeaux", "Marseille", "Nice", "Toulon", "Metz", "Reims", "Caen", "Lille"].sample,
    age: rand(1..15),
    price_per_hour: rand(5..50),
    user_id: rand(1..2)
    )
end


