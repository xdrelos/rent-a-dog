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
      url = "https://dog.ceo/api/breed/#{result[0]}/#{subreed}/images/random"
      file = open(url).read
      image = JSON.parse(file)
      Breed.create!(name: "#{subreed} #{result[0]}".capitalize, image: image["message"])
    end
  else
    url = "https://dog.ceo/api/breed/#{result[0]}/images/random"
    file = open(url).read
    image = JSON.parse(file)
    Breed.create!(name: result[0].capitalize, image: image["message"])
  end
end
Breed.create!(name: "Dobermann", image: "https://images.unsplash.com/photo-1556546346-ad2946663684?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2787&q=80")
Breed.create!(name: "Rottweiller", image: "https://images.unsplash.com/photo-1555786720-3be8246525f0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80")

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


