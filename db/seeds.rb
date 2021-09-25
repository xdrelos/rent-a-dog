# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

50.times do
  Dog.create!(
    name: Faker::FunnyName.name,
    breed: ["German Shepherd", "Pomeranian", "Labarador", "Husky", "Bulldog", "Poodle", "Golden Retriever", "Rottweiller", "Yorkshire"].sample,
    description: Faker::Lorem.paragraph(sentence_count: 10),
    palmares: rand(1..50),
    city: Faker::Address.city,
    age: rand(1..15),
    price_per_hour: rand(5..50),
    user_id: rand(1..2)
    )
end
