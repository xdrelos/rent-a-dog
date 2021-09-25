class Dog < ApplicationRecord
  belongs_to :user
  validates :name, :breed, :description, :city, :price_per_hour, presence: true
  has_one_attached :profile_picture
  has_many_attached :pictures
end
